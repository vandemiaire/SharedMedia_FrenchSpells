@echo off
echo Generating SharedMedia sound registrations...
echo.
powershell.exe -ExecutionPolicy Bypass -File "%~dp0sound_registration.ps1"
