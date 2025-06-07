import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  redirect: _redirect,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return SizedBox.shrink();
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return SizedBox.shrink();
      },
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  return null;
}