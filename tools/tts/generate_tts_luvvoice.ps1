# Script de generation TTS avec LuvVoice API
# ============================================

param(
    [Parameter(Mandatory=$true)]
    [string]$ApiToken
)

$ErrorActionPreference = "Stop"

# Configuration
$API_URL = "https://luvvoice.com/api/v1/text-to-speech"
$VOICE_NAME = "Denise"
$INPUT_FILE = "alertes.txt"
$OUTPUT_DIR = "..\..\sounds"
$MAX_FILES = 999  # Limite de fichiers a generer (mettre 0 ou $null pour tous)

# Headers pour l'API
$headers = @{
    "Authorization" = "Bearer $ApiToken"
    "Content-Type" = "application/json"
}

# Fonction pour normaliser les noms de fichiers (enlever accents et caracteres speciaux)
function Normalize-Filename {
    param([string]$text)

    $text = $text.ToLower()

    # Remplacer les accents
    $text = $text -replace "[éèêë]", "e"
    $text = $text -replace "[àâä]", "a"
    $text = $text -replace "[ôö]", "o"
    $text = $text -replace "[îï]", "i"
    $text = $text -replace "[ùûü]", "u"
    $text = $text -replace "ç", "c"
    $text = $text -replace "ÿ", "y"

    # Remplacer espaces et caracteres speciaux
    $text = $text -replace " ", "_"
    $text = $text -replace "'", "_"
    $text = $text -replace ":", "_"
    $text = $text -replace "-", "-"

    return $text
}

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Generation TTS avec LuvVoice - Voix: $VOICE_NAME" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Etape 1: Recuperer la liste des voix pour trouver Vivienne
Write-Host "[1/3] Recherche du voice_id pour '$VOICE_NAME'..." -ForegroundColor Yellow

try {
    $voicesResponse = Invoke-RestMethod -Uri "$API_URL`?action=voices" -Method Get -Headers $headers
    
    # Chercher Vivienne dans la liste des voix
    $vivieneVoice = $null
    foreach ($voice in $voicesResponse.voices) {
        if ($voice.name.Trim() -eq $VOICE_NAME) {
            $vivieneVoice = $voice
            break
        }
    }
    
    if (-not $vivieneVoice) {
        Write-Host "Erreur: La voix '$VOICE_NAME' n'a pas ete trouvee." -ForegroundColor Red
        Write-Host "Voix francaises disponibles:" -ForegroundColor Yellow
        foreach ($voice in $voicesResponse.voices) {
            if ($voice.language -like "*fr*" -or $voice.language -eq "French") {
                Write-Host "  - $($voice.name) (ID: $($voice.voice_id), Langue: $($voice.language))" -ForegroundColor Gray
            }
        }
        exit 1
    }

    $VOICE_ID = $vivieneVoice.voice_id
    Write-Host "  OK Voix trouvee: $VOICE_NAME (ID: $VOICE_ID)" -ForegroundColor Green
    Write-Host ""
    
} catch {
    Write-Host "Erreur lors de la recuperation des voix: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Etape 2: Lire et parser le fichier alertes.txt
Write-Host "[2/3] Lecture du fichier '$INPUT_FILE'..." -ForegroundColor Yellow

if (-not (Test-Path $INPUT_FILE)) {
    Write-Host "Erreur: Le fichier '$INPUT_FILE' n'existe pas." -ForegroundColor Red
    exit 1
}

$lines = Get-Content $INPUT_FILE -Encoding UTF8

# Parser les lignes
$items = @()
$currentSection = ""

foreach ($line in $lines) {
    $line = $line.Trim()

    # Detecter les sections
    if ($line -match "#\s*PROCS") {
        $currentSection = "PROCS"
        continue
    } elseif ($line -match "#\s*SORTS") {
        $currentSection = "SORTS"
        continue
    } elseif ($line -match "#\s*ALERTES-A-CREER") {
        $currentSection = "ALERTES-A-CREER"
        continue
    } elseif ($line -match "#\s*ALERTES") {
        $currentSection = "ALERTES"
        continue
    }

    # Ignorer les lignes vides, commentaires (#) et lignes avec @
    if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith("#") -or $line.StartsWith("@")) {
        continue
    }

    # NE TRAITER QUE LA SECTION ALERTES-A-CREER
    if ($currentSection -ne "ALERTES-A-CREER") {
        continue
    }

    if ($line.Contains(":")) {
        # Format: Classe:Sort
        $parts = $line.Split(":", 2)
        $classe = $parts[0].Trim()
        $sort = $parts[1].Trim()

        # Convertir en format de fichier: classe-sort.mp3
        $classeNormalized = Normalize-Filename $classe
        $sortNormalized = Normalize-Filename $sort

        # Ajouter _(proc) si on est dans la section PROCS
        if ($currentSection -eq "PROCS") {
            $filename = "$classeNormalized-$sortNormalized`_(proc).mp3"
        } elseif ($currentSection -eq "ALERTES") {
            $filename = "alerte-$classeNormalized-$sortNormalized.mp3"
        } else {
            $filename = "$classeNormalized-$sortNormalized.mp3"
        }
        $text = $sort
    } else {
        # Format simple: Texte
        $text = $line
        $textNormalized = Normalize-Filename $text

        # Ajouter _(proc) si on est dans la section PROCS ou prefixe alerte- pour ALERTES
        if ($currentSection -eq "PROCS") {
            $filename = "$textNormalized`_(proc).mp3"
        } elseif ($currentSection -eq "ALERTES" -or $currentSection -eq "ALERTES-A-CREER") {
            $filename = "alerte-$textNormalized.mp3"
        } else {
            $filename = "$textNormalized.mp3"
        }
    }

    $items += @{
        Text = $text
        Filename = $filename
    }
}

