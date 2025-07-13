# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Essential Commands

### Development Setup
```bash
# Install dependencies for all packages in workspace
flutter pub get

# Generate code for specific packages
cd packages/post && flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization files (localization package)
cd packages/localization && flutter gen-l10n

# Clean and reinstall packages
flutter clean && flutter pub get
```

### Development Scripts
```bash
# Available scripts in scripts/ directory:
./scripts/development/clean_and_get_packages.sh
./scripts/development/run_build_runner.sh
./scripts/development/generate_localization.sh
```

### Running the Application

#### Environment-based Execution
```bash
# Development environment (local API, full logging)
flutter run --flavor development --dart-define=ENVIRONMENT=development
# Or use script: ./scripts/run_dev.sh

# Staging environment (staging API, logging enabled)
flutter run --flavor staging --dart-define=ENVIRONMENT=staging
# Or use script: ./scripts/run_staging.sh

# Production environment (production API, logging disabled)
flutter run --flavor production --dart-define=ENVIRONMENT=production
# Or use script: ./scripts/run_prod.sh

# Widgetbook for component development
flutter run -t packages/design_system/lib/widgetbook/main_widgetbook.dart
```

#### Building for Different Environments
```bash
# Development build
flutter build apk --flavor development --dart-define=ENVIRONMENT=development
# Or use script: ./scripts/build/build_dev.sh

# Staging build  
flutter build apk --flavor staging --dart-define=ENVIRONMENT=staging
# Or use script: ./scripts/build/build_staging.sh

# Production release build
flutter build apk --flavor production --dart-define=ENVIRONMENT=production --release
# Or use script: ./scripts/build/build_prod.sh
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
cd packages/post && flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization files (localization package only)
cd packages/localization && flutter gen-l10n

# Generate app icons for all flavors (root level)
flutter pub run flutter_launcher_icons -f flutter_launcher_icons_dev.yaml      # Development
flutter pub run flutter_launcher_icons -f flutter_launcher_icons_staging.yaml  # Staging
flutter pub run flutter_launcher_icons -f flutter_launcher_icons_prod.yaml     # Production

# Or use convenience scripts:
./scripts/icons/generate_icons_dev.sh        # Development icons only
./scripts/icons/generate_icons_staging.sh    # Staging icons only
./scripts/icons/generate_icons_prod.sh       # Production icons only
./scripts/icons/generate_all_icons.sh        # All flavors at once

# Generate splash screens (root level)
flutter pub run flutter_native_splash:create
```

## Architecture Overview

### Project Structure (Multi-Package Workspace)

