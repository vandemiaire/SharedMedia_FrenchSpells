> **English speakers**: This addon provides French spell sounds for LibSharedMedia. Perfect for French audio notifications in WeakAuras, DBM, EllesmereUI and other addons. Supports both Retail (210 sounds) and Forever (176 sounds). Documentation below is in French.

## 🇫🇷 Bibliothèque de sons de sorts en français pour EllesmereUI, DBM, Weaksauras, etc.

Bibliothèque de **210 sons de sorts et alertes en français**.
Compatible avec **WeakAuras**, **DBM**, **BigWigs**, **EllesmereUI**, et tous les addons utilisant LibSharedMedia.

---

## 🎵 Sons disponibles

### **Retail** : 210 sons (13 classes)
- 🛡️ **Sorts** : 113 sorts défensifs, offensifs et utilitaires
- ⚡ **Procs** : 37 procs importants (suffixe `_(proc)`)
- 🔔 **Alertes** : 60 notifications générales (préfixe `Alerte:`)

Exemples : _Carapace anti-magie • Métamorphose • Célérité • Souffle profond • Combustion • Bouclier divin • Dispersion • Vendetta • Ascendance • Infernal • Avatar_

### **Forever** : 176 sons (9 classes Forever)
- 🛡️ **Sorts** : 91 sorts pour Druide, Chasseur, Mage, Paladin, Prêtre, Voleur, Chaman, Démoniste, Guerrier
- ⚡ **Procs** : 25 procs
- 🔔 **Alertes** : 60 notifications générales

**Classes Retail uniquement** : Évocateur, Chasseur de démons, Moine, Chevalier de la mort

**Important** : Seuls les sorts ayant un temps de recharge de plus de 20 secondes sont pris en charge, ceci afin que vous puissiez avoir une alerte quand ils sont disponibles.

---

## 📥 Installation

### Installation automatique (recommandé)
Installez via **CurseForge App** — l'addon sera automatiquement placé au bon endroit selon votre version de WoW !

### Installation manuelle
1. Téléchargez le fichier ZIP
2. Extrayez dans le dossier AddOns approprié :
   - **Retail** : `World of Warcraft\_retail_\Interface\AddOns\`
   - **Forever** : `World of Warcraft\_forever_\Interface\AddOns\`
3. Redémarrez WoW

✅ Les sons apparaîtront automatiquement dans tous les addons compatibles LibSharedMedia.

---

## 🔧 Comment utiliser les sons

**Aucune dépendance manuelle requise !**
LibSharedMedia-3.0 est déjà inclus dans WeakAuras, DBM, BigWigs, et EllesmereUI. Si vous utilisez l'un de ces addons, vous êtes prêt !

### 🎯 Avec WeakAuras

1. Créez ou éditez une **WeakAura**
2. Onglet **Actions** → **Sound**
3. Type : **SharedMedia**
4. Sélectionnez un son français (ex: _"Chasseur: Courroux Bestial"_)

### ⚔️ Avec DBM / BigWigs

1. Ouvrez les **Options** de DBM/BigWigs
2. Section **Sons personnalisés**
3. Sélectionnez un son de la catégorie **SharedMedia**

### 🎨 Avec EllesmereUI

Les sons sont automatiquement disponibles dans tous les modules EllesmereUI utilisant des notifications audio.

---

## 💾 Impact mémoire

**Empreinte RAM : Négligeable (~28-34 KB selon la version)**

- 📁 **Taille sur disque** : 2.6 MB (210 fichiers MP3)
- 💾 **Consommation RAM Retail** : ~0.03 MB (34 KB)
- 💾 **Consommation RAM Forever** : ~0.03 MB (28 KB)

### ⚡ Comment ça fonctionne ?

L'addon utilise **deux fichiers de registrations optimisés** :
- **Retail** : `SoundRegistrations_Retail.lua` (210 sons)
- **Forever** : `SoundRegistrations_Forever.lua` (176 sons, exclut 4 classes modernes)

Les fichiers MP3 **ne sont pas chargés en mémoire** au démarrage. LibSharedMedia enregistre uniquement les **chemins** des fichiers (~160 bytes par son).

**Lors de la lecture d'un son :**
1. WoW charge le MP3 temporairement
2. Le son est joué
3. Le son est déchargé automatiquement

✅ **Aucun impact sur les performances** — les 210 sons n'ajoutent que quelques dizaines de KB en RAM, comparable à un petit addon de configuration.

---

## 🐛 Support & Suggestions

**Besoin d'aide ou envie de proposer des sorts ?**

- 💬 [Commentaires CurseForge](https://www.curseforge.com/wow/addons/sharedmedia-frenchspells)
- 🐛 [GitHub Issues](https://github.com/vandemiaire/SharedMedia_FrenchSpells/issues)
- ⭐ [GitHub Repository](https://github.com/vandemiaire/SharedMedia_FrenchSpells)

---

## 🤝 Contribution

Le projet est **open-source** ! Les contributions ou suggestions sont les bienvenues :

- ✨ Proposer de nouveaux sorts
- 🎵 Améliorer la qualité audio
- 📝 Corriger des erreurs
- 🌍 Aider à la documentation

👉 **GitHub** : [vandemiaire/SharedMedia_FrenchSpells](https://github.com/vandemiaire/SharedMedia_FrenchSpells)
