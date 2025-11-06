import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:post/data/repositories/post_repository.dart';
import 'package:post/data/sources/post_api.dart';
import 'package:post/presentation/view/post_list_page.dart';
import 'package:post/presentation/view_model/post_bloc.dart';

class PostModule extends Module {
  @override
  Future<void> registerDependencies({
    required GetIt getIt,
    required AppConfig appConfig,
  }) async {
    AppLogger.info('PostModule', 'Registering Dependencies');

    // Sources
    GetIt.I.registerLazySingleton<PostApi>(() {
      return PostApiImpl(
        httpClient: DioHttpClient(baseUrl: 'http://10.0.2.2:8080'),
      );
    });

    // Repositories
    GetIt.I.registerLazySingleton<PostRepository>(() {
      return PostRepositoryImpl(postApi: GetIt.I.get<PostApi>());
    });

    // ViewModels
    GetIt.I.registerFactory<PostBloc>(() {
      return PostBloc(postRepository: GetIt.I.get<PostRepository>());
    });

    AppLogger.info('PostModule', 'Finished registering Dependencies');
  }

  @override
  List<GoRoute> get routes => [
    GoRoute(
      path: PostListPage.path,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: PostListPage()),
    ),
  ];
}
