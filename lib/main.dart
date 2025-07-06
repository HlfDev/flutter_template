import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/service_locator/service_locator.dart';
import 'package:flutter_template/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.registerDependencies();

  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger.e('FLUTTER_ERROR', details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e('PLATFORM_ERROR', error, stack);
    return true;
  };

  runApp(const AppWidget());
}
