$ErrorActionPreference = 'SilentlyContinue'
$env:PYTHONIOENCODING = 'utf-8'

$wing       = 'gk_mac_opener'
$projectDir = 'C:/Users/georg/.claude/projects/h--DevWork-Win-Apps-GK-Mac-Opener'

$out = & python -m mempalace mine $projectDir --mode convos --wing $wing 2>&1 | Out-String
$m   = [regex]::Match($out, 'Drawers filed: (\d+)')
$n   = if ($m.Success) { $m.Groups[1].Value } else { '0' }
$msg = "MemPalace: $n new drawers filed into $wing."

try {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    $notify          = New-Object System.Windows.Forms.NotifyIcon
    $notify.Icon     = [System.Drawing.SystemIcons]::Information
    $notify.BalloonTipTitle = 'MacMount — Session Saved'
    $notify.BalloonTipText  = $msg
    $notify.Visible  = $true
    $notify.ShowBalloonTip(5000)
    Start-Sleep -Milliseconds 200
    $notify.Dispose()
} catch { }

@{ hookSpecificOutput = @{ hookEventName = 'Stop'; additionalContext = $msg } } | ConvertTo-Json -Compress
