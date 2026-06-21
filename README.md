# Claude Hub

A portable Claude Code configuration and skills library. Keep your Claude Code
settings and skills in one Git repo, then clone it on any machine to reproduce
the same setup.

Claude Code reads config from the directory set by `CLAUDE_CONFIG_DIR`.

## 1. Install Claude Code

- Docs: https://code.claude.com/docs
- Install: `npm install -g @anthropic-ai/claude-code`

## 2. Point Claude Code to this repo

Set `CLAUDE_CONFIG_DIR` to this repository's absolute path.

### macOS (zsh)

Add to `~/.zshrc`:

```bash
export CLAUDE_CONFIG_DIR="$HOME/Documents/path/to/claude-hub"
```

### Windows (PowerShell)

Replace the path with your real absolute path, then run:

```powershell
[System.Environment]::SetEnvironmentVariable("CLAUDE_CONFIG_DIR", "D:\path-to\claude-hub", "User")
```

Optional — verify it's set:

```bash
echo $CLAUDE_CONFIG_DIR   # PowerShell: [System.Environment]::GetEnvironmentVariable("CLAUDE_CONFIG_DIR", "User")
```

## 3. Configure API access

Shared defaults live in `settings.json`.

Machine-local API credentials should go in `settings.local.json` (git-ignored).
Create it from the example file:

```bash
cp settings.local.example.json settings.local.json
```

Or on Windows PowerShell:

```powershell
Copy-Item .\settings.local.example.json .\settings.local.json
```

Then edit `settings.local.json` and set:

- `ANTHROPIC_AUTH_TOKEN` — your auth token for compatible gateways

`settings.json` reads the token through `apiKeyHelper`, so secrets stay out of the
shared config.

See env var docs: https://code.claude.com/docs/en/env-vars

## 4. Reinstall plugins on a new machine

This repo can declare shared plugins in the `enabledPlugins` block of
`settings.json`. The helper script reads that project config and reinstalls
every enabled plugin.

Dry run:

```sh
./scripts/install-claude-plugins.sh --dry-run
```

Install all plugins from the project config:

```sh
./scripts/install-claude-plugins.sh
```

Windows:

- Use Git Bash (recommended) or WSL to run this `.sh` script.
- In Git Bash, `cd` to the repository root and run the same commands:

```sh
./scripts/install-claude-plugins.sh --dry-run
./scripts/install-claude-plugins.sh
```

- If launching from PowerShell, start Git Bash first (or invoke your local
	`bash.exe` path), then run the commands above inside that shell.

The script uses `jq` when available and falls back to `node` if not.

On Windows, PowerShell cannot execute `.sh` scripts directly.

On another machine, clone this repo, point `CLAUDE_CONFIG_DIR` at it, then run
the script to install the plugins declared in the project config.
