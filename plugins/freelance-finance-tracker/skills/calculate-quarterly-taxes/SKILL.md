---
name: calculate-quarterly-taxes
description: Calculate quarterly estimated taxes for a freelancer. Use when the user asks about quarterly taxes, estimated tax payments, how much they owe, tax deadlines, or mentions Q1/Q2/Q3/Q4 taxes. Triggers on phrases like "calculate my taxes", "how much do I owe", "quarterly estimate", "tax payment", or any reference to IRS estimated payments or California state taxes.
version: 1.0.0
---

# Calculate Quarterly Estimated Taxes

## Overview

Pulls YTD income and expenses from Notion, runs the federal + state + self-employment tax math, subtracts prior quarterly payments, and tells the user what to pay.

## Quarterly Deadlines

- **Q1**: April 15
- **Q2**: June 15
- **Q3**: September 15
- **Q4**: January 15 (following year)

## Filing Details

- **Filing status**: Single
- **State**: California
- **Filing method**: Self-filed via TurboTax

## Notion Databases

- **Income DB**: All freelance payments received (Date, Client, Amount, Platform, Invoice #, Project, Hours, Base/Bonus, Status)
- **Expense DB**: All business expenses (Date, Vendor, Amount, Category, Payment Method, Business Use %, Notes, Receipt Link)
- **Tax Payments DB**: Prior quarterly payments (Quarter, Payment Date, Federal Amount, State Amount, Confirmation #, Status)

## Step-by-Step Calculation

1. Query Notion Income DB for all entries in the current tax year. Sum total gross income.
2. Query Notion Expense DB for all entries in the current tax year. Sum total deductible expenses.
3. Calculate net profit (income minus expenses).
4. Calculate self-employment tax: 92.35% of net profit x 15.3%.
5. Calculate the deductible half of SE tax.
6. Calculate adjusted gross income (net profit minus half of SE tax).
7. Apply standard deduction for the current tax year.
8. Apply federal income tax brackets to taxable income.
9. Apply California state tax brackets.
10. Sum federal income tax + SE tax + CA tax for total annual estimate.
11. Divide by 4 for quarterly amount.
12. Query Tax Payments DB and subtract prior quarterly payments already made.
13. Output amounts due for federal and state with payment instructions.

## 2026 Federal Income Tax Brackets (Single)

| Taxable Income | Rate |
|---|---|
| $0 - $11,925 | 10% |
| $11,926 - $48,475 | 12% |
| $48,476 - $103,350 | 22% |
| $103,351 - $197,300 | 24% |
| $197,301 - $250,525 | 32% |
| $250,526 - $626,350 | 35% |
| Over $626,350 | 37% |

**Standard deduction (2026, Single)**: $15,000

## 2026 California State Tax Brackets (Single)

| Taxable Income | Rate |
|---|---|
| $0 - $10,756 | 1% |
| $10,757 - $25,499 | 2% |
| $25,500 - $40,245 | 4% |
| $40,246 - $55,866 | 6% |
| $55,867 - $70,612 | 8% |
| $70,613 - $360,659 | 9.3% |
| $360,660 - $432,787 | 10.3% |
| $432,788 - $721,314 | 11.3% |
| $721,315 - $1,000,000 | 12.3% |
| Over $1,000,000 | 13.3% |

## Self-Employment Tax Formula

- SE taxable amount = Net profit x 92.35%
- SE tax = SE taxable amount x 15.3% (12.4% Social Security + 2.9% Medicare)
- Deductible half = SE tax / 2

## Output Format

Present results clearly:

1. **Gross income** (YTD)
2. **Total expenses** (YTD)
3. **Net self-employment income**
4. **Self-employment tax**
5. **Federal income tax estimate**
6. **California state tax estimate**
7. **Total annual tax estimate**
8. **Quarterly amount due**
9. **Prior payments made** (from Tax Payments DB)
10. **Amount due this quarter** (federal and state separately)
11. **Payment instructions**: IRS Direct Pay (irs.gov/directpay) for federal, FTB (ftb.ca.gov) for California

## After Calculation

Remind the user to:
- Transfer 30% of any new income to their tax savings account
- Record confirmation numbers after making payments so the Tax Payments DB stays current
