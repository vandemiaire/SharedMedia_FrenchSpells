@echo off
REM Script de lancement pour la generation TTS avec LuvVoice
REM ========================================================

echo.
echo ================================================
echo   Generation TTS avec LuvVoice API
echo ================================================
echo.

REM Demander le token API
set /p API_TOKEN="Entrez votre token API LuvVoice: "

if "%API_TOKEN%"=="" (
	echo.
	echo ERREUR: Le token API est obligatoire.
	echo.
	pause
	exit /b 1
)

echo.
echo Lancement de la generation...
echo.

REM Lancer le script PowerShell
powershell.exe -ExecutionPolicy Bypass -File "%~dp0generate_tts_luvvoice.ps1" -ApiToken "%API_TOKEN%"

echo.
echo ================================================
echo   Terminé
echo ================================================
echo.
pause
