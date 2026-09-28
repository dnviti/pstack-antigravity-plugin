[CmdletBinding()]
param(
    [switch]$Force
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "   pstack for Antigravity & Gemini Installer        " -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

$geminiConfigDir = Join-Path $HOME ".gemini\config"
$pluginsDir = Join-Path $geminiConfigDir "plugins"
$targetPluginDir = Join-Path $pluginsDir "pstack"
$configFile = Join-Path $geminiConfigDir "config.json"
$globalGeminiMd = Join-Path $HOME ".gemini\GEMINI.md"

# 1. Determine source: local folder or remote download
$scriptDir = $PSScriptRoot
$isLocalSource = ($scriptDir -and (Test-Path (Join-Path $scriptDir "plugin.json")) -and (Test-Path (Join-Path $scriptDir "skills")))
$tempDir = $null

if ($isLocalSource) {
    $sourceDir = $scriptDir
    Write-Host "[1/5] Using local installation files from: $sourceDir" -ForegroundColor Green
} else {
    Write-Host "[1/5] Running in remote mode. Fetching repository..." -ForegroundColor Yellow
    $tempDir = Join-Path $env:TEMP ("pstack_install_" + [System.Guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    
    if (Get-Command git -ErrorAction SilentlyContinue) {
        git clone --depth 1 https://github.com/dnviti/pstack-antigravity-plugin.git $tempDir 2>$null | Out-Null
    } else {
        $zipPath = Join-Path $tempDir "repo.zip"
        Invoke-WebRequest -Uri "https://github.com/dnviti/pstack-antigravity-plugin/archive/refs/heads/main.zip" -OutFile $zipPath
        Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force
        $expanded = Join-Path $tempDir "pstack-antigravity-plugin-main"
        if (Test-Path $expanded) {
            $tempDir = $expanded
        }
    }
    $sourceDir = $tempDir
    Write-Host "      Downloaded pstack repository successfully." -ForegroundColor Green
}

# 2. Deploy files to ~/.gemini/config/plugins/pstack
Write-Host "[2/5] Deploying plugin files to: $targetPluginDir" -ForegroundColor Cyan
if (-not (Test-Path $targetPluginDir)) {
    New-Item -ItemType Directory -Path $targetPluginDir -Force | Out-Null
}

$itemsToCopy = @("skills", "agents", "automations", "docs", "assets", "rules", "scripts", "plugin.json", "hooks.json", "LICENSE")
foreach ($item in $itemsToCopy) {
    $srcItem = Join-Path $sourceDir $item
    if (Test-Path $srcItem) {
        Copy-Item -Path $srcItem -Destination $targetPluginDir -Recurse -Force
    }
}
$skillsCount = (Get-ChildItem -Directory (Join-Path $targetPluginDir 'skills')).Count
Write-Host "      Deployed $skillsCount skills and 23 task playbooks." -ForegroundColor Green

# 3. Enable plugin in ~/.gemini/config/config.json
Write-Host "[3/5] Enabling pstack in $configFile..." -ForegroundColor Cyan
if (Test-Path $configFile) {
    try {
        $cfgJson = Get-Content -Path $configFile -Raw | ConvertFrom-Json
        if (-not $cfgJson.plugins) {
            $cfgJson | Add-Member -NotePropertyName "plugins" -NotePropertyValue (New-Object PSObject)
        }
        if (-not $cfgJson.plugins.pstack) {
            $cfgJson.plugins | Add-Member -NotePropertyName "pstack" -NotePropertyValue (New-Object PSObject)
        }
        if (-not $cfgJson.plugins.pstack.enabled) {
            $cfgJson.plugins.pstack | Add-Member -NotePropertyName "enabled" -NotePropertyValue $true -Force
        } else {
            $cfgJson.plugins.pstack.enabled = $true
        }
        $updatedJson = $cfgJson | ConvertTo-Json -Depth 10
        [System.IO.File]::WriteAllText($configFile, $updatedJson, [System.Text.Encoding]::UTF8)
        Write-Host "      Plugin 'pstack' enabled in config.json." -ForegroundColor Green
    } catch {
        Write-Warning "Failed to update config.json: $_"
    }
} else {
    $newConfig = @{
        plugins = @{
            pstack = @{
                enabled = $true
            }
        }
    }
    New-Item -ItemType Directory -Path $geminiConfigDir -Force | Out-Null
    [System.IO.File]::WriteAllText($configFile, ($newConfig | ConvertTo-Json -Depth 5), [System.Text.Encoding]::UTF8)
    Write-Host "      Created config.json and enabled pstack." -ForegroundColor Green
}

# 4. Enforce automatic Poteto Mode in ~/.gemini/GEMINI.md
Write-Host "[4/5] Enforcing automatic Poteto Mode in $globalGeminiMd..." -ForegroundColor Cyan
$ruleFile = Join-Path $targetPluginDir "rules\AGENTS.md"
$ruleContent = ""
if (Test-Path $ruleFile) {
    $ruleContent = [System.IO.File]::ReadAllText($ruleFile, [System.Text.Encoding]::UTF8)
}

$existingGeminiMd = ""
if (Test-Path $globalGeminiMd) {
    $existingGeminiMd = [System.IO.File]::ReadAllText($globalGeminiMd, [System.Text.Encoding]::UTF8)
}

if ($existingGeminiMd -notmatch "Pstack & Poteto Mode Engineering Rules") {
    $updatedMd = $existingGeminiMd.TrimEnd() + "`n`n" + $ruleContent
    [System.IO.File]::WriteAllText($globalGeminiMd, $updatedMd, [System.Text.Encoding]::UTF8)
    Write-Host "      Appended Poteto Mode global rules to GEMINI.md." -ForegroundColor Green
} else {
    Write-Host "      Poteto Mode global rules already present in GEMINI.md." -ForegroundColor Green
}

# 5. Verification checks
Write-Host "[5/5] Running verification checks..." -ForegroundColor Cyan
$preInvocationScript = Join-Path $targetPluginDir "scripts\pre-invocation.ps1"
if (Test-Path $preInvocationScript) {
    $hookOutput = & $preInvocationScript | ConvertFrom-Json
    if ($hookOutput.injectSteps) {
        Write-Host "      PreInvocation lifecycle hook verified." -ForegroundColor Green
    }
}

if ($tempDir -and (Test-Path $tempDir)) {
    Remove-Item -Recurse -Force $tempDir -ErrorAction SilentlyContinue
}

Write-Host "====================================================" -ForegroundColor Green
Write-Host "   pstack installed and active on Antigravity!       " -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Poteto Mode is now automatically enabled for all chats." -ForegroundColor Yellow
Write-Host "No manual commands required. Rigorous workflows active." -ForegroundColor Yellow