# Script to generate SharedMedia sound registrations from files in sounds folder

param(
	[string]$soundsDir = "",
	[string]$outputFile = "",
	[string]$addonName = "SharedMedia_FrenchSpells",
	[string]$soundsSubPath = "sounds"
)

# Script is in tools/, so go up one level to find sounds/ and root
$rootFolder = Split-Path $PSScriptRoot -Parent

# Use provided paths or defaults
if ([string]::IsNullOrEmpty($soundsDir)) {
	$soundsFolder = Join-Path $rootFolder "sounds"
} else {
	$soundsFolder = Join-Path $rootFolder $soundsDir
}

if ([string]::IsNullOrEmpty($outputFile)) {
	$outputFile = Join-Path $rootFolder "SoundRegistrations.lua"
} else {
	$outputFile = Join-Path $rootFolder $outputFile
}

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

# First pass: build array of sound entries
$soundEntries = @()

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

	# Replace curly apostrophes with straight ones
	$displayName = $displayName -replace [char]0x2019, [char]0x0027  # right single quotation mark
	$displayName = $displayName -replace [char]0x2018, [char]0x0027  # left single quotation mark

	# Capitalize first letter of each word
	$textInfo = (Get-Culture).TextInfo
	$displayName = $textInfo.ToTitleCase($displayName.ToLower())

	# Add prefix if exists
	if ($prefix) {
		$prefixWithSpaces = $prefix -replace '_', ' '
		$prefixCapitalized = $textInfo.ToTitleCase($prefixWithSpaces.ToLower())
		$displayName = "$prefixCapitalized`: $displayName"
	}

	# Store the entry
	$soundEntries += [PSCustomObject]@{
		DisplayName = $displayName
		FileName = $file.Name
	}
}

# Sort by display name alphabetically
$soundEntries = $soundEntries | Sort-Object DisplayName

# Second pass: generate Lua registrations
foreach ($entry in $soundEntries) {
	$relativePath = "Interface\AddOns\$addonName\$soundsSubPath\$($entry.FileName)"
	$luaContent += "LSM:Register(`"sound`", `"$($entry.DisplayName)`", [[$relativePath]])`r`n"
	Write-Host "  + $($entry.DisplayName)" -ForegroundColor Cyan
}

# Write to file
$luaContent | Set-Content -Path $outputFile -Encoding UTF8

Write-Host "`nSuccessfully generated $outputFile" -ForegroundColor Green
Write-Host "Registered $($soundFiles.Count) sound(s)" -ForegroundColor Green
pause
