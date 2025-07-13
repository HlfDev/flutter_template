import 'package:flutter/material.dart';
import 'package:core/app/app_packages.dart';
import 'package:core/app/routing/routing.dart';
import 'package:feature_post/feature_post.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.postList,
  redirect: _redirect,
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      path: Routes.postList,
      builder: (context, state) => const PostListView(),
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  return null;
}
