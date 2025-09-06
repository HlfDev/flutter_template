import 'package:core/core.dart';
import 'package:post/post_module.dart';

class ServiceLocator {
  ServiceLocator._();

  static final GetIt _getIt = GetIt.instance;

  static final List<Module> _modules = [PostModule()];

  static Future<void> registerDependencies() async {
    // Configuration
    final appConfig = AppConfig.current;
    _getIt.registerLazySingleton<AppConfig>(() => appConfig);

    // Modules
    for (final module in _modules) {
      module.registerDependencies(getIt: _getIt, appConfig: appConfig);
    }
  }
}
