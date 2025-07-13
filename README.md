# 🚀 Flutter HLFDev Template

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x.x-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A production-ready Flutter project template built with multi-package workspace architecture, comprehensive environment support, and robust development tooling. Designed for rapid development with clean architecture patterns and a comprehensive design system.

## 🌟 Features

### Architecture & Organization
- **Multi-Package Workspace:** Organized into `app`, `core`, `design_system`, `localization`, and `post` packages for clear separation of concerns
- **Simple Architecture:** Implements layered architecture with data and presentation layers
- **State Management:** BLoC pattern with `flutter_bloc` for reactive state management
- **Dependency Injection:** Service locator pattern using `get_it`

### Development Experience
- **Environment Support:** Development, staging, and production configurations with flavor-specific settings
- **Design System:** Dedicated package with Widgetbook integration for component development
- **Comprehensive Tooling:** Scripts for building, running, testing, and asset generation
- **Clean Imports:** Single package exports for simplified import patterns

### Production Features
- **Internationalization:** Multi-language support with `flutter_localizations`
- **Network Layer:** Robust HTTP client with Dio, interceptors, and error handling
- **Error Handling:** Custom Result pattern for type-safe error management
- **Logging:** Environment-based logging with structured output
- **Testing:** Comprehensive test setup with unit, widget, and BLoC tests

## 🚀 Quick Start

### Prerequisites
- Flutter 3.x.x or later
- Dart SDK 3.x.x or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/hlfdev/flutter_template.git
   cd flutter_template
   ```

2. Install dependencies for all packages:
   ```bash
   flutter pub get
   ```

3. Generate code and localization files:
   ```bash
   # Run from project root
   ./scripts/development/run_build_runner.sh
   ./scripts/development/generate_localization.sh
   ```

4. Generate app icons for all flavors:
   ```bash
   ./scripts/icons/generate_all_icons.sh
   ```

## 🏃‍♂️ Running the Application

### Environment-Based Execution

The project supports three environments with different configurations:

| Environment | App Name | Bundle ID | API Base URL | Logging |
|-------------|----------|-----------|--------------|---------|
| **Development** | Flutter Template Dev | `com.hlfdev.flutter_template.dev` | `http://10.0.2.2:8080` | ✅ Enabled |
| **Staging** | Flutter Template Staging | `com.hlfdev.flutter_template.staging` | `https://api-staging.example.com` | ✅ Enabled |
| **Production** | Flutter Template | `com.hlfdev.flutter_template` | `https://api.example.com` | ❌ Disabled |

#### Using Scripts (Recommended)
```bash
# Development environment
./scripts/run_dev.sh

# Staging environment
./scripts/run_staging.sh

# Production environment
./scripts/run_prod.sh

# Design system development
./scripts/run_widgetbook.sh
```

#### Manual Commands
```bash
# Development
flutter run --flavor development --dart-define=ENVIRONMENT=development

# Staging
flutter run --flavor staging --dart-define=ENVIRONMENT=staging

# Production
flutter run --flavor production --dart-define=ENVIRONMENT=production

# Widgetbook
flutter run -t packages/design_system/lib/widgetbook/main_widgetbook.dart
```

## 🏗️ Building for Production

### Using Scripts
```bash
# Build for specific environment
./scripts/build/build_dev.sh      # Development APK
./scripts/build/build_staging.sh  # Staging APK
./scripts/build/build_prod.sh     # Production APK (release)
```

### Manual Commands
```bash
# Development build
flutter build apk --flavor development --dart-define=ENVIRONMENT=development

# Staging build
flutter build apk --flavor staging --dart-define=ENVIRONMENT=staging

# Production release build
flutter build apk --flavor production --dart-define=ENVIRONMENT=production --release
```

## 📂 Project Structure

