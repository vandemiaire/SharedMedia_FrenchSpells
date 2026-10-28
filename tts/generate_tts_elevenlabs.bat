@echo off
echo Generation TTS avec ElevenLabs...
echo.
powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0generate_tts_elevenlabs.ps1"
