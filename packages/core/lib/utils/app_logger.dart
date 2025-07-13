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

  static void t(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _instance.t('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void d(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _instance.d('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void i(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _instance.i('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void w(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _instance.w('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void e(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _instance.e('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void f(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _instance.f('[$tag] $message', error: error, stackTrace: stackTrace);
  }
}
