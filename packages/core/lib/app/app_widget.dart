import 'package:flutter/material.dart';
import 'package:core/app/routing/routing.dart';
import 'package:design_system/design_system.dart';
import 'package:core/localization/localization.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate: router().routerDelegate,
      routeInformationProvider: router().routeInformationProvider,
      routeInformationParser: router().routeInformationParser,
    );
  }
}
