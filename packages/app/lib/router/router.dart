import 'package:core/core.dart';
import 'package:post/post_module.dart';

GoRouter router() {
  final modules = [PostModule()];

  final routes = modules.expand((module) => module.routes).toList();

  return GoRouter(
    initialLocation: routes.first.path,
    observers: [NavigationLogger()],
    routes: routes,
  );
}
