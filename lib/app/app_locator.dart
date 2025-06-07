import 'dart:async';

class AppLocator {
  AppLocator._();

  static Future<void> initialize() async {
    unawaited(_backgroundInitialization());
    await _asyncInitialization();
  }

  static Future<void> _asyncInitialization() async {}
  static Future<void> _backgroundInitialization() async {}
}
