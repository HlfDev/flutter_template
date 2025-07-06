import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  static void t(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.t('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void d(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.d('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void i(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.i('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void w(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.w('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void e(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.e('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  static void f(
    String tag,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _logger.f('[$tag] $message', error: error, stackTrace: stackTrace);
  }
}
