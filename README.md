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
[System.Environment]::SetEnvironmentVariable("CLAUDE_CONFIG_DIR", "D:\Workspace\claude-hub", "User")
```

Optional — verify it's set:

```bash
echo $CLAUDE_CONFIG_DIR   # PowerShell: [System.Environment]::GetEnvironmentVariable("CLAUDE_CONFIG_DIR", "User")
```

## 3. Configure API access

API URL and key live in the `env` block of `settings.local.json`, which is
git-ignored so your key never gets committed. Create it from the example:

```bash
cp settings.local.example.json settings.local.json
```

Then edit `settings.local.json` and fill in your values:

- `ANTHROPIC_BASE_URL` — API endpoint (the official URL, or a proxy/gateway)
- `ANTHROPIC_AUTH_TOKEN` — your auth token (use `ANTHROPIC_API_KEY` instead for the official Anthropic API)

`settings.local.json` merges over `settings.json` at runtime. See the env-vars
docs: https://code.claude.com/docs/en/env-vars
