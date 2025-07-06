import 'dart:async';

import 'package:flutter_template/core/core.dart';
import 'package:flutter_template/features/post/post.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  ServiceLocator._();

  static Future<void> registerDependencies() async {
    // Apis
    GetIt.I.registerLazySingleton<PostApi>(() {
      AppLogger.i('SERVICE_LOCATOR', 'Registering PostApi');
      return PostApi(
        httpClient: DioHttpClient(baseUrl: 'http://10.0.2.2:8080'),
      );
    });

    // Repositories
    GetIt.I.registerLazySingleton<PostRepository>(() {
      AppLogger.i('SERVICE_LOCATOR', 'Registering PostRepository');
      return PostRepository(postApi: GetIt.I.get<PostApi>());
    });

    // Controllers
    GetIt.I.registerFactory<PostListViewModel>(() {
      AppLogger.i('SERVICE_LOCATOR', 'Registering PostListViewModel');
      return PostListViewModel(postRepository: GetIt.I.get<PostRepository>());
    });
  }
}
