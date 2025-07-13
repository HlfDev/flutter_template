import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.i('NAVIGATION', 'didPush: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.i('NAVIGATION', 'didPop: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppLogger.i('NAVIGATION', 'didRemove: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    AppLogger.i(
      'NAVIGATION',
      'didReplace: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}',
    );
  }
}
