#!/usr/bin/env sh
set -eu
CFG="${CLAUDE_CONFIG_DIR:-$PWD}"
FILE="$CFG/settings.local.json"

# Extract token from { "env": { "ANTHROPIC_AUTH_TOKEN": "..." } }
TOKEN=$(sed -nE 's/.*"ANTHROPIC_AUTH_TOKEN"[[:space:]]*:[[:space:]]*"([^"]*)".*/\1/p' "$FILE" | head -n1)
[ -n "$TOKEN" ] || exit 1
printf "%s" "$TOKEN"
