# 🚀 Flutter HLFDev Template

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x.x-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is a robust Flutter project template designed for rapid development, emphasizing a simple architecture and a comprehensive design system. It incorporates best practices for state management, routing, network communication, and internationalization, making it an ideal starting point for scalable and maintainable applications.

## 🌟 Features

-   **Simple Architecture:** Organized into `app`, `core`, `design_system`, and `features` layers for clear separation of concerns.
-   **State Management:** Utilizes `flutter_bloc` for state management and `get_it` for dependency injection and service location. A custom `BlocObserver` is used for observing events and state changes.
-   **Routing:** Implements declarative navigation using `go_router`.
-   **Network Communication:** Built-in HTTP client with `Dio` and logging interceptors for robust API interactions.
-   **Design System:** Dedicated `design_system` module with `Widgetbook` integration for developing and showcasing reusable UI components.
-   **Internationalization (i18n):** Supports multiple languages with `flutter_localizations` and `intl`.
-   **Logging:** Comprehensive logging with `logger` for effective debugging and monitoring.
-   **Testing:** Includes setup for unit, widget, and integration tests.

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

Make sure you have Flutter installed. If not, follow the instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/hlfdev/flutter_template.git
    cd flutter_template
    ```
2.  Get Flutter dependencies:
    ```bash
    flutter pub get
    ```
3.  Generate necessary files (e.g., for Freezed, JSON serialization, and localization):
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    flutter gen-l10n
    ```

### Running the App

To run the app on a connected device or emulator:

```bash
flutter run
```

### Running Widgetbook

To view and develop UI components in isolation using Widgetbook:

```bash
flutter run -t lib/design_system/widgetbook/main_widgetbook.dart
```

### Running Tests

To run all tests:

```bash
flutter test
```

## 📂 Project Structure

-   `lib/`: Main application source code.
    -   `app/`: Application-level configurations, routing, and service location.
        -   `routing/`: `go_router` setup and route definitions.
        -   `service_locator/`: Dependency injection setup with `get_it`.
    -   `core/`: Core functionalities like HTTP clients, helpers, and utilities.
        -   `http/`: `Dio` client and interceptors.
        -   `helpers/`: Utility functions and common patterns.
    -   `design_system/`: Reusable UI components, tokens (colors, sizes), and `Widgetbook` stories.
        -   `tokens/`: Design tokens like `AppColors`, `AppSizes`, `AppBreakpoints`, `AppTheme`.
        -   `atoms/`, `molecules/`, `organisms/`: UI component categorization (example structure).
        -   `widgetbook/`: Widgetbook main file and generated directories.
    -   `features/`: Modularized application features (e.g., `post`). Each feature typically contains:
        -   `data/`: Data sources (APIs), models, and repositories.
        -   `domain/`: Business logic (if applicable, not explicitly shown but implied by clean architecture).
        -   `presentation/`: UI (views, view models, widgets).
    -   `localization/`: Internationalization files (`.arb`) and generated code.
-   `test/`: Unit, widget, and integration tests.
-   `assets/`: Static assets like images and fonts.

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.