```
flutter_template/
├── lib/main.dart                    # Entry point - calls AppBootstrap.main()
├── pubspec.yaml                     # Workspace root configuration
├── analysis_options.yaml            # Shared linting rules across all packages
└── packages/
    ├── app/                         # App initialization, routing, and service locator
    │   ├── lib/
    │   │   ├── routing/             # GoRouter setup and routes
    │   │   ├── service_locator/     # GetIt dependency injection
    │   │   └── app.dart             # Main package export file
    │   └── pubspec.yaml
    ├── core/                        # Core utilities, networking, and configuration
    │   ├── lib/
    │   │   ├── config/              # Environment and app configuration
    │   │   ├── helpers/             # Result pattern, Command pattern
    │   │   ├── http/                # Dio HTTP client & interceptors
    │   │   ├── observers/           # BLoC & Router observers
    │   │   ├── utils/               # AppLogger and utilities
    │   │   └── core.dart            # Main package export file
    │   └── pubspec.yaml
    ├── design_system/               # UI components & design tokens
    │   ├── lib/
    │   │   ├── atoms/               # Basic UI components (Label, etc.)
    │   │   ├── tokens/              # Design tokens (colors, sizes, theme)
    │   │   ├── widgetbook/          # Component development environment
    │   │   └── design_system.dart   # Main package export file
    │   ├── pubspec.yaml             # Design system dependencies
    │   └── widgetbook_options.yaml  # Widgetbook configuration
    ├── localization/                # Internationalization and localization
    │   ├── lib/
    │   │   ├── arb/                 # Translation files
    │   │   ├── generated/           # Generated localization code
    │   │   └── localization.dart    # Main package export file
    │   ├── pubspec.yaml
    │   └── l10n.yaml                # Localization configuration
    └── post/                        # Post feature implementation
        ├── lib/
        │   ├── data/                # Data layer
        │   │   ├── apis/            # API clients
        │   │   ├── models/          # Data models (Freezed + JSON)
        │   │   └── repositories/    # Repository implementations
        │   ├── presentation/        # Presentation layer
        │   │   ├── view_model/      # BLoC state management
        │   │   ├── view/            # Screen widgets
        │   │   └── widgets/         # Feature-specific widgets
        │   └── post.dart            # Main package export file
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
- Custom `Result<T>` type for error handling (see `packages/core/lib/helpers/result.dart`)
- Pattern matching with `Ok<T>` and `Error<T>` sealed classes
- Used throughout data layer and BLoC logic

#### HTTP Client
- Custom `DioClient` wrapper implementing `HttpClient` interface
- Configured with logging interceptor and timeouts
- Located in core package, available to all features

#### Package Dependencies
- **App**: App initialization, routing, and service locator
- **Core**: Foundation package with essential functionality
- **Design System**: Depends on core, provides UI components
- **Localization**: Internationalization and localization support
- **Post**: Depends on core and design_system for post feature implementation
- **Root App**: Depends on app package for initialization

#### Environment Configuration
The project supports three environments with different configurations:

| Environment | App Name | Bundle ID | API Base URL | Logging |
|-------------|----------|-----------|--------------|---------|
| **Development** | Flutter Template Dev | `com.hlfdev.flutter_template.dev` | `http://10.0.2.2:8080` | ✅ Enabled |
| **Staging** | Flutter Template Staging | `com.hlfdev.flutter_template.staging` | `https://api-staging.example.com` | ✅ Enabled |
| **Production** | Flutter Template | `com.hlfdev.flutter_template` | `https://api.example.com` | ❌ Disabled |

**Configuration Classes:**
- `Environment` enum: Determines current environment from `--dart-define=ENVIRONMENT`
- `AppConfig` class: Provides environment-specific configuration (API URLs, app names, logging)
- Automatic environment detection in `AppConfig.current`

#### Flavor-Specific App Icons
Each environment has its own app icon configuration for easy identification:

- **Development**: `assets/icon/flavors/development/ic_launcher.png` (configured in `flutter_launcher_icons_dev.yaml`)
- **Staging**: `assets/icon/flavors/staging/ic_launcher.png` (configured in `flutter_launcher_icons_staging.yaml`)  
- **Production**: `assets/icon/flavors/production/ic_launcher.png` (configured in `flutter_launcher_icons_prod.yaml`)

Icons are automatically applied when building for specific flavors. Use the generation scripts in the `scripts/` directory to update icons for all or individual environments.

### Code Style and Standards
- **Shared Analysis Options**: Root `analysis_options.yaml` applies to all packages for consistent standards
- **Linting**: Uses `flutter_lints` with additional rules (`always_use_package_imports`, `require_trailing_commas`)
- **Generated files**: Excluded from analysis (`.g.dart`, `.freezed.dart`, `widgetbook/**`)
- **Package imports**: Always use package imports (`package:app/`, `package:core/`, `package:design_system/`, `package:localization/`, `package:post/`)

### Clean Import Pattern
Each package provides a single main export file for easy imports:
```dart
// Instead of multiple specific imports:
import 'package:design_system/tokens/app_colors.dart';
import 'package:design_system/atoms/label.dart';

// Use the clean single import:
import 'package:design_system/design_system.dart';  // Gets everything

// Same pattern for other packages:
import 'package:app/app.dart';                      // All app functionality
import 'package:core/core.dart';                    // All core functionality
import 'package:localization/localization.dart';    // All localization functionality
import 'package:post/post.dart';                    // All post features
```

### Testing Strategy
- Unit tests for business logic and data models in individual packages
- Widget tests for UI components in design_system package
- BLoC tests using `bloc_test` package in feature packages
- Integration tests at root level

### Localization
- ARB files in `packages/localization/lib/arb/` for multiple languages (en, es, pt)
- Generated localization code in `packages/localization/lib/generated/`
- Managed centrally in localization package, available to all other packages

### App Initialization
- `main.dart` calls `AppBootstrap.main()` from app package
- App package handles all initialization: app setup, service registration, widget binding
- Clean separation between entry point and initialization logic