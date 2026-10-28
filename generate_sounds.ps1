# Script to generate SharedMedia sound registrations from files in sounds folder

$soundsFolder = Join-Path $PSScriptRoot "sounds"
$outputFile = Join-Path $PSScriptRoot "SoundRegistrations.lua"

# Check if sounds folder exists
if (-not (Test-Path $soundsFolder)) {
	Write-Host "Error: 'sounds' folder not found!" -ForegroundColor Red
	Write-Host "Creating sounds folder..."
	New-Item -ItemType Directory -Path $soundsFolder | Out-Null
	Write-Host "Please add .ogg or .mp3 files to the sounds folder and run this script again." -ForegroundColor Yellow
	pause
	exit
}

# Get all sound files
$soundFiles = Get-ChildItem -Path $soundsFolder -Filter *.mp3 -File
$soundFiles += Get-ChildItem -Path $soundsFolder -Filter *.ogg -File

if ($soundFiles.Count -eq 0) {
	Write-Host "No .ogg or .mp3 files found in sounds folder!" -ForegroundColor Yellow
	pause
	exit
}

Write-Host "Found $($soundFiles.Count) sound file(s)" -ForegroundColor Green

# Generate Lua content
$luaContent = @"
-- Auto-generated file - DO NOT EDIT MANUALLY
-- Run generate_sounds.bat to regenerate this file

local LSM = LibStub("LibSharedMedia-3.0")

"@

foreach ($file in $soundFiles | Sort-Object Name) {
	# Convert filename to display name
	# Remove extension
	$baseName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

	# Check if there's a class prefix (separated by -)
	$prefix = ""
	if ($baseName -match '^([^-]+)-(.+)$') {
		$prefix = $matches[1]
		$baseName = $matches[2]
	}

	# Replace _ with spaces
	$displayName = $baseName -replace '_', ' '

	# Capitalize first letter of each word
	$textInfo = (Get-Culture).TextInfo
	$displayName = $textInfo.ToTitleCase($displayName.ToLower())

	# Add prefix if exists
	if ($prefix) {
		$prefixWithSpaces = $prefix -replace '_', ' '
		$prefixCapitalized = $textInfo.ToTitleCase($prefixWithSpaces.ToLower())
		$displayName = "$prefixCapitalized`: $displayName"
	}

	# Generate the LSM:Register line
	$relativePath = "Interface\AddOns\SharedMedia_FrenchSpells\sounds\$($file.Name)"
	$luaContent += "LSM:Register(`"sound`", `"$displayName`", [[$relativePath]])`r`n"

	Write-Host "  + $displayName" -ForegroundColor Cyan
}

# Write to file
$luaContent | Set-Content -Path $outputFile -Encoding UTF8

Write-Host "`nSuccessfully generated $outputFile" -ForegroundColor Green
Write-Host "Registered $($soundFiles.Count) sound(s)" -ForegroundColor Green
pause
