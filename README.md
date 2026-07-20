# AODI — Santé connectée, vie protégée

Application mobile Flutter reproduisant les maquettes AODI : accueil, prise
de rendez-vous, consultation vidéo, dossier médical, géolocalisation des
services de santé, notifications, profil et messagerie.

> ⚠️ Projet de démonstration : les données (médecins, rendez-vous, messages)
> sont codées en dur dans `lib/data/mock_data.dart` et les écrans. Aucun
> backend n'est branché.

## Prérequis

1. **Git** — pour cloner le dépôt.
2. **Flutter SDK** (canal stable) — <https://docs.flutter.dev/get-started/install>
   Une fois installé, vérifie que tout est en ordre :
   ```
   flutter doctor
   ```
3. Un éditeur : [VS Code](https://code.visualstudio.com/) (+ extension **Flutter**)
   ou [Android Studio](https://developer.android.com/studio).

Pas besoin d'Android Studio ni d'émulateur pour un premier essai : le plus
simple est de lancer l'app dans **Chrome** (voir plus bas).

## Installation

```bash
git clone https://github.com/Hamadoun23/aodi-app.git
cd aodi-app
flutter pub get
```

## Lancer l'application

**Option la plus simple — dans le navigateur (Chrome) :**
```bash
flutter run -d chrome
```

**Sur un émulateur Android** (ouvert depuis Android Studio > Device Manager) :
```bash
flutter run
```

**Sur un téléphone Android branché en USB** (mode développeur + débogage USB
activés) :
```bash
flutter devices   # vérifier que le téléphone apparaît
flutter run
```

**Sur iPhone/simulateur iOS** : nécessite un Mac avec Xcode installé.

## Structure du projet

```
lib/
  theme/       couleurs, typographie
  widgets/     composants réutilisables (nav, cartes, etc.)
  data/        données de démonstration
  screens/     un dossier par écran (home, appointments, booking, ...)
assets/images/ visuels extraits des maquettes
```
