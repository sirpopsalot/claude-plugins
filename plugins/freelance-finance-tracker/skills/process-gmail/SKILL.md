---
name: process-gmail
description: Read emails labeled `biz-income-expense` in Gmail, parse each into a structured income or expense entry, create Notion entries, and relabel as processed. Use when the user says "process gmail", "check my email labels", "import emails", or mentions the biz-income-expense label.
version: 1.0.0
---

# Process Gmail Labels

## Overview

Reads all Gmail emails labeled `biz-income-expense`, classifies each as income or expense, parses structured financial data, creates entries in the appropriate Notion database, and relabels processed emails as `biz-income-expense/processed`. Emails dated before the backlog cutoff are swept (relabeled without creating entries) to avoid duplicating manually-loaded data.

## Configuration

| Key | Value |
|-----|-------|
| Backlog cutoff date | `2026-02-19` |
| Gmail label (unprocessed) | `biz-income-expense` |
| Gmail label (processed) | `biz-income-expense/processed` |
| Income DB data source | `59a12b61-e897-4a3e-afff-c40df0b6f65c` |
| Expense DB data source | `d7dcf171-9bb2-44f9-80d2-de44bec91b77` |

## Known Clients

Map sender/platform to client details for auto-fill:

| Sender / Platform | Client | Payment Method | Payment Type | Projects |
|-------------------|--------|----------------|--------------|----------|
| `payments@stripe.com` / Stripe | Handshake AI | Direct deposit (via Stripe) | Task-based | — |
| `notifications@deel.com` / Deel | Handshake AI (legacy) | Direct deposit (via Deel) | Task-based | — |
| `noreply@dots.dev` / Dots | David AI (Babel) | Direct deposit (via Dots) | Task-based | EE2E, EE3, 2-speaker, Video 2-speaker |
| BrightWay AI | BrightWay AI | Direct deposit | Varies | SRM-25, NL-25, HLT |
| ForFounder | ForFounder | Ask user if unclear | Hourly | — |

## Expense Categories

- Software/Subscriptions
- Hardware
- Office Supplies
- Professional Development
- Professional Memberships
- Home Office
- Marketing
- Travel

## Step-by-Step Logic

1. **Get label IDs.** Call `get_or_create_label` for `biz-income-expense` and `biz-income-expense/processed`. Cache both label IDs.

2. **Search for unprocessed emails.** Call `search_emails` with query `label:biz-income-expense -label:biz-income-expense/processed`.

3. **No results?** Display "No unprocessed emails found." and exit.

4. **For each email**, call `read_email` to get the full content (subject, sender, date, body).

5. **Check date against backlog cutoff** (`2026-02-19`):
   - If the email date is **before** the cutoff → call `modify_email` to add `biz-income-expense/processed` label and remove `biz-income-expense` label. Increment swept count. **Skip** to next email.

6. **Classify** as income or expense based on sender and content:
   - Known payment senders (Stripe, Deel, Dots, BrightWay, ForFounder) → **Income**
   - Receipts, invoices from vendors, subscription confirmations → **Expense**
   - Unclear → flag as **unparseable**, skip to next email

7. **Parse structured data** from the email:
   - **Income**: amount, date received, client, project (if identifiable), payment method, payment type, hours (if mentioned)
   - **Expense**: amount, date, vendor, description, category (auto-suggest from list above), business use % (default 100%)

8. **Validate**: amount must be > $0, date must be parseable. If validation fails, flag as unparseable.

9. **Create Notion entry** via `notion-create-pages`:
   - **Income** → data source `59a12b61-e897-4a3e-afff-c40df0b6f65c`
     - Status: "Needs Review" (payment received) or "Invoiced" (for sent invoice notifications)
     - Set "Date received" for payments, leave blank for invoices
     - Auto-fill payment method and type from Known Clients table
   - **Expense** → data source `d7dcf171-9bb2-44f9-80d2-de44bec91b77`
     - Status: "Needs Review"
     - Business use %: pass `1` for 100%, `0.5` for 50% (Notion percent format)

10. **Relabel processed email.** Call `modify_email` to add `biz-income-expense/processed` label and remove `biz-income-expense` label.

11. **Do NOT relabel unparseable emails.** Leave them with `biz-income-expense` for manual review.

12. **Display summary** (see format below).

## Summary Format

After processing all emails, display:

```
## Gmail Processing Summary
- Emails found: X
- Entries created: Y (Z income / W expense)
- Income total: $X,XXX.XX
- Expense total: $X,XXX.XX
- Backlog swept (pre-cutoff): N
- Unparseable: M

| Type | Client/Vendor | Amount | Date | Status |
|------|---------------|--------|------|--------|
| Income | Handshake AI | $450.00 | 2026-02-20 | Needs Review |
| Expense | Adobe | $54.99 | 2026-02-21 | Needs Review |
```

If there are unparseable emails:

```
### Needs Manual Review
1. "Subject line here" — Reason (e.g., "Could not determine amount" or "Unknown sender, unclear if income or expense")
```

## Integrations

- **Gmail MCP**: `search_emails`, `read_email`, `modify_email`, `get_or_create_label`
- **Notion MCP**: `notion-create-pages` (Income DB: `59a12b61-e897-4a3e-afff-c40df0b6f65c`, Expense DB: `d7dcf171-9bb2-44f9-80d2-de44bec91b77`)
