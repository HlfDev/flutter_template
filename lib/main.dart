import 'package:flutter/material.dart';

import 'app/app_locator.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocator.initialize();

  runApp(const AppWidget());
}
