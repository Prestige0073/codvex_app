# 🚀 Guide de démarrage - CodVex Finance

## Prérequis

- Flutter SDK 3.18.0 ou supérieur
- Dart 3.9.2 ou supérieur
- Un éditeur de code (VS Code recommandé avec extensions Flutter/Dart)

## 📦 Installation

### 1. Cloner ou ouvrir le projet

```bash
cd "/home/shikataganai/Documents/web/Mes projet d'emplois/codvex_app"
```

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Vérifier l'installation

```bash
flutter doctor
```

## ▶️ Lancer l'application

### Mode Debug

```bash
# Sur un émulateur/appareil Android
flutter run

# Sur un émulateur/appareil iOS
flutter run

# Sur le web (Chrome)
flutter run -d chrome

# Sur Linux
flutter run -d linux

# Sur Windows
flutter run -d windows

# Sur macOS
flutter run -d macos
```

### Mode Release

```bash
flutter run --release
```

## 🎯 Tester l'application

### Analyser le code

```bash
flutter analyze
```

### Lancer les tests

```bash
flutter test
```

## 📱 Flow de navigation

1. **Splash Screen** (3 secondes)
   - Affiche le logo avec animations
   - Navigation automatique vers Login

2. **Login Screen**
   - Connexion avec email/password
   - Lien vers Register
   - Lien vers Forgot Password
   - Boutons connexion sociale (Google, Apple)

3. **Register Screen**
   - Inscription avec validation
   - Indicateurs de force du mot de passe
   - Acceptance des conditions

4. **Forgot Password Screen**
   - Récupération par email
   - Confirmation d'envoi

5. **Home Screen**
   - Tableau de bord principal
   - Actions rapides
   - Notifications

## 🎨 Personnalisation

### Modifier les couleurs

Éditez `/lib/theme/app_colors.dart` :

```dart
static const Color primary = Color(0xFF1E3A8A); // Votre couleur
```

### Modifier les polices

Éditez `/lib/theme/app_theme.dart` :

```dart
GoogleFonts.poppins(...) // Changez la police
```

### Ajuster les animations

Modifiez les durées dans les écrans :

```dart
FadeInUp(
  duration: const Duration(milliseconds: 600), // Votre durée
  ...
)
```

## 🛠️ Structure du projet

```
lib/
├── main.dart                  # Point d'entrée
├── theme/                     # Système de thème
│   ├── app_colors.dart       # Couleurs
│   └── app_theme.dart        # Thème complet
├── screens/                   # Écrans
│   ├── splash_screen.dart
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── forgot_password_screen.dart
│   └── home/
│       └── home_screen.dart
└── widgets/                   # Composants
    └── common/
        ├── custom_button.dart
        └── custom_text_field.dart
```

## 📝 Bonnes pratiques

1. **Toujours utiliser `const` quand possible**
   ```dart
   const Text('Hello') // Meilleur que Text('Hello')
   ```

2. **Disposer les controllers**
   ```dart
   @override
   void dispose() {
     controller.dispose();
     super.dispose();
   }
   ```

3. **Validation des formulaires**
   ```dart
   if (_formKey.currentState!.validate()) {
     // Traiter les données
   }
   ```

## 🐛 Dépannage

### Erreur : "Packages not found"

```bash
flutter clean
flutter pub get
```

### Erreur : "SDK version incompatible"

Vérifiez `pubspec.yaml` et mettez à jour Flutter :

```bash
flutter upgrade
```

### Problème de polices Google Fonts

Les polices sont téléchargées automatiquement. En cas de problème :

```bash
flutter pub cache repair
```

## 📚 Ressources

- [Documentation Flutter](https://flutter.dev/docs)
- [Google Fonts](https://pub.dev/packages/google_fonts)
- [Iconsax Icons](https://pub.dev/packages/iconsax)
- [Animate Do](https://pub.dev/packages/animate_do)

## 🆘 Support

Pour toute question ou problème :
1. Vérifiez la documentation UI/UX : `README_UI_UX.md`
2. Consultez les TODO dans le code
3. Analysez les logs : `flutter logs`

---

**Bon développement ! 🎉**
