# Script de generation TTS avec ElevenLabs
# Qualite premium pour les sorts WoW
param(
    [string]$ApiKey = "",
    [string]$VoiceId = "",
    [int]$MaxCount = 1
)

# Configuration ElevenLabs
if ([string]::IsNullOrWhiteSpace($ApiKey)) {
    Write-Host "=== Configuration ElevenLabs ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Vous avez besoin d'une cle API ElevenLabs" -ForegroundColor Yellow
    Write-Host "1. Allez sur: https://elevenlabs.io" -ForegroundColor Gray
    Write-Host "2. Connectez-vous et allez dans Profile > API Keys" -ForegroundColor Gray
    Write-Host "3. Copiez votre cle API" -ForegroundColor Gray
    Write-Host ""
    $ApiKey = Read-Host "Entrez votre cle API ElevenLabs"
    Write-Host ""
}

if ([string]::IsNullOrWhiteSpace($VoiceId)) {
    Write-Host "=== Selection de la voix ===" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Voix recommandees pour le francais:" -ForegroundColor Yellow
    Write-Host "  MULTILINGUES (meilleur accent FR):" -ForegroundColor Green
    Write-Host "    Adam (pNInz6obpgDQGcFmaJgB) - Masculine, excellent FR" -ForegroundColor Gray
    Write-Host "    Freya (jsCqWAovK2LkecY7zXl4) - Feminine" -ForegroundColor Gray
    Write-Host "    Grace (oWAxZDx7w5VEj9dCyTzz) - Feminine" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Pour obtenir les IDs de voix:" -ForegroundColor Gray
    Write-Host "  https://api.elevenlabs.io/v1/voices (ou laissez vide pour Rachel)" -ForegroundColor Gray
    Write-Host ""
    $VoiceId = Read-Host "Entrez Voice ID (ou Enter pour Rachel par defaut)"
    
    if ([string]::IsNullOrWhiteSpace($VoiceId)) {
        # Utiliser Adam (multilingue) qui prononce mieux le francais
        $VoiceId = "pNInz6obpgDQGcFmaJgB"  # Adam (multilingue, meilleur pour FR)
        Write-Host "Utilisation de Adam (voix masculine multilingue)" -ForegroundColor Green
    }
    Write-Host ""
}

$rootFolder = Split-Path $PSScriptRoot -Parent
$sortsFile = Join-Path $PSScriptRoot "sorts.txt"
$soundsFolder = Join-Path $rootFolder "sounds"

Write-Host "=== Generateur TTS ElevenLabs ===" -ForegroundColor Cyan
Write-Host "Lecture: $sortsFile" -ForegroundColor Gray
Write-Host "Sortie: $soundsFolder" -ForegroundColor Gray
Write-Host "Voice ID: $VoiceId" -ForegroundColor Gray
Write-Host ""

if (-not (Test-Path $sortsFile)) {
    Write-Host "Erreur: sorts.txt introuvable!" -ForegroundColor Red
    pause
    exit
}

# Creer le dossier sounds s'il n'existe pas
if (-not (Test-Path $soundsFolder)) {
    New-Item -ItemType Directory -Path $soundsFolder | Out-Null
}

$lines = Get-Content $sortsFile -Encoding UTF8 | Select-Object -First $MaxCount
$count = 0
$success = 0
$errors = 0

foreach ($line in $lines) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    
    if ($line -match '^([^:]+):(.+)$') {
        $classe = $matches[1].Trim()
        $sort = $matches[2].Trim()
        
        # Fonction pour retirer les accents
        function Remove-Accents {
            param([string]$text)
            $text = $text.ToLower()
            $text = $text -replace 'é', 'e'
            $text = $text -replace 'è', 'e'
            $text = $text -replace 'ê', 'e'
            $text = $text -replace 'à', 'a'
            $text = $text -replace 'â', 'a'
            $text = $text -replace 'î', 'i'
            $text = $text -replace 'ô', 'o'
            $text = $text -replace 'ù', 'u'
            $text = $text -replace 'û', 'u'
            $text = $text -replace 'ç', 'c'
            return $text
        }

        # Generer nom de fichier sans accents
        $classeFileName = Remove-Accents $classe
        $classeFileName = $classeFileName -replace ' ', '_'

        $sortFileName = Remove-Accents $sort
        $sortFileName = $sortFileName -replace "['']", '' -replace ' ', '_' -replace ':', '' -replace ',', ''
        
        # Determiner le nom de fichier final
        if ($classe -eq "Général" -or $classe -eq "General") {
            $fileName = "$sortFileName.mp3"
        } else {
            $fileName = "$classeFileName-$sortFileName.mp3"
        }
        
        $outputPath = Join-Path $soundsFolder $fileName
        
        Write-Host "[$($count+1)] " -NoNewline -ForegroundColor Yellow
        Write-Host "$classe" -NoNewline -ForegroundColor Magenta
        Write-Host " -> " -NoNewline
        Write-Host "$sort" -ForegroundColor Cyan
        Write-Host "    $fileName" -ForegroundColor Gray
        
        try {
            # Appel API ElevenLabs
            $url = "https://api.elevenlabs.io/v1/text-to-speech/$VoiceId"
            $headers = @{
                "xi-api-key" = $ApiKey
                "Content-Type" = "application/json"
            }
            
            # Utiliser SSML pour forcer la langue francaise et vitesse constante
            # prosody rate='medium' pour une vitesse constante
            $ssml = "<speak xml:lang='fr-FR'><break time='300ms'/><prosody rate='medium'>$sort.</prosody><break time='750ms'/></speak>"

            $body = @{
                text = $ssml
                model_id = "eleven_multilingual_v2"
                language_code = "fr"
                voice_settings = @{
                    stability = 0.90
                    similarity_boost = 0.85
                    style = 0.0
                    use_speaker_boost = $true
                }
            } | ConvertTo-Json -Depth 10

            # Convertir en UTF8 pour l'API
            $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)
            
            Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $bodyBytes -OutFile $outputPath
            Write-Host "    OK!" -ForegroundColor Green
            $success++
        }
        catch {
            Write-Host "    Erreur: $($_.Exception.Message)" -ForegroundColor Red
            if ($_.ErrorDetails) {
                Write-Host "    Details: $($_.ErrorDetails.Message)" -ForegroundColor Red
            }
            $errors++
        }
        
        $count++
        Start-Sleep -Milliseconds 500
    }
}

Write-Host ""
Write-Host "=== Termine! ===" -ForegroundColor Green
Write-Host "Total: $count sorts traites" -ForegroundColor Cyan
Write-Host "Succes: $success fichiers generes" -ForegroundColor Green
Write-Host "Erreurs: $errors" -ForegroundColor Red
Write-Host ""
Write-Host "Fichiers sauvegardes dans: $soundsFolder" -ForegroundColor Cyan
pause
