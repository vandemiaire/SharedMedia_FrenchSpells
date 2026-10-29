# Génération TTS avec LuvVoice

Ce script génère automatiquement les fichiers MP3 pour tous les sorts et alertes listés dans `alertes.txt` en utilisant l'API LuvVoice avec la voix française "Vivienne".

## Prérequis

1. **Compte LuvVoice avec accès API**
   - Créer un compte sur https://luvvoice.com
   - Souscrire à un plan incluant l'accès API
   - Obtenir un token API depuis le tableau de bord: https://luvvoice.com/dashboard (section API Tokens)

2. **PowerShell** (Windows)

## Utilisation

### 1. Obtenir votre Token API

1. Connectez-vous sur https://luvvoice.com
2. Allez dans votre tableau de bord
3. Section "API Tokens"
4. Créez un nouveau token ou copiez-en un existant

### 2. Lancer le script

```powershell
cd tts
.\generate_tts_luvvoice.ps1 -ApiToken "VOTRE_TOKEN_ICI"
```

**Exemple:**
```powershell
.\generate_tts_luvvoice.ps1 -ApiToken "lvv_abc123xyz456"
```

### 3. Résultat

Les fichiers MP3 seront générés dans le répertoire `sounds/` avec le format:
- Pour les sorts: `classe-nom_du_sort.mp3`
- Pour les alertes: `nom_de_alerte.mp3`

**Exemples:**
- `Chevalier de la mort:Carapace anti-magie` → `chevalier_de_la_mort-carapace_anti-magie.mp3`
- `Interrompre` → `interrompre.mp3`

## Format du fichier alertes.txt

- Lignes avec `:` → `Classe:Sort`
- Lignes sans `:` → Alertes simples
- Lignes commençant par `#` ou `@` → Ignorées (commentaires)
- Lignes vides → Ignorées

## Notes

- Le script fait une pause de 500ms entre chaque requête pour ne pas surcharger l'API
- Les crédits consommés sont affichés pour chaque fichier généré
- Si la voix "Vivienne" n'est pas trouvée, le script affichera les voix françaises disponibles

## Dépannage

**Erreur d'authentification:**
- Vérifiez que votre token API est valide
- Vérifiez que votre plan inclut l'accès API

**Voix "Vivienne" non trouvée:**
- Le script affichera la liste des voix françaises disponibles
- Vous pouvez modifier la variable `$VOICE_NAME` dans le script pour utiliser une autre voix

**Limite de crédits atteinte:**
- Vérifiez vos crédits restants sur https://luvvoice.com/dashboard
- Le plan gratuit offre 10,000 caractères/mois
