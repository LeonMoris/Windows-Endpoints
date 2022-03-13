# Quick Assist
Write-Host "Creating Quick Assist icon on desktop..."
$TargetFile = "$env:SystemRoot\System32\quickassist.exe"
$ShortcutFile = "$env:Public\Desktop\quickassist.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()
func_sleep
