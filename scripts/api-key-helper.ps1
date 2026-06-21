$cfg = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { (Get-Location).Path }
$file = Join-Path $cfg "settings.local.json"
$j = Get-Content -Raw $file | ConvertFrom-Json
if (-not $j.env.ANTHROPIC_AUTH_TOKEN) { exit 1 }
[Console]::Out.Write($j.env.ANTHROPIC_AUTH_TOKEN)
