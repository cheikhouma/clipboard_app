# Clipboard Manager

## Description

Clipboard Manager est une application Flutter permettant de gérer l'historique du clipboard. Elle permet de copier, coller, supprimer, marquer comme favori et rechercher des éléments dans l'historique du clipboard.

## Prérequis

- [Flutter](https://flutter.dev/docs/get-started/install) (version >= 2.12.0)
- Android SDK
- Un appareil Android ou un émulateur Android configuré

## Installation

1. Clonez le dépôt :

    ```bash
    git clone git@github.com:cheikhouma/clipboard_app.git
    cd clipboard_manager
    ```

2. Installez les dépendances Flutter :

    ```bash
    flutter pub get
    ```

3. Génération des fichiers Hive :

    ```bash
    flutter packages pub run build_runner build
    ```

## Exécution de l'application

### Sur émulateur

1. Lancer l'émulateur :

    ```bash
    flutter emulators --launch <nom-de-votre-emulateur>
    ```

2. Exécuter l'application :

    ```bash
    flutter run
    ```

### Sur un appareil physique

1. Activez le mode développeur sur votre appareil et activez le débogage USB.
2. Connectez votre appareil à votre ordinateur via USB.
3. Vérifiez que votre appareil est reconnu :

    ```bash
    flutter devices
    ```

4. Exécutez l'application :

    ```bash
    flutter run
    ```

## Structure du projet

### `pubspec.yaml`

Définit les dépendances et configurations du projet.

### `lib/main.dart`

Point d'entrée de l'application. Configure Hive et initialise l'interface utilisateur.

### `lib/models/clipboard_item.dart`

Définit le modèle `ClipboardItem` utilisé pour stocker les éléments du clipboard dans Hive.

### `lib/models/clipboard_item.g.dart`

Fichier généré automatiquement par Hive. Utilisé pour la sérialisation et la désérialisation des objets `ClipboardItem`.

## Fonctionnalités

- **Capture automatique du texte copié** : Enregistre automatiquement le texte copié dans l'historique de l'application.
- **Gestion de l'historique** : Stocke les éléments copiés dans une base de données locale (Hive).
- **Suppression et sauvegarde** : Permet de supprimer des éléments de l'historique ou de les marquer comme favoris.
- **Recherche et filtrage** : Implémente une fonction de recherche pour trouver facilement des éléments spécifiques dans l'historique.

## Dépendances

- `super_clipboard`: Pour interagir avec la presse papier du système.
- `path_provider`: Pour obtenir les chemins du système de fichiers.
- `hive` et `hive_flutter`: Pour le stockage local des données.

## Auteur

- Cheikh Oumar DIALLO

## Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.
