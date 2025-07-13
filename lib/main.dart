import 'package:flutter/material.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/app/app_initializer.dart';
import 'package:flutter_template/app/service_locator/service_locator.dart';

void main() async {
  await AppInitializer.initialize();
  await ServiceLocator.registerDependencies();

  runApp(const AppWidget());
}
