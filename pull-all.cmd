@echo off
REM pull-all.cmd - shim around pull-all.ps1 that bypasses PowerShell execution policy.
REM Lets you just type 'pull-all' from this workspace root.
REM Pass -Status to get ahead/behind state without pulling.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0pull-all.ps1" %*
