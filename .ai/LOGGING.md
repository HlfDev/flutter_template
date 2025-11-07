# Logging

## AppLogger

Use the `AppLogger` class from the core package for all logging. It's a wrapper around the `logger` package with consistent formatting.

### Never use print

Always use `AppLogger` instead of `print()` statements.

### Logging Levels

Use appropriate logging levels: `debug`, `info`, `warning`, `error`.

### Tag-based Logging

Always include a descriptive tag as the first parameter to help identify the source.

```dart
import 'package:core/core.dart';

// Debug logging
AppLogger.debug('PostBloc', 'Fetching posts with query: $query');

// Info logging
AppLogger.info('PostModule', 'Registering Dependencies');

// Warning logging
AppLogger.warning('NetworkService', 'Request took longer than expected');

// Error logging with exception and stack trace
try {
  // ... code that might fail
} catch (e, s) {
  AppLogger.error(
    'PostRepository',
    'Failed to fetch posts',
    error: e,
    stackTrace: s,
  );
}
```

## BLoC Logging

BLoC events and state transitions are automatically logged via `BlocObserver`. No need to manually log in BLoCs.

```dart
class BlocLogger extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.debug('Bloc', '${bloc.runtimeType} $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.debug('Bloc', '${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.error('BlocError', '${bloc.runtimeType} $error');
    super.onError(bloc, error, stackTrace);
  }
}

// Register in main.dart
Bloc.observer = BlocLogger();
```

## Logger Configuration

The logger is configured in `AppLogger` with:
- Level based on environment (debug mode or AppConfig setting)
- Pretty printing with colors and emojis
- Stack trace for errors
- Timestamps for all logs

## Best Practices

* Always use `AppLogger` instead of `print()`
* Include descriptive tags for easy filtering
* Use appropriate log levels (debug, info, warning, error)
* Include error and stack trace for errors
* BLoC events are automatically logged - don't duplicate
* Use structured logging for better debugging
