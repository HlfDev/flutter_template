import 'dart:async';

import 'package:core/core.dart';
import 'package:post/post.dart';

class ServiceLocator {
  ServiceLocator._();

  static Future<void> registerDependencies() async {
    // Configuration
    final config = AppConfig.current;
    GetIt.I.registerLazySingleton<AppConfig>(() => config);

    // Apis
    GetIt.I.registerLazySingleton<PostApi>(() {
      AppLogger.info(
        'SERVICE_LOCATOR',
        'Registering PostApi for ${config.environment.name}',
      );
      return PostApi(httpClient: DioHttpClient(baseUrl: config.apiBaseUrl));
    });

    // Repositories
    GetIt.I.registerLazySingleton<PostRepository>(() {
      AppLogger.info('SERVICE_LOCATOR', 'Registering PostRepository');
      return PostRepository(postApi: GetIt.I.get<PostApi>());
    });

    // BLoCs
    GetIt.I.registerFactory<PostBloc>(() {
      AppLogger.info('SERVICE_LOCATOR', 'Registering PostBloc');
      return PostBloc(postRepository: GetIt.I.get<PostRepository>());
    });
  }
}
