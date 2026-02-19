#!/usr/bin/env bash
# SessionStart hook for freelance-finance-tracker plugin
# Injects a prompt telling Claude to check upcoming tax deadlines via Notion MCP

set -euo pipefail

# Tax Deadlines DB data source ID
DEADLINES_DB="4ce091d0-6ffd-4371-aabd-7780cba1d331"

# Calculate date window
TODAY=$(date +%Y-%m-%d)
FUTURE_14D=$(date -v+14d +%Y-%m-%d 2>/dev/null || date -d "+14 days" +%Y-%m-%d)

# Escape string for JSON embedding
escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

CONTEXT="Check for upcoming tax deadlines. Query the Tax Deadlines DB (data source: ${DEADLINES_DB}) for entries where Status is NOT \"Completed\". For each result, calculate days remaining from today (${TODAY}). Show deadlines that are within 14 days OR overdue. If there are matching deadlines, display them grouped by due date in this format:\n\n---\nTax Deadline Alert\n\n[Due Date]:\n- [Deadline name] -- [Suggested Action] (X days remaining / OVERDUE)\n\nMark as URGENT if within 3 days or overdue.\n---\n\nIf no deadlines are within 14 days and none are overdue, show nothing."

CONTEXT_ESCAPED=$(escape_for_json "$CONTEXT")

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${CONTEXT_ESCAPED}"
  }
}
EOF

exit 0
