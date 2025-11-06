import 'package:core/core.dart';
import 'package:post/post_module.dart';

GoRouter router() {
  final modules = [PostModule()];
  final routeModules = modules.expand((module) => module.routes).toList();

  return GoRouter(
    initialLocation: routeModules.first.path,
    observers: [NavigationLogger()],
    routes: routeModules,
  );
}
