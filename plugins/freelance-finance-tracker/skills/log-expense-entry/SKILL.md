---
name: log-expense-entry
description: Parse a receipt or expense description and create a structured entry in the Notion Expense database. Use when the user reports a business expense, purchase, subscription, or receipt. Triggers on phrases like "log this expense", "I paid for", "bought", "subscription", "receipt for", or any mention of business purchases.
version: 1.0.0
---

# Log Expense Entry

## Overview

Parses a receipt or expense description and creates a structured entry in the Notion Expense database with auto-suggested category.

## Expense Categories

- Software/Subscriptions
- Hardware
- Office Supplies
- Professional Development
- Professional Memberships
- Home Office
- Marketing
- Travel
- Other

## Step-by-Step Logic

1. Parse input for: vendor, amount, date, payment method.
2. Auto-suggest expense category from the list above.
3. Default business use to 100% unless flagged as mixed-use.
4. Ask for confirmation or corrections.
5. Create the Notion Expense DB entry with fields: Date, Vendor, Amount, Category, Payment Method, Business Use %, Notes, Receipt Link.

## Example Inputs

- "Log this expense: $20/month Claude Pro subscription, paid with personal credit card."
- "Bought a $1,200 MacBook charger on Amazon."
- "Paid $500 for an online AI certification course."

## Integrations

Notion MCP (write to Expense DB).
