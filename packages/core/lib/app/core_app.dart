import 'package:flutter/material.dart';
import 'package:core/app/app_initializer.dart';
import 'package:core/app/service_locator/service_locator.dart';
import 'package:core/app/app_widget.dart';

class CoreApp {
  CoreApp._();

  static Future<void> main() async {
    await AppInitializer.initialize();
    await ServiceLocator.registerDependencies();

    runApp(const AppWidget());
  }
}