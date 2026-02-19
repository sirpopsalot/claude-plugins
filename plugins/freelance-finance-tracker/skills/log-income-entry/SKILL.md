---
name: log-income-entry
description: Parse a payment notification and create a structured entry in the Notion Income database. Use when the user reports receiving a payment, getting paid, or mentions income from a client. Triggers on phrases like "I got paid", "received payment", "Brightway paid me", "got a deposit", or any mention of client payments.
version: 1.0.0
---

# Log Income Entry

## Overview

Parses an income notification (email text or manual input) and creates a structured entry in the Notion Income database.

## Known Clients and Platforms

- **Brightway** — AI Consulting. Invoiced, paid via direct deposit.
- **Handshake AI** — AI Data Generalist. Paid through Deel, direct deposit.
- **David AI (Babel Audio)** — AI Data Generalist. Paid through Dots, direct deposit.

New clients may be added over time. If an unrecognized client is mentioned, ask to confirm details.

## Step-by-Step Logic

1. Parse the input for: amount, client name, date, platform.
2. Match client to known clients (Brightway, Handshake AI, David AI) or flag as new.
3. Auto-fill platform based on client (Brightway = direct deposit, Handshake AI = Deel, David AI = Dots).
4. Ask for any missing required fields.
5. Create the Notion Income DB entry with fields: Date, Client, Amount, Platform, Invoice #, Project, Hours, Base/Bonus, Status.
6. Remind user to transfer 30% to tax savings account.

## Example Inputs

- "I just got paid $3,200 from Brightway for the January engagement."
- "Deel deposited $1,500 from Handshake AI."
- "Got $800 from a new client called Acme Corp."

## Integrations

Notion MCP (write to Income DB).
