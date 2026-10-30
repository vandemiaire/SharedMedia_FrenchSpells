# Script to generate SharedMedia sound registrations from files in sounds folder
# Generates two versions: Retail (all sounds) and Forever (9 classes only)

param(
	[string]$soundsDir = "",
	[string]$outputFile = "",
	[string]$addonName = "SharedMedia_FrenchSpells",
	[string]$soundsSubPath = "sounds"
)

# Script is in tools/sound_registration/, so go up two levels to find root
$rootFolder = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent

# Use provided paths or defaults
if ([string]::IsNullOrEmpty($soundsDir)) {
	$soundsFolder = Join-Path $rootFolder "sounds"
} else {
	$soundsFolder = Join-Path $rootFolder $soundsDir
}

if ([string]::IsNullOrEmpty($outputFile)) {
	$outputFileRetail = Join-Path $rootFolder "SoundRegistrations_Retail.lua"
	$outputFileForever = Join-Path $rootFolder "SoundRegistrations_Forever.lua"
} else {
	$outputFileRetail = Join-Path $rootFolder $outputFile
	$outputFileForever = $null
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

# Define Retail-only classes
$retailOnlyClasses = @(
	"chasseur_de_demons",
	"chevalier_de_la_mort",
	"evocateur",
	"moine"
)

# First pass: build array of sound entries
$soundEntries = @()
$soundEntriesForever = @()

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
	$entry = [PSCustomObject]@{
		DisplayName = $displayName
		FileName = $file.Name
		Prefix = $prefix.ToLower()
	}

	# Add to Retail list (all sounds)
	$soundEntries += $entry

	# Add to Forever list (exclude Retail-only classes)
	$isRetailOnly = $false
	foreach ($retailClass in $retailOnlyClasses) {
		if ($entry.Prefix -eq $retailClass) {
			$isRetailOnly = $true
			break
		}
	}

	if (-not $isRetailOnly) {
		$soundEntriesForever += $entry
	}
}

# Sort by display name alphabetically
$soundEntries = $soundEntries | Sort-Object DisplayName
$soundEntriesForever = $soundEntriesForever | Sort-Object DisplayName

# Function to generate Lua content
function Generate-LuaContent {
	param(
		[Parameter(Mandatory=$true)]
		[array]$entries,
		[Parameter(Mandatory=$true)]
		[string]$version
	)

	$lua = @"
-- Auto-generated file - DO NOT EDIT MANUALLY
-- Run generate_sounds.bat to regenerate this file
-- Version: $version

local LSM = LibStub and LibStub("LibSharedMedia-3.0", true)
if not LSM then
	return
end

"@

	foreach ($entry in $entries) {
		$relativePath = "Interface\AddOns\$addonName\$soundsSubPath\$($entry.FileName)"
		$lua += "LSM:Register(`"sound`", `"$($entry.DisplayName)`", [[$relativePath]])`r`n"
	}

	return $lua
}

# Generate Retail version (all sounds)
Write-Host "`n=== Generating Retail version ===" -ForegroundColor Yellow
$luaContentRetail = Generate-LuaContent -entries $soundEntries -version "Retail (all classes)"
$luaContentRetail | Set-Content -Path $outputFileRetail -Encoding UTF8
Write-Host "  $($soundEntries.Count) sounds registered" -ForegroundColor Cyan

# Generate Forever version (9 classes only)
if ($outputFileForever) {
	Write-Host "`n=== Generating Forever version ===" -ForegroundColor Yellow
	$luaContentForever = Generate-LuaContent -entries $soundEntriesForever -version "Forever (9 classes)"
	$luaContentForever | Set-Content -Path $outputFileForever -Encoding UTF8
	Write-Host "  $($soundEntriesForever.Count) sounds registered" -ForegroundColor Cyan
}

Write-Host "`nSuccessfully generated:" -ForegroundColor Green
Write-Host "  - $outputFileRetail ($($soundEntries.Count) sounds)" -ForegroundColor Green
if ($outputFileForever) {
	Write-Host "  - $outputFileForever ($($soundEntriesForever.Count) sounds)" -ForegroundColor Green
}
pause
