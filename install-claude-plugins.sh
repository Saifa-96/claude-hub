#!/usr/bin/env sh

set -eu

if [ -z "${BASH_VERSION:-}${ZSH_VERSION:-}${POSH_VERSION:-}" ] && [ "${OS:-}" = "Windows_NT" ]; then
  echo "This script must be run from a POSIX shell such as Git Bash, WSL, or macOS/Linux sh." >&2
  echo "PowerShell cannot execute .sh scripts directly." >&2
  exit 1
fi

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SETTINGS_PATH="$SCRIPT_DIR/settings.json"
DRY_RUN=${DRY_RUN:-0}

case "${1:-}" in
  --dry-run)
    DRY_RUN=1
    ;;
esac

if [ ! -f "$SETTINGS_PATH" ]; then
  echo "Settings file not found: $SETTINGS_PATH" >&2
  exit 1
fi

if command -v jq >/dev/null 2>&1; then
  PLUGINS=$(jq -r '.enabledPlugins // {} | to_entries[] | select(.value == true) | .key' "$SETTINGS_PATH")
else
  PLUGINS=$(node -e "const fs=require('fs'); const path=process.argv[1]; const data=JSON.parse(fs.readFileSync(path,'utf8')); const plugins=Object.entries(data.enabledPlugins||{}).filter(([,enabled])=>enabled===true).map(([name])=>name); console.log(plugins.join('\\n'));" "$SETTINGS_PATH")
fi

if [ -z "$PLUGINS" ]; then
  echo "No enabled plugins found in settings."
  exit 0
fi

COUNT=$(printf '%s\n' "$PLUGINS" | sed '/^$/d' | wc -l | tr -d ' ')
echo "Found $COUNT enabled plugin(s) in $SETTINGS_PATH"

printf '%s\n' "$PLUGINS" | while IFS= read -r plugin; do
  [ -n "$plugin" ] || continue

  if [ "$DRY_RUN" = "1" ]; then
    echo "claude plugin install $plugin"
    continue
  fi

  echo "Installing $plugin"
  claude plugin install "$plugin"
done
