$env:PYTHONIOENCODING = 'utf-8'
$out = & python -m mempalace mine "C:/Users/georg/.claude/projects/h--DevWork-Win-Apps-GK-Mac-Opener" --mode convos --wing gk_mac_opener 2>&1 | Out-String
$m = [regex]::Match($out, 'Drawers filed: (\d+)')
$n = if ($m.Success) { $m.Groups[1].Value } else { '0' }
$msg = "MemPalace: $n new drawers filed into gk_mac_opener."
@{ hookSpecificOutput = @{ hookEventName = "Stop"; additionalContext = $msg } } | ConvertTo-Json -Compress
