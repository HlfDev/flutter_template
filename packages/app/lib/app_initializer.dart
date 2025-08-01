import 'dart:ui';

import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.error('FLUTTER_ERROR', details.exception, details.stack);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.error('PLATFORM_ERROR', error, stack);
      return true;
    };

    Bloc.observer = BlocLogger();
  }
}
