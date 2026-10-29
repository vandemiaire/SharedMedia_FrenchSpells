# Changelog

## [1.3.0] - 2026-10-29

### Added
- **52 nouvelles alertes** (de 8 à 60 alertes)
- Intonation alarmiste automatique avec "!" pour les alertes TTS
- Syntaxe de prononciation personnalisée `[prononciation]` pour franciser les anglicismes
- Sections de création incrémentale : ALERTES-A-CREER, SORTS-A-CREER, PROCS-A-CREER
- Workflow de génération progressive documenté
- Tri alphabétique de toutes les sections dans alertes.txt
- Total : **210 sons** (113 sorts + 37 procs + 60 alertes)

### Changed
- Script TTS ajoute automatiquement "!" aux alertes pour une voix plus urgente
- Documentation complète du workflow incrémental dans README.md
- Section "Impact mémoire" ajoutée à CURSEFORGE.md (~34 KB RAM)
- Amélioration de la prononciation avec syntaxe [Texte affiché[Prononciation TTS]]

### Examples
- `Trinket prêt[Trinequette prêt]` - Prononciation personnalisée
- `Stop cast[Stop casste]` - Francisation des anglicismes
- Toutes les alertes générées avec intonation exclamative

## [1.2.0] - 2026-10-29

### Added
- **158 sons en français** (108 sorts + 42 procs + 8 alertes)
- Génération TTS haute qualité via **LuvVoice API**
- Voix française **Denise** (fr-FR) pour une prononciation parfaite
- Nouveau système de **procs** avec suffixe `_(proc)`
- Nouvelles **alertes générales** avec préfixe `Alerte:`
- Script de génération automatique avec gestion des limites API (10 req/min)
- Support complet des **13 classes** de WoW
- Support **EllesmereUI** ajouté dans la documentation
- **Support multi-version** : WoW Retail ET WoW Forever
- Fichiers TOC séparés : `SharedMedia_FrenchSpells.toc` (Retail) et `SharedMedia_FrenchSpells_Forever.toc` (Forever)
- **158 sons** compatibles avec les deux versions (les classes modernes ne sont simplement pas utilisées sur Forever)

### Changed
- Migration de ElevenLabs vers LuvVoice API
- Encodage UTF-8 correct pour préserver les accents français
- Tri alphabétique des sons dans SoundRegistrations.lua
- Documentation complète mise à jour (README, CURSEFORGE)
- Fichiers MP3 légers et optimisés
- Structure simplifiée avec fichiers communs partagés entre les deux versions
- Un seul `SoundRegistrations.lua` charge tous les sons pour les deux versions
- Optimisation de la taille du package (pas de duplication de fichiers)

### Removed
- Anciens sons générés avec ElevenLabs
- Scripts de génération ElevenLabs

## [1.1.0] - 2026-10-28

### Added
- 237 sons de sorts en français
- Génération TTS via ElevenLabs
- Support de 13 classes

## [1.0.0] - 2026-10-28

### Added
- Initial release
- French spell sounds for LibSharedMedia
- 12 spell sounds:
  - Chasseur: Courroux Bestial, Soigner Le Familier
  - Chasseur De Demons: La Traque, Métamorphose
  - Démoniste: Garde Funeste, Malédiction Expirée, Pierre De Soins, Tyran Démoniaque
  - Guerrier: Avatar, Charge, Cri De Guerre
  - General: Debuff Expire, Interrompre, Potion De Soins, Sort Puissant Disponible
- Auto-generation script for developers
