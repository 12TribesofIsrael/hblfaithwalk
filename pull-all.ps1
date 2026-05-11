# pull-all.ps1 - pull every sub-repo in the hblfaithwalk workspace.
#
# The workspace root itself is not a git repo (it is just a folder containing 5
# independent repos), so 'git pull' from here will fail. This script walks each
# known sub-repo and runs 'git pull --rebase --autostash' for you.
#
# Usage:
#   .\pull-all.ps1            # pull all repos
#   .\pull-all.ps1 -Status    # just show ahead/behind status, no fetch/pull

param(
    [switch]$Status
)

$repos = @(
    'AIconsultantforHmblzayy',
    'faithwalklivecom',
    'aibiblegospelscom',
    'faithwalkbook',
    'claude-memory-backup'
)

$root = $PSScriptRoot
$summary = @()

foreach ($repo in $repos) {
    $path = Join-Path $root $repo
    Write-Host ""
    Write-Host "=== $repo ===" -ForegroundColor Cyan

    if (-not (Test-Path (Join-Path $path '.git'))) {
        Write-Host "  (skipped - no .git directory)" -ForegroundColor Yellow
        $summary += [pscustomobject]@{ Repo = $repo; Result = 'skipped (no .git)' }
        continue
    }

    if ($Status) {
        git -C $path fetch --quiet 2>&1 | Out-Null
        $branchInfo = git -C $path status -sb | Select-Object -First 1
        Write-Host "  $branchInfo"
        $summary += [pscustomobject]@{ Repo = $repo; Result = $branchInfo }
    } else {
        $output = git -C $path pull --rebase --autostash 2>&1
        $output | ForEach-Object { Write-Host "  $_" }
        $result = if ($LASTEXITCODE -eq 0) {
            if ($output -match 'Already up to date') { 'up-to-date' } else { 'updated' }
        } else { 'FAILED' }
        $summary += [pscustomobject]@{ Repo = $repo; Result = $result }
    }
}

Write-Host ""
Write-Host "=== summary ===" -ForegroundColor Green
$summary | Format-Table -AutoSize
