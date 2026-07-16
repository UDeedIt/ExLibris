# Ex Libris
Ex Libris is a personal library management application built with Flutter.

It provides a structured way to manage books, authors, and categories, offering a normalized local database and complete create, read, update, and delete (CRUD) flows for each of them.


---

## Features

- **Books**
  - List all books
  - Add / edit / delete books
  - Reading status (`to_read` / `reading` / `finished`)
  - Pick existing authors from a list when adding/editing a book
  - Pick existing categories from a list when adding/editing a book
  - Initial sample books seeded on first run

- **Authors**
  - Normalized Authors table
  - Books reference authors by authorId
  - Authors are auto-created when adding books via the Book repository
  - Dedicated author list
  - Add / edit / delete authors

- **Categories**
  - `Categories` table with name + description
  - Initial sample categories seeded on first run
  - Dedicated category list
  - Add / edit / delete categories


- **Infrastructure / Tooling**
  - Local database with Drift (SQLite)
  - State management with Riverpod (Notifiers + providers)
  - ARB-based localization (gen-l10n, currently en / de)
  - Basic CI with GitHub Actions (analyze, test)
  - Widget smoke test for app startup


---

## Architecture

The app follows a layered, feature-oriented architecture with clear separation of concerns:
 
lib/   
  core/                 # (future cross-cutting concerns: routing, theme, etc.)   
    data/   
    local/              # Drift database and table definitions   
    mappers/            # Drift row <-> domain entity mappers   
    repositories/       # Repository interfaces + Drift implementations   
    providers/          # Riverpod providers for AppDatabase and repositories   

  domain/   
    entities/           # Domain models (Book, Author, Category)   
    sample_data/        # Sample data used to seed an empty database   
  
  presentation/
    books/              # Book screens + viewmodels   
    authors/            # Author screens + viewmodels   
    categories/         # Category screens + viewmodels   
    home/               # Navigation shell   
    splash/             # Splash screen   
  

### Layers

- Data layer
  - Drift database (AppDatabase) with tables:
    - Books (with authorId, isbn, categories as JSON, readingStatus)
    - Authors
    - Categories
  - Repositories:
    - BookRepository / DriftBookRepository
    - AuthorRepository / DriftAuthorRepository
    - CategoryRepository / DriftCategoryRepository
  - Mappers:
    - BookMapper (joins Books + Authors, decodes categories JSON)
    - AuthorMapper
    - CategoryMapper
  - Riverpod providers:
    - appDatabaseProvider
    - bookRepositoryProvider
    - authorRepositoryProvider
    - categoryRepositoryProvider

- Domain layer
  - Entities:
    - Book
    - Author
    - Category
  - Sample data:
    - kSampleBooks
    - kSampleCategories

- Presentation layer
  - ViewModels (Riverpod Notifiers):
    - BookListViewModel / BookListState
    - AuthorListViewModel / AuthorListState
    - CategoryListViewModel / CategoryListState
  - Screens:
    - Books:
      - BookListScreen
      - AddBookScreen
      - EditBookScreen
    - Authors:
      - AuthorListScreen
      - AddAuthorScreen
      - EditAuthorScreen
    - Categories:
      - CategoryListScreen
      - AddCategoryScreen
      - EditCategoryScreen
    - Navigation & splash:
      - HomeShellScreen (bottom navigation)
      - SplashScreen


---

## Tech Stack

- Flutter (3.x, macOS / iOS / Android / Web capable)
- Dart (3.x)
- Drift (SQLite ORM for Dart/Flutter)
- Riverpod (state management and dependency injection)
- Flutter localization (ARB + gen-l10n)
- GitHub Actions (CI: analyze, test)
- IDE: Android Studio / IntelliJ / VS Code

> The app runs on macOS desktop, Android devices/emulators, and iOS simulators/devices.


---

## Running the App

### Prerequisites

- Flutter installed (flutter doctor passes)
- For macOS desktop:
  - flutter config --enable-macos-desktop

### Commands

bash 

# Fetch dependencies
flutter pub get

# Generate Drift (and other) code
dart run build_runner build --delete-conflicting-outputs

# Run on macOS
flutter run -d macos

# Run on Android (device or emulator)
flutter run -d <android-device-id>

# Run on iOS Simulator
flutter run -d <ios-simulator-id>

# Run tests
flutter test



---

## Screenshots

> Note: file paths below assume screenshots are stored under assets/screenshots/.
> You can adjust names/paths to match your actual files.

### macOS (desktop)

| Splash | Books |
|--------|-------|
| macOS Splash | macOS Books |

### Android

| Splash | Books |
|--------|-------|
| Android Splash | Android Books |

### iOS

| Splash | Books |
|--------|-------|
| iOS Splash | iOS Books |


---

## Current Status and Roadmap

### Completed

- Normalized local data model: Books ↔ Authors; Categories
- CRUD flows and screens for:
  - Books
  - Authors
  - Categories
- Sample data seeding on first run (books + categories)
- Splash screen with initial warm-up
- Navigation shell with tabs for:
  - Books
  - Authors
  - Categories
- Basic widget test and CI workflow
- Basic localization (en/de) for splash and navigation labels

### Future

- Simple backend service for backup/restore of the library over HTTP


---

## License

TBD.