# SharedMedia_FrenchSpells

Addon World of Warcraft qui ajoute des sons de sorts en français pour LibSharedMedia.

## 📥 Installation

1. Téléchargez l'addon depuis [CurseForge](https://www.curseforge.com/) ou [GitHub Releases](https://github.com/vandemiaire/SharedMedia_FrenchSpells/releases)
2. Extrayez dans le dossier AddOns approprié
3. Les sons seront disponibles dans tous les addons utilisant LibSharedMedia (WeakAuras, DBM, EllesmereUI, etc.)

### 🎮 Support multi-version

Cet addon supporte **WoW Retail** et **WoW Forever** :

- **Retail** : 210 sons (toutes les 13 classes)
- **Forever** : 176 sons (9 classes Forever uniquement)

Le même package ZIP fonctionne pour les deux versions grâce aux fichiers TOC séparés.

## 🎵 Sons disponibles

Bibliothèque complète de **210 sons de sorts en français** générés avec TTS de haute qualité :

- 📜 **Sorts** : 113 sorts pour toutes les classes WoW
- ⚡ **Procs** : 37 procs (suffixe `_(proc)`)
- 🔔 **Alertes** : 60 notifications générales (préfixe `alerte-`)

**Note** : Sur Forever, seuls les sorts des 9 classes originales sont disponibles. Les sorts des classes modernes (Évocateur, Chasseur de démons, Moine, Chevalier de la mort) sont chargés mais non utilisables.

**Important** : Seuls les sorts ayant un temps de recharge de plus de 20 secondes sont pris en charge, ceci afin que vous puissiez avoir une alerte quand ils sont disponibles.

📄 Liste complète disponible dans `tools/tts/alertes.txt`

## Contribution

Faites vos demandes de nouveaux sons via [Issues GitHub](https://github.com/vandemiaire/SharedMedia_FrenchSpells/issues)

## 🛠️ Développement - Génération des sons

### Génération TTS automatique

Les sons sont générés via l'API **LuvVoice** avec la voix française **Denise** :

1. **Modifier la liste** : Éditez `tools/tts/alertes.txt`

   **Sections principales (existantes)** :
   - `#SORTS` : Sorts de classe
   - `#PROCS` : Procs (ajoute `_(proc)` au fichier)
   - `#ALERTES` : Alertes générales (ajoute préfixe `alerte-`)

   **Sections de création (pour nouveaux sons)** :
   - `#ALERTES-A-CREER` : Nouvelles alertes à générer (préfixe `alerte-`)
   - `#SORTS-A-CREER` : Nouveaux sorts à générer
   - `#PROCS-A-CREER` : Nouveaux procs à générer (suffixe `_(proc)`)

   ⚠️ *Le script génère **uniquement** les sons dans les sections `*-A-CREER`*

2. **Syntaxe de prononciation personnalisée** :

   Pour franciser la prononciation des mots anglais, utilisez la syntaxe :
   ```
   Texte affiché[Prononciation TTS]
   ```

   **Exemples** :
   ```
   Trinket prêt[Trinequette prêt]
   Cooldown offensif prêt[Couldaonne offensif prêt]
   Burst prêt[Beurste prêt]
   ```

   **Comportement** :
   - **Nom du fichier** : basé sur `Texte affiché` → `alerte-trinket_pret.mp3`
   - **Affichage LSM** : `Texte affiché` → `"Alerte: Trinket Prêt"`
   - **Audio généré** : `Prononciation TTS` → prononciation française correcte

   📝 *Cette syntaxe est optionnelle. Les lignes sans `[...]` fonctionnent normalement.*

3. **Générer les MP3** :
   ```bash
   cd tools\tts
   generate_tts_luvvoice.bat
   ```
   - Nécessite un token API LuvVoice (plan payant)
   - Limite : 10 requêtes/minute (gestion automatique)
   - Voix : Denise (fr-FR)
   - Les MP3 sont créés dans `sounds/`

4. **Valider et déplacer** :

   Une fois les MP3 générés et validés :
   - Déplacez **manuellement** les lignes de `alertes.txt` depuis les sections `*-A-CREER` vers les sections principales
   - Exemple : `#ALERTES-A-CREER` → `#ALERTES`
   - Exemple : `#SORTS-A-CREER` → `#SORTS`
   - Cela permet de garder une trace des sons à générer vs ceux déjà générés

5. **Régénérer les enregistrements** :
   ```bash
   cd tools\sound_registration
   sound_registration.bat
   ```
   - Met à jour `SoundRegistrations.lua` avec tous les MP3 du dossier `sounds/`

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

## 📝 Licence

Libre d'utilisation pour la communauté WoW.

---

**Auteur** : [vandemiaire](https://github.com/vandemiaire)  
**Repo** : [github.com/vandemiaire/SharedMedia_FrenchSpells](https://github.com/vandemiaire/SharedMedia_FrenchSpells)
