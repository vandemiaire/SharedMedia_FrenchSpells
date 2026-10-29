# SharedMedia_FrenchSpells

Addon World of Warcraft qui ajoute des sons de sorts en français pour LibSharedMedia.

## 📥 Installation

1. Téléchargez l'addon depuis [CurseForge](https://www.curseforge.com/) ou [GitHub Releases](https://github.com/vandemiaire/SharedMedia_FrenchSpells/releases)
2. Extrayez dans `World of Warcraft\_retail_\Interface\AddOns\`
3. Les sons seront disponibles dans tous les addons utilisant LibSharedMedia (WeakAuras, DBM, EllesmereUI, etc.)

## 🎵 Sons disponibles (158 éléments)

Bibliothèque complète de sons de sorts en français générés avec TTS de haute qualité :

### 📜 Sorts de classe (108 sorts)
Sorts défensifs, offensifs et utilitaires majeurs pour toutes les classes WoW

### ⚡ Procs (42 procs)
Notifications pour les procs importants de chaque classe (suffixe `_(proc)`)

### 🔔 Alertes (8 notifications)
Notifications générales : Interruption, Debuff expiré, Potion prête, etc. (préfixe `alerte-`)

📄 Liste complète disponible dans `tts/alertes.txt`

## 🛠️ Développement - Génération des sons

### Génération TTS automatique

Les sons sont générés via l'API **LuvVoice** avec la voix française **Denise** :

1. **Modifier la liste** : Éditez `tts/alertes.txt`
   - Section `#SORTS` : Sorts de classe
   - Section `#PROCS` : Procs (ajoute `_(proc)` au fichier)
   - Section `#ALERTES` : Alertes générales (ajoute préfixe `alerte-`)

2. **Générer les MP3** :
   ```bash
   cd tts
   generate_tts_luvvoice.bat
   ```
   - Nécessite un token API LuvVoice (plan payant)
   - Limite : 10 requêtes/minute (gestion automatique)
   - Voix : Denise (fr-FR)

3. **Régénérer les enregistrements** :
   ```bash
   cd tools
   sound_registration.bat
   ```

### Convention de nommage des fichiers

- **Sorts** : `classe-nom_du_sort.mp3` → **"Classe: Nom Du Sort"**
- **Procs** : `classe-nom_du_proc_(proc).mp3` → **"Classe: Nom Du Proc (Proc)"**
- **Alertes** : `alerte-nom.mp3` → **"Alerte: Nom"**
- **`-`** (tiret) = séparateur entre préfixe et nom
- **`_`** (underscore) = espaces dans les mots

Exemples :
```
chevalier_de_la_mort-carapace_anti-magie.mp3
chevalier_de_la_mort-machine_a_tuer_(proc).mp3
alerte-interrompre.mp3
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
│   └── sound_registration.bat      # Lanceur Windows
├── tts/                            # Génération TTS (dev only)
│   ├── generate_tts_luvvoice.ps1   # Script LuvVoice
│   ├── generate_tts_luvvoice.bat   # Lanceur Windows
│   ├── test_voix_francaises.ps1    # Test des voix
│   ├── test_voix_francaises.bat    # Lanceur de test
│   ├── alertes.txt                 # Liste des 158 éléments
│   └── README.md                   # Documentation TTS
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
