import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:post/data/apis/post_api.dart';
import 'package:post/data/repositories/post_repository.dart';
import 'package:post/presentation/view/post_list_page.dart';
import 'package:post/presentation/view_model/post_bloc.dart';

class PostModule extends Module {
  @override
  void registerDependencies({
    required GetIt getIt,
    required AppConfig appConfig,
  }) {
    AppLogger.info('PostModule', 'Registering Dependencies');

    // Apis
    GetIt.I.registerLazySingleton<PostApi>(() {
      return PostApi(
        httpClient: DioHttpClient(baseUrl: 'http://10.0.2.2:8080'),
      );
    });

    // Repositories
    GetIt.I.registerLazySingleton<PostRepository>(() {
      return PostRepository(postApi: GetIt.I.get<PostApi>());
    });

    // BLoCs
    GetIt.I.registerFactory<PostBloc>(() {
      return PostBloc(postRepository: GetIt.I.get<PostRepository>());
    });
  }

  @override
  List<GoRoute> get routes => [
    GoRoute(
      path: '/post-list',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: PostListPage()),
    ),
  ];
}