# Limiter le nombre de fichiers si MAX_FILES est defini
if ($MAX_FILES -gt 0) {
    $items = $items[0..([Math]::Min($MAX_FILES - 1, $items.Count - 1))]
    Write-Host "  LIMITE DE TEST: Seulement $($items.Count) fichiers seront generes" -ForegroundColor Yellow
}

Write-Host "  OK $($items.Count) elements a generer" -ForegroundColor Green
Write-Host ""

# Creer le repertoire de sortie s'il n'existe pas
if (-not (Test-Path $OUTPUT_DIR)) {
    New-Item -ItemType Directory -Path $OUTPUT_DIR | Out-Null
}

# Etape 3: Generer les fichiers MP3
Write-Host "[3/3] Generation des fichiers MP3..." -ForegroundColor Yellow
Write-Host "IMPORTANT: Limite API de 10 requetes/minute - Traitement par lots de 10" -ForegroundColor Yellow
Write-Host ""

$success = 0
$failed = 0
$total = $items.Count
$batchSize = 10
$requestsInCurrentMinute = 0
$minuteStartTime = Get-Date

for ($i = 0; $i -lt $items.Count; $i++) {
    $item = $items[$i]
    $num = $i + 1
    $outputPath = Join-Path $OUTPUT_DIR $item.Filename

    # Verifier si on a atteint la limite de 10 requetes
    if ($requestsInCurrentMinute -ge $batchSize) {
        $elapsed = ((Get-Date) - $minuteStartTime).TotalSeconds
        if ($elapsed -lt 60) {
            $waitTime = [Math]::Ceiling(60 - $elapsed)
            Write-Host ""
            Write-Host "=== Limite de 10 requetes atteinte - Pause de $waitTime secondes ===" -ForegroundColor Yellow
            Start-Sleep -Seconds $waitTime
        }
        $requestsInCurrentMinute = 0
        $minuteStartTime = Get-Date
    }

    Write-Host "[$num/$total] Generation: $($item.Filename)" -ForegroundColor Cyan
    Write-Host "  Texte: $($item.Text)" -ForegroundColor Gray

    try {
        # Preparer la requete avec encodage UTF-8 explicite
        $body = @{
            text = $item.Text
            voice_id = $VOICE_ID
            rate = 0
            pitch = 0
            volume = 0
        } | ConvertTo-Json

        # Convertir en UTF-8 bytes pour preserver les accents
        $bodyBytes = [System.Text.Encoding]::UTF8.GetBytes($body)

        # Appeler l'API avec le body en UTF-8
        $response = Invoke-RestMethod -Uri $API_URL -Method Post -Headers $headers -Body $bodyBytes
        $requestsInCurrentMinute++

        if ($response.success -and $response.audio_data) {
            # Decoder le base64 et sauvegarder
            $audioBytes = [System.Convert]::FromBase64String($response.audio_data)
            [System.IO.File]::WriteAllBytes($outputPath, $audioBytes)

            Write-Host "  OK Genere: $outputPath" -ForegroundColor Green
            Write-Host "  Credits restants: $($response.credits_remaining)" -ForegroundColor Gray
            $success++
        } else {
            Write-Host "  ERREUR Echec: Reponse invalide de l'API" -ForegroundColor Red
            $failed++
        }

    } catch {
        Write-Host "  ERREUR: $($_.Exception.Message)" -ForegroundColor Red
        $failed++
        $requestsInCurrentMinute++
    }

    Write-Host ""

    # Petite pause entre requetes (dans le meme lot)
    if ($i -lt $items.Count - 1 -and $requestsInCurrentMinute -lt $batchSize) {
        Start-Sleep -Milliseconds 500
    }
}

# Resume
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  RESUME" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Total: $total fichiers" -ForegroundColor White
Write-Host "Succes: $success" -ForegroundColor Green
Write-Host "Echecs: $failed" -ForegroundColor $(if ($failed -gt 0) { "Red" } else { "Gray" })
Write-Host ""

if ($success -eq $total) {
    Write-Host "OK Tous les fichiers ont ete generes avec succes!" -ForegroundColor Green
} elseif ($success -gt 0) {
    Write-Host "WARNING Generation partielle terminee" -ForegroundColor Yellow
} else {
    Write-Host "ERREUR Aucun fichier n'a pu etre genere" -ForegroundColor Red
}
