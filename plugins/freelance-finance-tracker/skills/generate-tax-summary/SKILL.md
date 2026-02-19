---
name: generate-tax-summary
description: Generate an annual financial summary formatted for TurboTax Schedule C entry. Use when the user asks about tax-time reports, annual summaries, Schedule C, TurboTax prep, year-end financials, or 1099 cross-referencing. Triggers on phrases like "generate my tax summary", "prepare for TurboTax", "year-end report", "annual summary", or "1099 check".
version: 1.0.0
---

# Generate Tax-Time Summary

## Overview

Generates an annual financial summary from Notion databases, formatted for TurboTax Schedule C entry. Invoke at tax time or whenever a financial summary is needed.

## Inputs

- Tax year
- Notion Income DB data
- Notion Expense DB data
- Quarterly estimated tax payments
- Home office square footage and total home square footage
- 1099-NEC amounts (for cross-referencing)

## Step-by-Step Logic

1. Query Notion Income DB for all entries in the tax year, group by client, calculate totals.
2. Query Notion Expense DB for the tax year, map to IRS Schedule C categories, calculate totals.
3. Calculate net profit.
4. Calculate home office deduction (simplified method: $5/sq ft, max 300 sq ft).
5. Query quarterly tax payments made.
6. Cross-reference income totals against 1099-NEC forms, flag discrepancies.
7. Format into TurboTax Schedule C sections.

## IRS Schedule C Category Mapping

| Expense Category | Schedule C Line |
|---|---|
| Software/Subscriptions | Line 18 (Office expenses) |
| Hardware | Line 13 (Depreciation) |
| Office Supplies | Line 18 (Office expenses) |
| Professional Development | Line 27a (Other expenses) |
| Professional Memberships | Line 27a (Other expenses) |
| Home Office | Line 30 (Business use of home) |
| Marketing | Line 8 (Advertising) |
| Travel | Line 24a (Travel) |

## Output Format

Present a clean summary organized by TurboTax Schedule C sections:
- Gross income (grouped by client with totals)
- Expenses by category (mapped to Schedule C lines)
- Net profit
- Home office deduction
- Estimated tax payments made
- 1099-NEC cross-reference (with any discrepancies flagged)

## Integrations

Notion MCP (read Income DB, Expense DB, Payments DB). No external APIs needed.
