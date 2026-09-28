[CmdletBinding()]
param()

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "Uninstalling pstack from Antigravity..." -ForegroundColor Yellow

$targetPluginDir = Join-Path $HOME ".gemini\config\plugins\pstack"
$configFile = Join-Path $HOME ".gemini\config\config.json"

if (Test-Path $targetPluginDir) {
    Remove-Item -Recurse -Force $targetPluginDir -ErrorAction SilentlyContinue
    Write-Host "Removed plugin directory: $targetPluginDir" -ForegroundColor Green
}

if (Test-Path $configFile) {
    try {
        $cfg = Get-Content $configFile -Raw | ConvertFrom-Json
        if ($cfg.plugins -and $cfg.plugins.pstack) {
            $cfg.plugins.pstack.enabled = $false
            $updated = $cfg | ConvertTo-Json -Depth 10
            [System.IO.File]::WriteAllText($configFile, $updated, [System.Text.Encoding]::UTF8)
            Write-Host "Disabled pstack in config.json." -ForegroundColor Green
        }
    } catch {}
}

Write-Host "pstack uninstalled successfully." -ForegroundColor Green