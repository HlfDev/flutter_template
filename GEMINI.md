# Project Patterns and Best Practices

This document describes the patterns, conventions, and best practices to be followed in this Flutter project.

## Project Structure

The project follows a clean architecture organized in layers, with a feature-based structure.

- **`lib/app`**: Contains the main application configuration, such as the root widget, dependency injection, and route configuration.
- **`lib/core`**: Core and reusable modules throughout the application, such as HTTP clients, helpers, and utilities.
- **`lib/design_system`**: UI components, themes, colors, and other design elements.
- **`lib/features`**: Each application feature has its own directory, containing its data, domain, and presentation layers.
- **`lib/localization`**: Localization and internationalization files.
- **`test`**: Unit and widget tests, following the same directory structure as `lib`.

## State Management

The project uses `flutter_bloc` for state management and `get_it` for dependency injection and service location. For observing events and state changes, a custom `BlocObserver` is used.

## Routing

Navigation is managed by `go_router`. Routes are defined in `lib/app/routing/routes.dart` and the router configuration in `lib/app/routing/router.dart`.

## HTTP Client

`dio` is used for all network calls. The client configuration, including interceptors for logging, is in `lib/core/http`.

## Code Generation

- **`freezed`**: For creating immutable data models and unions.
- **`json_serializable`**: For JSON serialization/deserialization.
- **`widgetbook`**: For documenting and visualizing UI components.

Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate the necessary files.

## Linting

The project uses `flutter_lints` to ensure code quality and consistency. Lint rules are defined in the `analysis_options.yaml` file.

## Localization

Internationalization is done with `flutter_intl`. Translation files are in `lib/localization/arb`.

## Testing

- **Unit and Widget Tests**: Use `flutter_test` and `mocktail` to create mocks.
- **Integration Tests**: Use `integration_test`.

Test files should follow the same directory structure as `lib`.

## Commits

Commits should follow the **Conventional Commits** standard.

Examples:

- `feat: Add new feature`
- `fix: Fix a bug`
- `docs: Add documentation`
- `style: Format code`
- `refactor: Refactor code`
- `test: Add or refactor tests`
- `chore: Update dependencies`