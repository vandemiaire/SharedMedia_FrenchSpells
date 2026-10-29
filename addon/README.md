# SharedMedia: French Spells

Addon World of Warcraft qui ajoute 210 sons d'alertes et de sorts en français à LibSharedMedia-3.0.

## Installation

1. Fermez World of Warcraft.
2. Renommez ce dossier `addon` en `SharedMedia_FrenchSpells`, puis copiez-le dans le dossier `Interface\AddOns` de votre installation :
   - Retail : `World of Warcraft\_retail_\Interface\AddOns\`
   - WoW Forever : `World of Warcraft\_classic_era_\Interface\AddOns\` selon le client utilisé.
3. Vérifiez que les fichiers `.toc`, `.lua` et le dossier `sounds` se trouvent directement dans le dossier de l'addon.
4. Relancez le jeu et activez l'addon dans la liste des addons.

LibSharedMedia-3.0 doit être disponible pour afficher les sons. Il est généralement fourni par WeakAuras, DBM, BigWigs ou un autre addon compatible. Si aucun de ces addons n'est installé, installez l'addon autonome **LibSharedMedia-3.0** séparément.

## Utilisation

Les sons sont enregistrés automatiquement dans LibSharedMedia. Dans WeakAuras, DBM, BigWigs ou un autre addon compatible :

1. Ouvrez la sélection de son.
2. Choisissez la catégorie **SharedMedia**.
3. Sélectionnez le son français souhaité.

Le paquet contient les manifestes pour Retail et WoW Forever. Le client sélectionne le manifeste correspondant à sa version.

## Contenu

- `SharedMedia_FrenchSpells.toc` : manifeste Retail.
- `SharedMedia_FrenchSpells_Forever.toc` : manifeste WoW Forever.
- `SharedMedia_FrenchSpells.lua` et `SoundRegistrations.lua` : enregistrement LibSharedMedia.
- `sounds/` : 210 fichiers audio MP3.
- `.pkgmeta` et `CHANGELOG.md` : métadonnées de distribution.

## Dépannage

Si les sons n'apparaissent pas, vérifiez que le chemin ne contient pas un niveau de dossier supplémentaire, puis activez **Charger les addons périmés** dans l'écran de sélection des addons si votre client le demande.
