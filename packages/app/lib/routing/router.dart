import 'package:core/core.dart';
import 'package:post/post.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:app/routing/routes.dart';

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
