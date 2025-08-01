import 'package:core/core.dart';

class AppLogger {
  static Logger? _logger;

  static Logger get _instance {
    if (_logger == null) {
      final config = AppConfig.current;
      _logger = Logger(
        level: config.enableLogging ? Level.debug : Level.off,
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 0,
          lineLength: 80,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.dateAndTime,
        ),
      );
    }
    return _logger!;
  }

  static void debug(
    String tag,
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) => _instance.d('[$tag] $message', error: error, stackTrace: stackTrace);

  static void info(
    String tag,
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) => _instance.i('[$tag] $message', error: error, stackTrace: stackTrace);

  static void warning(
    String tag,
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) => _instance.w('[$tag] $message', error: error, stackTrace: stackTrace);

  static void error(
    String tag,
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) => _instance.e('[$tag] $message', error: error, stackTrace: stackTrace);
}
