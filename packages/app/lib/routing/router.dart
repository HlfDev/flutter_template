import 'package:app/routing/routes.dart';
import 'package:core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:post/post.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.postList,
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      path: Routes.postList,
      builder: (context, state) => const PostListPage(),
    ),
  ],
);
