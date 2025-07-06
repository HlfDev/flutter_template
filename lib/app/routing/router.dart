import 'package:flutter/material.dart';
import 'package:flutter_template/app/routing/routing.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.postList,
  redirect: _redirect,
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      path: Routes.postList,
      builder: (context, state) {
        final viewModel = GetIt.I<PostListViewModel>();
        return PostListView(viewModel: viewModel);
      },
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  return null;
}
