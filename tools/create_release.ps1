$workDir = "C:\Users\vande\source\repos\SharedMedia_FrenchSpells"
$releasePath = Join-Path $workDir "release\SharedMedia_FrenchSpells"
$zipPath = Join-Path $workDir "release\SharedMedia_FrenchSpells.zip"

Add-Type -Assembly System.IO.Compression.FileSystem

if (Test-Path $zipPath) {
	Remove-Item $zipPath -Force
}

[System.IO.Compression.ZipFile]::CreateFromDirectory($releasePath, $zipPath)

$fileSize = (Get-Item $zipPath).Length / 1MB
Write-Host "Archive creee - Taille: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Green

# Verifier le contenu
$zip = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
$fileCount = $zip.Entries.Count
$zip.Dispose()

Write-Host "Fichiers dans l'archive: $fileCount" -ForegroundColor Green
