# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

WorkLife Memo is a cross-platform Flutter note-taking application built with Clean Architecture and an Offline-First strategy. The project is currently in Phase 1 (Week 3/14 complete), with core note CRUD functionality and folder/tag systems implemented.

**Key Technologies:**
- Flutter 3.9.2+ / Dart 3.9.2+
- State Management: Riverpod with code generation (`riverpod_annotation`)
- Local Database: Drift (previously Isar - migration in progress)
- Navigation: go_router with StatefulShellRoute
- Rich Text Editor: flutter_quill
- Immutable Models: Freezed

## Development Commands

### Code Generation
After modifying any files with `@freezed`, `@riverpod`, or Drift tables:
```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous code generation during development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Running the App
```bash
# Standard run
flutter run

# Specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

### Building
```bash
# Android
flutter build apk
flutter build appbundle

# iOS
flutter build ios

# Web
flutter build web
```

### Code Analysis
```bash
# Run linter
flutter analyze

# Check for outdated packages
flutter pub outdated
```

## Architecture Overview

This project follows **Clean Architecture** with three main layers:

### 1. Domain Layer (`lib/domain/`)
Pure business logic with no dependencies on Flutter or external packages (except freezed_annotation).

- **Entities** (`entities/`): Immutable domain models using Freezed
  - `Note`, `Folder`, `Tag`, `ChecklistItem`
  - Each entity has extension methods for business logic (e.g., `Note.isEmpty`, `Note.preview`)

- **Repositories** (`repositories/`): Abstract interfaces defining data operations
  - Repository interfaces define contracts without implementation details

- **Use Cases** (`usecases/`): Single-responsibility business operations
  - Each use case represents one business action (e.g., `CreateNote`, `UpdateNote`)
  - Use cases depend only on repository interfaces, not implementations

### 2. Data Layer (`lib/data/`)
Handles data persistence and external data sources.

- **Data Sources** (`datasources/local/`):
  - `drift/tables.dart`: Defines database schema using Drift tables
  - `drift/app_database.dart`: Database class with basic CRUD methods
  - `*_local_datasource.dart`: Data source implementations that convert between Drift models and domain entities

- **Repositories** (`repositories/`):
  - `*_repository_impl.dart`: Concrete implementations of domain repository interfaces
  - Handles error conversion from Exceptions to Failures
  - Delegates to local data sources

**Database Migration Note**: The project is transitioning from Isar to Drift. You'll see references to both, but **always use Drift** for new code.

### 3. Presentation Layer (`lib/presentation/`)
UI and state management.

- **Providers** (`providers/`): Riverpod providers using code generation
  - `*_provider.dart`: State management for UI (e.g., `NoteList`, `FolderList`)
  - `*_repository_provider.dart`: Dependency injection for repositories
  - Use `@riverpod` annotation for code generation

- **Screens** (`screens/`): Full-page widgets
  - `home/home_shell.dart`: Bottom navigation shell using StatefulShellRoute
  - `note_editor/`: Note editing screens (RichText, Markdown, Checklist)

- **Widgets** (`widgets/`): Reusable UI components
  - `common/`: Shared widgets (loading indicators, error widgets, empty states)
  - `dialogs/`: Dialog components
  - `note/`: Note-specific widgets (NoteCard)
  - `tag/`: Tag-specific widgets (TagChip, TagInputField)

- **Router** (`router/`): go_router configuration with StatefulShellRoute for bottom navigation

### 4. Core Layer (`lib/core/`)
Shared utilities and constants.

- `constants/`: App-wide constants (colors, themes, strings)
- `errors/`: Exception and Failure classes
- `utils/`: Extension methods, formatters, validators

## Important Development Patterns

### State Management with Riverpod

1. **AsyncNotifier Pattern** for mutable state:
```dart
@riverpod
class NoteList extends _$NoteList {
  @override
  Future<List<Note>> build() async {
    // Initialize and return state
  }

  Future<void> createNote(Note note) async {
    // Mutate state
    await refresh();
  }
}
```

