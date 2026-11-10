#!/usr/bin/env bash
# PreToolUse hook for Bash. Exit 2 blocks the call; stderr is shown to Claude.
command=$(jq -r '.tool_input.command // empty')
if printf '%s' "$command" | grep -Eq '\bgit\b.*\b(commit|push|merge|rebase|tag|cherry-pick|am|reset)\b'; then
  echo "Blocked: commits and history changes are done by Jurek manually, after his own review." >&2
  exit 2
fi
exit 0
