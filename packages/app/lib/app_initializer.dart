import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.error(
        'FLUTTER_ERROR',
        details,
        error: details.exception,
        stackTrace: details.stack,
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.error(
        'PLATFORM_ERROR',
        'Unknown platform error',
        error: error,
        stackTrace: stack,
      );
      return true;
    };

    Bloc.observer = BlocLogger();
  }
}
