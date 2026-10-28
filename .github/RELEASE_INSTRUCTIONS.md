# Instructions pour publier une release automatique

## 🔧 Configuration initiale (une seule fois)

### 1. Obtenir le Project ID CurseForge
1. Va sur https://authors.curseforge.com/
2. Crée ton projet "SharedMedia_FrenchSpells" si pas encore fait
3. Dans l'URL du projet, note le **Project ID** (ex: `https://authors.curseforge.com/projects/1234567`)
4. Édite `.github/workflows/release.yml` et remplace `1234567` par ton vrai Project ID

### 2. Obtenir un token API CurseForge
1. Va sur https://authors.curseforge.com/settings/api-keys
2. Clique sur **"Generate API Token"**
3. Copie le token (tu ne pourras le voir qu'une fois !)

### 3. Configurer le secret GitHub
1. Va sur https://github.com/vandemiaire/SharedMedia_FrenchSpells/settings/secrets/actions
2. Clique sur **"New repository secret"**
3. Nom : `CF_API_KEY`
4. Valeur : colle ton token API CurseForge
5. Sauvegarde

## 🚀 Publier une nouvelle version

### Étape 1 : Mettre à jour CHANGELOG.md
Ajoute les changements de la nouvelle version :
```markdown
### Version 1.1.0
- Ajout de 237 sorts...
```

### Étape 2 : Mettre à jour le .toc
Édite `SharedMedia_FrenchSpells.toc` et change la version :
```
## Version: 1.1.0
```

### Étape 3 : Commit et tag
```bash
git add -A
git commit -m "Release v1.1.0"
git tag v1.1.0
git push
git push --tags
```

### Automatique ! ✨
Dès que le tag est poussé, GitHub Actions :
1. ✅ Crée le package ZIP
2. ✅ Upload sur CurseForge
3. ✅ Utilise CHANGELOG.md pour les notes de version

## 📋 Vérifier la release

1. Va sur https://github.com/vandemiaire/SharedMedia_FrenchSpells/actions
2. Vérifie que le workflow "Release to CurseForge" est vert ✅
3. Va sur ton projet CurseForge pour voir la nouvelle version

## 🔄 Versions futures

Pour chaque nouvelle version :
1. Mets à jour CHANGELOG.md
2. Mets à jour la version dans le .toc
3. Tag et push : `git tag v1.2.0 && git push --tags`

C'est tout ! 🎉
