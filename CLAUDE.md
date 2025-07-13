# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Essential Commands

### Development Setup
```bash
# Install dependencies for all packages in workspace
flutter pub get

# Generate code for specific packages
cd packages/core && flutter pub run build_runner build --delete-conflicting-outputs
cd packages/feature_post && flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization files (core package)
cd packages/core && flutter gen-l10n

# Clean and reinstall packages
flutter clean && flutter pub get
```

### Development Scripts
```bash
# Available scripts in scripts/ directory:
./scripts/clean_and_get_packages.sh
./scripts/run_build_runner.sh
./scripts/generate_localization.sh
```

### Running the Application
```bash
# Main app
flutter run

# Widgetbook for component development
flutter run -t packages/design_system/lib/widgetbook/main_widgetbook.dart
```

### Testing and Code Quality
```bash
# Run all tests
flutter test

# Lint (uses flutter_lints with custom rules)
flutter analyze

# Run specific test files
flutter test test/path/to/test_file.dart
```

### Code Generation
```bash
# Build runner for Freezed and JSON serialization (run in each package)
cd packages/feature_post && flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization files (core package only)
cd packages/core && flutter gen-l10n

# Generate app icons and splash screens (root level)
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

## Architecture Overview

### Project Structure (Multi-Package Workspace)

```
flutter_template/
├── lib/main.dart                    # Entry point - calls CoreApp.main()
├── pubspec.yaml                     # Workspace root configuration
├── analysis_options.yaml            # Shared linting rules across all packages
└── packages/
    ├── core/                        # Core functionality package
    │   ├── lib/
    │   │   ├── app/                 # App initialization & configuration
    │   │   │   ├── routing/         # GoRouter setup and routes
    │   │   │   └── service_locator/ # GetIt dependency injection
    │   │   ├── core/                # Core utilities
    │   │   │   ├── helpers/         # Result pattern, Command pattern
    │   │   │   ├── http/            # Dio HTTP client & interceptors
    │   │   │   ├── observers/       # BLoC & Router observers
    │   │   │   └── utils/           # AppLogger and utilities
    │   │   ├── localization/        # i18n support
    │   │   │   ├── arb/             # Translation files
    │   │   │   └── generated/       # Generated localization code
    │   │   └── core.dart            # Main package export file
    │   ├── pubspec.yaml             # Core package dependencies
    │   └── l10n.yaml                # Localization configuration
    ├── design_system/               # UI components & design tokens
    │   ├── lib/
    │   │   ├── atoms/               # Basic UI components (Label, etc.)
    │   │   ├── tokens/              # Design tokens (colors, sizes, theme)
    │   │   ├── widgetbook/          # Component development environment
    │   │   └── design_system.dart   # Main package export file
    │   ├── pubspec.yaml             # Design system dependencies
    │   └── widgetbook_options.yaml  # Widgetbook configuration
    └── feature_post/                # Post feature implementation
        ├── lib/
        │   ├── data/                # Data layer
        │   │   ├── apis/            # API clients
        │   │   ├── models/          # Data models (Freezed + JSON)
        │   │   └── repositories/    # Repository implementations
        │   ├── presentation/        # Presentation layer
        │   │   ├── bloc/            # BLoC state management
        │   │   ├── view/            # Screen widgets
        │   │   └── widgets/         # Feature-specific widgets
        │   └── feature_post.dart    # Main package export file
        └── pubspec.yaml             # Feature package dependencies
```

### Key Architectural Patterns

#### Multi-Package Workspace
- Uses Dart pub workspaces for package management
- Each package has its own `pubspec.yaml` with `resolution: workspace`
- Dependencies managed at workspace level with local package references
- Clear separation of concerns across packages

#### State Management
- Uses **BLoC pattern** (`flutter_bloc`) for state management
- Features follow BLoC structure: `bloc/`, `event.dart`, `state.dart`
- Dependency injection via `get_it` service locator in core package

#### Error Handling
- Custom `Result<T>` type for error handling (see `packages/core/lib/core/helpers/result.dart`)
- Pattern matching with `Ok<T>` and `Error<T>` sealed classes
- Used throughout data layer and BLoC logic

#### HTTP Client
- Custom `DioHttpClient` wrapper implementing `HttpClient` interface
- Configured with logging interceptor and timeouts
- Located in core package, available to all features

#### Package Dependencies
- **Core**: Foundation package with essential functionality
- **Design System**: Depends on core, provides UI components
- **Feature Post**: Depends on core and design_system
- **Root App**: Depends on core package only

### Code Style and Standards
- **Shared Analysis Options**: Root `analysis_options.yaml` applies to all packages for consistent standards
- **Linting**: Uses `flutter_lints` with additional rules (`always_use_package_imports`, `require_trailing_commas`)
- **Generated files**: Excluded from analysis (`.g.dart`, `.freezed.dart`, `widgetbook/**`)
- **Package imports**: Always use package imports (`package:core/`, `package:design_system/`, `package:feature_post/`)

### Clean Import Pattern
Each package provides a single main export file for easy imports:
```dart
// Instead of multiple specific imports:
import 'package:design_system/tokens/app_colors.dart';
import 'package:design_system/atoms/label.dart';

// Use the clean single import:
import 'package:design_system/design_system.dart';  // Gets everything

// Same pattern for other packages:
import 'package:core/core.dart';                    // All core functionality
import 'package:feature_post/feature_post.dart';    // All post features
```

### Testing Strategy
- Unit tests for business logic and data models in individual packages
- Widget tests for UI components in design_system package
- BLoC tests using `bloc_test` package in feature packages
- Integration tests at root level

### Localization
- ARB files in `packages/core/lib/localization/arb/` for multiple languages (en, es, pt)
- Generated localization code in `packages/core/lib/localization/generated/`
- Managed centrally in core package, available to all other packages

### App Initialization
- `main.dart` calls `CoreApp.main()` from core package
- Core package handles all initialization: app setup, service registration, widget binding
- Clean separation between entry point and initialization logic