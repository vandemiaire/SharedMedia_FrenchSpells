# SharedMedia_FrenchSpells

Addon World of Warcraft qui ajoute des sons de sorts en français pour LibSharedMedia.

## 📥 Installation

1. Téléchargez l'addon depuis [CurseForge](https://www.curseforge.com/) ou [GitHub Releases](https://github.com/vandemiaire/SharedMedia_FrenchSpells/releases)
2. Extrayez dans `World of Warcraft\_retail_\Interface\AddOns\`
3. Les sons seront disponibles dans tous les addons utilisant LibSharedMedia (WeakAuras, DBM, etc.)

## 🎵 Sons disponibles (226 sorts)

Bibliothèque complète de sons de sorts en français couvrant toutes les classes WoW :

- **Chevalier de la mort** (15 sorts)
- **Chasseur de démons** (11 sorts)
- **Druide** (29 sorts)
- **Évocateur** (20 sorts)
- **Chasseur** (25 sorts)
- **Mage** (17 sorts)
- **Moine** (17 sorts)
- **Paladin** (23 sorts)
- **Prêtre** (23 sorts)
- **Voleur** (13 sorts)
- **Chaman** (25 sorts)
- **Démoniste** (16 sorts)
- **Guerrier** (15 sorts)

📄 Liste complète disponible dans `tts/sorts.txt`

## 🛠️ Développement - Ajout de nouveaux sons

1. Placez vos fichiers `.mp3` ou `.ogg` dans le dossier `sounds/`
2. Nommez-les selon la convention : `classe-nom_du_sort.mp3`
   - Avec classe : `chasseur-courroux_bestial.mp3` → **"Chasseur: Courroux Bestial"**
   - Sans classe : `potion_de_soins.mp3` → **"Potion De Soins"**
   - Classe composée : `chasseur_de_demons-metamorphose.mp3` → **"Chasseur De Demons: Métamorphose"**
3. Lancez `tools\sound_registration.bat` pour régénérer `SoundRegistrations.lua`

### Convention de nommage

- **`-`** (tiret simple) = séparateur entre classe et sort (une seule fois)
- **`_`** (underscore) = espaces dans les mots
- Exemples :
  ```
  chasseur-courroux_bestial.mp3
  chasseur_de_demons-metamorphose.mp3
  demoniste-tyran_demoniaque.mp3
  potion_de_soins.mp3
  ```

## 📁 Structure du projet

```
SharedMedia_FrenchSpells/
├── SharedMedia_FrenchSpells.lua    # Fichier principal de l'addon
├── SharedMedia_FrenchSpells.toc    # Table of contents WoW
├── SoundRegistrations.lua          # Enregistrements auto-générés
├── sounds/                         # Fichiers audio (.mp3, .ogg)
├── tools/                          # Scripts de développement
│   ├── sound_registration.ps1      # Script de génération
│   ├── sound_registration.bat      # Lanceur Windows
│   └── commit.bat                  # Raccourci Git
├── tts/                            # Génération TTS (dev only)
│   ├── generate_tts_elevenlabs.ps1 # Script ElevenLabs
│   └── sorts.txt                   # Liste des 226 sorts
├── .pkgmeta                        # Config CurseForge
└── README.md
```

## 🚀 Contribution

1. Fork le projet
2. Crée une branche (`git checkout -b feature/nouveaux-sons`)
3. Ajoute tes sons dans `sounds/`
4. Génère les enregistrements (`tools\generate_sound_registrations.bat`)
5. Commit (`git acp "Ajout de nouveaux sons"`)
6. Push et crée une Pull Request

## 📝 Licence

Libre d'utilisation pour la communauté WoW.

---

**Auteur** : [vandemiaire](https://github.com/vandemiaire)  
**Repo** : [github.com/vandemiaire/SharedMedia_FrenchSpells](https://github.com/vandemiaire/SharedMedia_FrenchSpells)
