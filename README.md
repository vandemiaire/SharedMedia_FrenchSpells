# SharedMedia_FrenchSpells

Addon World of Warcraft qui ajoute des sons de sorts en français pour LibSharedMedia.

## Installation

1. Téléchargez l'addon
2. Extrayez dans `World of Warcraft\_retail_\Interface\AddOns\`
3. Les sons seront disponibles dans tous les addons utilisant LibSharedMedia

## Ajout de nouveaux sons

1. Placez vos fichiers `.mp3` ou `.ogg` dans le dossier `sounds/`
2. Nommez-les selon la convention : `classe-nom_du_sort.mp3`
   - Exemple : `chasseur-courroux_bestial.mp3` → "Chasseur: Courroux Bestial"
   - Sans classe : `potion_de_soins.mp3` → "Potion De Soins"
3. Lancez `generate_sounds.bat` pour générer `SoundRegistrations.lua`

## Convention de nommage

- `-` = séparateur entre classe et sort (une seule fois)
- `_` = espaces dans les mots
- Exemples :
  - `chasseur-courroux_bestial.mp3`
  - `chasseur_de_demons-metamorphose.mp3`
  - `demoniste-tyran_demoniaque.mp3`

## Structure

- `SharedMedia_FrenchSpells.lua` - Fichier principal de l'addon
- `SharedMedia_FrenchSpells.toc` - Table of contents WoW
- `SoundRegistrations.lua` - Enregistrements générés automatiquement
- `generate_sounds.ps1` - Script de génération
- `sounds/` - Fichiers audio
