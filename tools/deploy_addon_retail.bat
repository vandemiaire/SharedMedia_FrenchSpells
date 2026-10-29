@echo off
setlocal

set "SOURCE=%~dp0..\addon"
set "DEST=C:\Program Files (x86)\World of Warcraft\_retail_\Interface\AddOns\SharedMedia_FrenchSpells"

if not exist "%SOURCE%" (
	echo Source introuvable : "%SOURCE%"
	exit /b 1
)

if not exist "%DEST%" mkdir "%DEST%"

robocopy "%SOURCE%" "%DEST%" /E /NFL /NDL /NJH /NJS /NP
set "RESULT=%ERRORLEVEL%"

if %RESULT% LEQ 7 (
	echo.
	echo Addon copie vers : "%DEST%"
	exit /b 0
)

echo.
echo La copie a echoue avec le code %RESULT%.
exit /b %RESULT%
