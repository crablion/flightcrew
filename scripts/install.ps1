# Flightcrew installer for Windows PowerShell
# Usage: powershell -ExecutionPolicy Bypass -File install.ps1 [-Target <project-dir>]
# Installs Flightcrew skills, crew agents, and templates into a project for
# VS Code (GitHub Copilot) and Claude Code.
# Safe to re-run: changed files are backed up with a .bak suffix before being replaced,
# and nothing under .flightcrew\flights or your manual is ever touched.

param(
    [string]$Target = "."
)

$ErrorActionPreference = "Stop"

$Src = Split-Path -Parent $PSScriptRoot
$Target = (Resolve-Path $Target).Path

if (-not (Test-Path (Join-Path $Target ".git"))) {
    Write-Host "Warning: $Target is not a git repository. Flightcrew works best inside one."
}

function Copy-FcFile($From, $To) {
    $dir = Split-Path -Parent $To
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    if (Test-Path $To) {
        $same = (Get-FileHash $From).Hash -eq (Get-FileHash $To).Hash
        if (-not $same) {
            Copy-Item $To "$To.bak" -Force
            Write-Host "  backed up $To -> $To.bak"
        }
    }
    Copy-Item $From $To -Force
}

Write-Host "Installing Flightcrew into $Target"

Write-Host "- Skills (VS Code Copilot: .github\skills, Claude Code: .claude\skills)"
Get-ChildItem (Join-Path $Src "skills") -Directory -Filter "fc-*" | ForEach-Object {
    $skill = Join-Path $_.FullName "SKILL.md"
    Copy-FcFile $skill (Join-Path $Target ".github\skills\$($_.Name)\SKILL.md")
    Copy-FcFile $skill (Join-Path $Target ".claude\skills\$($_.Name)\SKILL.md")
}

Write-Host "- Crew agents (VS Code Copilot: .github\agents, Claude Code: .claude\agents)"
Get-ChildItem (Join-Path $Src "agents\copilot") -Filter "*.agent.md" | ForEach-Object {
    Copy-FcFile $_.FullName (Join-Path $Target ".github\agents\$($_.Name)")
}
Get-ChildItem (Join-Path $Src "agents\claude") -Filter "*.md" | ForEach-Object {
    Copy-FcFile $_.FullName (Join-Path $Target ".claude\agents\$($_.Name)")
}

Write-Host "- Templates"
Get-ChildItem (Join-Path $Src "templates") -Filter "*.md" | ForEach-Object {
    Copy-FcFile $_.FullName (Join-Path $Target ".flightcrew\templates\$($_.Name)")
}

New-Item -ItemType Directory -Path (Join-Path $Target ".flightcrew\flights") -Force | Out-Null

Write-Host ""
Write-Host "Flightcrew is installed. Cleared for takeoff."
Write-Host ""
Write-Host "Next, in VS Code Copilot Chat (agent mode) or Claude Code:"
Write-Host "  /fc-manual                 set up your ops manual"
Write-Host "  /fc-survey                 existing codebase? map it first"
Write-Host "  /fc-flightplan <intent>    start your first flight"
