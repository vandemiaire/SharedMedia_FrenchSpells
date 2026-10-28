@echo off
echo Generating SharedMedia sound registrations...
echo.
powershell.exe -ExecutionPolicy Bypass -File "%~dp0generate_sounds.ps1"