2. **Simple Provider Pattern** for read-only or parameterized state:
```dart
@riverpod
Future<Note?> note(NoteRef ref, String noteId) async {
  // Return data based on parameter
}
```

3. **Provider Pattern** for dependency injection:
```dart
@riverpod
NoteRepository noteRepository(NoteRepositoryRef ref) {
  final database = ref.watch(appDatabaseProvider);
  final dataSource = NoteLocalDataSource(database);
  return NoteRepositoryImpl(localDataSource: dataSource);
}
```

### Domain Entity Pattern (Freezed)

All domain entities use Freezed for immutability:
- Use `copyWith()` for updates
- Define business logic in extension methods, not in the entity class
- Keep entities pure - no Flutter dependencies

### Database Operations (Drift)

- Tables are defined in `lib/data/datasources/local/drift/tables.dart`
- Use `uuid` for entity IDs (not auto-increment `id`)
- The `id` column is for Drift's internal primary key
- Always enable foreign keys: `PRAGMA foreign_keys = ON`
- Use `Companion` classes for inserts with optional fields

### Error Handling

- Data sources throw `DatabaseException` or `CacheException`
- Repositories catch exceptions and convert to `Failure` objects
- Use cases return results directly (exceptions propagate)
- Providers catch exceptions and set `AsyncValue.error` state

### Navigation

The app uses `go_router` with StatefulShellRoute:
- Bottom navigation preserves state across tabs
- Routes: `/notes`, `/folders`, `/tags`, `/settings`
- Note editor: `/note/new`, `/note/:id`
- Use `context.go()` for navigation
- Use `context.push()` for modal navigation

## Code Generation Files

These files are auto-generated and should **not** be manually edited:
- `*.freezed.dart` - Freezed immutable classes
- `*.g.dart` - JSON serialization, Riverpod providers, Drift database
- Always run `dart run build_runner build --delete-conflicting-outputs` after schema changes

## Development Strategy: Offline-First

This project follows a phased approach:
- **Phase 1-2 (Current)**: Complete offline functionality with local database
- **Phase 3**: Add API integration and sync (preserving offline capabilities)

When adding features:
1. Implement full offline functionality first
2. Ensure all features work without network
3. Design with sync in mind (use UUIDs, track timestamps)

## Current Status & Git Workflow

**Current Branch**: `feature/new`
**Main Branch**: `main`
**Recent Work**: Database migration from Isar to Drift (in progress)

When creating commits or PRs:
- Follow existing commit message style (see git log)
- Reference the work plan in `docs/flutter-app-work-plan.md`
- Ensure code generation is complete before committing

## Testing Notes

Currently, there are no tests in the `test/` directory. When adding tests:
- Place unit tests for domain logic in `test/domain/`
- Place widget tests in `test/presentation/`
- Place integration tests in `integration_test/`
- Use `flutter test` to run tests

## Common Gotchas

1. **Code Generation**: Always run build_runner after modifying Freezed, Riverpod, or Drift files
2. **Database Migration**: Use Drift, not Isar (even though README mentions Isar)
3. **Foreign Keys**: Must be explicitly enabled in Drift migrations
4. **UUID vs ID**: Use `uuid` field for business logic, `id` for database relations
5. **StatefulShellRoute**: Each branch in bottom navigation must have exactly one route
6. **Riverpod Code Gen**: Use `part` directive and run build_runner for `@riverpod` annotations
7. **Freezed Models**: Use `part` directive and extend generated class (e.g., `with _$Note`)

## File Naming Conventions

- Domain entities: `note.dart`, `folder.dart` (singular)
- Repositories: `note_repository.dart` (singular + repository)
- Providers: `note_provider.dart`, `note_repository_provider.dart`
- Screens: `notes_screen.dart` (plural + screen for list views)
- Use cases: Verb phrase (e.g., `create_note.dart`, `get_notes.dart`)
