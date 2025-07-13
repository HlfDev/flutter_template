import 'dart:async';

import 'package:flutter_template/app/app_packages.dart';
import 'package:flutter_template/core/core.dart';
import 'package:flutter_template/features/post/data/apis/post_api.dart';
import 'package:flutter_template/features/post/data/repositories/post_repository.dart';
import 'package:flutter_template/features/post/presentation/bloc/post_bloc.dart';

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

    // BLoCs
    GetIt.I.registerFactory<PostBloc>(() {
      AppLogger.i('SERVICE_LOCATOR', 'Registering PostBloc');
      return PostBloc(postRepository: GetIt.I.get<PostRepository>());
    });
  }
}
