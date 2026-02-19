# Freelance Finance Tracker

A Claude Code plugin for freelance finance tracking and quarterly tax estimation with Notion integration.

## What it does

- Calculates quarterly estimated taxes (federal + California + self-employment)
- Pulls income and expense data from Notion databases
- Provides payment instructions for IRS Direct Pay and California FTB
- Includes a Gmail-scanning agent for finding freelance financial transactions

## Installation

Add this marketplace to Claude Code:

```
/plugin marketplace add sirpopsalot/freelance-finance-tracker
```

Then install the plugin:

```
/plugin install freelance-finance-tracker@freelance-finance-tracker
```

## Setup

This plugin requires a Notion integration token. Set the `NOTION_TOKEN` environment variable:

```bash
export NOTION_TOKEN=your_notion_token_here
```

## Distribution

### Private (personal use)

Install directly from this repo — no additional configuration needed.

### Team/Organization

Add to your project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "freelance-finance-tracker": {
      "source": {
        "source": "github",
        "repo": "sirpopsalot/freelance-finance-tracker"
      }
    }
  }
}
```

Team members will be prompted to install the plugin when they open the project.

### Public

Share the install command:

```
/plugin marketplace add sirpopsalot/freelance-finance-tracker
```

## Project Structure

```
freelance-finance-tracker/
├── .claude-plugin/
│   ├── plugin.json              # Plugin manifest
│   └── marketplace.json         # Marketplace metadata
├── skills/
│   └── calculate-quarterly-taxes/
│       └── SKILL.md             # Tax calculation skill
├── agents/
│   └── freelance-finance-tracker.md  # Gmail scanning agent
├── docs/
│   ├── workflow/                # Workflow design documents
│   └── plans/                   # Implementation plans
├── specs/                       # Feature specifications
├── .mcp.json                    # Notion MCP config
└── README.md
```

## License

MIT
