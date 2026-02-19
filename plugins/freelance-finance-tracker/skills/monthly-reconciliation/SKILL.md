---
name: monthly-reconciliation
description: Generate a monthly financial summary from Notion for verification against bank and credit card statements. Use when the user asks for a monthly check-in, reconciliation, month-end review, or wants to verify their numbers. Triggers on phrases like "monthly reconciliation", "end of month check", "reconcile January", "how did I do this month", or "check my numbers".
version: 1.0.0
---

# Monthly Reconciliation

## Overview

Generates a monthly financial summary from Notion for quick verification against bank and credit card statements. Flags anomalies and missing recurring items.

## Step-by-Step Logic

1. Query Notion Income DB for the target month, list all entries and sum total.
2. Query Notion Expense DB for the target month, group by category, list entries and sum totals.
3. Compare against expected recurring items (known subscriptions, regular client payments).
4. Flag anything missing or unusual (e.g., a recurring subscription that didn't show up, an unusually large expense).
5. Present summary and ask user to verify against bank and credit card statements.

## Output Format

**Monthly Summary — [Month Year]**

**Income**
- List each entry with date, client, amount
- Total income for the month

**Expenses by Category**
- Group entries by category
- Show subtotals per category
- Total expenses for the month

**Net Income**
- Income minus expenses

**Anomaly Flags**
- Missing recurring items
- Unusual amounts
- New vendors or clients

**Action Required**
- Ask user to verify totals against bank/card statements
- Note any items that need follow-up

## Integrations

Notion MCP (read Income DB, Expense DB).
