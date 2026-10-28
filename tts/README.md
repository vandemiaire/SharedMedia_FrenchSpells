# Génération TTS pour SharedMedia_FrenchSpells

Ce dossier contient les outils pour générer automatiquement les fichiers audio MP3 à partir de la liste de sorts.

## 📝 Fichiers

- **sorts.txt** : Liste des sorts au format `Classe:Nom du sort`
- **generate_tts_elevenlabs.ps1** : Script PowerShell pour ElevenLabs TTS
- **generate_tts_elevenlabs.bat** : Lanceur Windows

## 🎙️ Utilisation avec ElevenLabs

### 1. Créer un compte ElevenLabs

1. Allez sur https://elevenlabs.io
2. Créez un compte (plan gratuit : 10k caractères/mois)
3. Allez dans **Profile → API Keys**
4. Copiez votre clé API

### 2. Obtenir un Voice ID

**Voix recommandées pour le français :**
- **Rachel** (21m00Tcm4TlvDq8ikWAM) - Féminine, claire ⭐ Par défaut
- **Adam** - Masculine, multilingue
- **Freya** - Féminine, multilingue
- **Antoni** - Masculine

Pour voir toutes les voix disponibles :
```powershell
curl -H "xi-api-key: VOTRE_CLE" https://api.elevenlabs.io/v1/voices
```

### 3. Lancer la génération

Double-cliquez sur **`generate_tts_elevenlabs.bat`**

Le script vous demandera :
1. Votre clé API ElevenLabs
2. Le Voice ID (ou Enter pour Rachel par défaut)

Les MP3 seront créés dans le dossier `sounds/` avec la convention de nommage :
- Avec classe : `classe-nom_du_sort.mp3`
- Sans classe (Général) : `nom_du_sort.mp3`

### 4. Regénérer les enregistrements

Après génération des MP3, lancez :
```
..\tools\sound_registration.bat
```

## ✏️ Ajouter de nouveaux sorts

1. Ouvrez **sorts.txt**
2. Ajoutez une ligne au format : `Classe:Nom du sort`
   - Exemple : `Mage:Bloc de glace`
   - Exemple général : `Général:Cooldown prêt`
3. Lancez **generate_tts_elevenlabs.bat**
4. Lancez **sound_registration.bat**

## 💡 Astuces

- **Qualité** : ElevenLabs offre la meilleure qualité TTS du marché
- **Coût** : ~3000 caractères pour tous les sorts actuels
- **Voix** : Testez différentes voix pour trouver celle qui vous plaît
- **Multilingue** : Le modèle `eleven_multilingual_v2` gère parfaitement le français

## 🔧 Paramètres avancés

Pour modifier la voix directement en ligne de commande :
```powershell
.\generate_tts_elevenlabs.ps1 -ApiKey "VOTRE_CLE" -VoiceId "21m00Tcm4TlvDq8ikWAM"
```

Pour générer seulement les 5 premiers sorts (test) :
```powershell
.\generate_tts_elevenlabs.ps1 -MaxCount 5
```

---

**Note** : Ce dossier `tts/` est exclu du package CurseForge (voir `.pkgmeta`). C'est normal, il est uniquement pour le développement.
