import 'package:app/app_initializer.dart';
import 'package:app/app_widget.dart';
import 'package:app/service_locator/service_locator.dart';
import 'package:flutter/material.dart';

class AppBootstrap {
  AppBootstrap._();

  static Future<void> main() async {
    await AppInitializer.init();
    await ServiceLocator.registerDependencies();

    runApp(const AppWidget());
  }
}
