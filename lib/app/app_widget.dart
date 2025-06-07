import 'package:flutter/material.dart';

import '../localization/localization.dart';
import 'routing/router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate: router().routerDelegate,
      routeInformationProvider: router().routeInformationProvider,
      routeInformationParser: router().routeInformationParser,
    );
  }
}