```
flutter_template/
├── lib/main.dart                    # Entry point - calls AppBootstrap.main()
├── pubspec.yaml                     # Workspace root configuration
├── analysis_options.yaml            # Shared linting rules
├── scripts/                         # Development and build scripts
│   ├── build/                       # Build scripts for each flavor
│   ├── development/                 # Development tools (build_runner, localization)
│   └── icons/                       # Icon generation scripts
├── assets/
│   └── icon/flavors/               # Flavor-specific app icons
└── packages/
    ├── app/                         # App initialization, routing, and service locator
    │   ├── lib/
    │   │   ├── routing/             # GoRouter configuration and routes
    │   │   ├── service_locator/     # GetIt dependency injection
    │   │   └── app.dart             # Main package export
    │   └── pubspec.yaml
    ├── core/                        # Core utilities, networking, and configuration
    │   ├── lib/
    │   │   ├── config/              # Environment and app configuration
    │   │   ├── helpers/             # Result pattern, Command pattern
    │   │   ├── http/                # Dio HTTP client & interceptors
    │   │   ├── observers/           # BLoC & Router observers
    │   │   ├── utils/               # AppLogger and utilities
    │   │   └── core.dart            # Main package export
    │   └── pubspec.yaml
    ├── design_system/               # UI components & design tokens
    │   ├── lib/
    │   │   ├── atoms/               # Basic UI components
    │   │   ├── tokens/              # Design tokens (colors, theme)
    │   │   ├── widgetbook/          # Component development environment
    │   │   └── design_system.dart   # Main package export
    │   └── pubspec.yaml
    ├── localization/               # Internationalization and localization
    │   ├── lib/
    │   │   ├── arb/                 # Translation files
    │   │   ├── generated/           # Generated localization code
    │   │   └── localization.dart    # Main package export
    │   └── pubspec.yaml
    └── post/                        # Post feature implementation
        ├── lib/
        │   ├── data/                # Data layer (APIs, models, repositories)
        │   ├── presentation/        # Presentation layer (viewmodels, views, widgets)
        │   └── post.dart            # Main package export
        └── pubspec.yaml
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests for specific package
cd packages/core && flutter test
cd packages/post && flutter test

# Run with coverage
flutter test --coverage
```

## 🔧 Development Scripts

The project includes several convenience scripts in the `scripts/` directory:

### Development Tools
- `./scripts/development/clean_and_get_packages.sh` - Clean and reinstall all dependencies
- `./scripts/development/run_build_runner.sh` - Generate code for all packages
- `./scripts/development/generate_localization.sh` - Generate localization files

### Icon Management
- `./scripts/icons/generate_all_icons.sh` - Generate icons for all flavors
- `./scripts/icons/generate_icons_dev.sh` - Generate development icons only
- `./scripts/icons/generate_icons_staging.sh` - Generate staging icons only
- `./scripts/icons/generate_icons_prod.sh` - Generate production icons only

### Build Scripts
- `./scripts/build/build_dev.sh` - Build development APK
- `./scripts/build/build_staging.sh` - Build staging APK
- `./scripts/build/build_prod.sh` - Build production APK

### Run Scripts
- `./scripts/run_dev.sh` - Run development environment
- `./scripts/run_staging.sh` - Run staging environment
- `./scripts/run_prod.sh` - Run production environment
- `./scripts/run_widgetbook.sh` - Run Widgetbook for component development

## 🎨 Design System

The design system is organized in a separate package with Widgetbook integration:

```bash
# Run Widgetbook for component development
./scripts/run_widgetbook.sh
```

### Package Structure
- **Tokens:** Colors, typography, spacing, and theme definitions
- **Atoms:** Basic UI components (labels, buttons, inputs)
- **Widgetbook:** Interactive component showcase and development environment

## 🌍 Internationalization

The project supports multiple languages with centralized translation management:

- Translation files: `packages/localization/lib/arb/`
- Supported languages: English (en), Spanish (es), Portuguese (pt)
- Generated code: `packages/localization/lib/generated/`

## 🔍 Code Quality

- **Linting:** Shared `analysis_options.yaml` with strict rules
- **Package Imports:** Clean import pattern using single package exports
- **Type Safety:** Strict type checking and null safety
- **Error Handling:** Custom Result pattern for type-safe error management

## 📚 Additional Resources

- **CLAUDE.md** - Detailed technical documentation and architecture guide
- **Widgetbook** - Interactive component library at `./scripts/run_widgetbook.sh`
- **Package Documentation** - Each package contains detailed README files

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

**HLFDev Flutter Template** - Ready for production, optimized for development.