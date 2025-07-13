import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core/observers/bloc_observer.dart';
import 'package:core/core/utils/app_logger.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      AppLogger.e('FLUTTER_ERROR', details.exception, details.stack);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.e('PLATFORM_ERROR', error, stack);
      return true;
    };

    Bloc.observer = AppBlocObserver();
  }
}
