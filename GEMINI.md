# Gemini Code Assistant Context

## Project Overview

This project is a Flutter-based cross-platform mobile application for "WorkLife Dashboard", a note-taking and productivity app. It's the mobile counterpart to an existing web application, designed to provide a seamless, synchronized experience for users on iOS and Android.

The application follows the Clean Architecture principles and utilizes the Riverpod state management library. It features a rich text editor using Flutter Quill, a Markdown editor, and a checklist editor. The app is designed to work offline-first, with data synchronization handled by a custom sync engine that communicates with a backend API.

Key technologies include:
- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Riverpod
- **Architecture:** Clean Architecture
- **Local Database:** Isar
- **Networking:** Dio

## Building and Running

To build and run this project, you will need to have the Flutter SDK installed.

**1. Install dependencies:**
```bash
flutter pub get
```

**2. Run the app:**
```bash
flutter run
```

**3. Run tests:**
```bash
flutter test
```

## Development Conventions

The project adheres to the following conventions:

*   **Clean Architecture:** The codebase is structured into three layers: `data`, `domain`, and `presentation`.
*   **State Management:** Riverpod is used for state management, with providers defined in the `presentation/providers` directory.
*   **Routing:** `go_router` is used for navigation.
*   **Styling:** The app uses Material Design 3 and defines a custom theme in `lib/core/constants/app_themes.dart`.
*   **Testing:** The project includes unit, widget, and integration tests. Test files are located in the `test` directory.
*   **CI/CD:** A GitHub Actions workflow is set up for continuous integration and deployment.
