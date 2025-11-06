import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  static Logger? _logger;

  static Logger get _instance {
    _logger ??= Logger(
      level: AppConfig.current.enableLogging || kDebugMode
          ? Level.debug
          : Level.off,

      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 0,
        lineLength: 80,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
    );

    return _logger!;
  }

  static void debug(
    String tag,
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _instance.d(
    '[$tag] ${message.toString()}',
    error: error,
    stackTrace: stackTrace,
  );

  static void info(
    String tag,
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _instance.i(
    '[$tag] ${message.toString()}',
    error: error,
    stackTrace: stackTrace,
  );

  static void warning(
    String tag,
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _instance.w(
    '[$tag] ${message.toString()}',
    error: error,
    stackTrace: stackTrace,
  );

  static void error(
    String tag,
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
  }) => _instance.e(
    '[$tag] ${message.toString()}',
    error: error,
    stackTrace: stackTrace,
  );
}
