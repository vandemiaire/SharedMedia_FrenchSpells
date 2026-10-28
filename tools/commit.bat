@echo off
if "%~1"=="" (
    echo Usage: commit.bat "Your commit message"
    exit /b 1
)
cd /d "%~dp0.."
git add -A
git commit -m "%~1"
git push
