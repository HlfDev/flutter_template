# Dependency Injection

This project uses **GetIt** service locator for dependency injection.

## GetIt Usage

- Register dependencies in feature modules
- Use `registerLazySingleton` for repositories and services
- Use `registerFactory` for BLoCs to ensure proper lifecycle
- Access dependencies using `GetIt.I.get<T>()` or `GetIt.I<T>()`

## Registration Patterns

### Lazy Singletons (for Repositories, Services, APIs)

Use `registerLazySingleton` for stateless services that should be shared across the app:

```dart
// Register API
GetIt.I.registerLazySingleton<PostApi>(() => PostApiImpl());

// Register Repository
GetIt.I.registerLazySingleton<PostRepository>(
  () => PostRepositoryImpl(postApi: GetIt.I.get<PostApi>())
);
```

### Factories (for BLoCs)

Use `registerFactory` for BLoCs to ensure a new instance is created each time:

```dart
// Register BLoC - IMPORTANT: Use registerFactory, not registerLazySingleton
GetIt.I.registerFactory<PostBloc>(
  () => PostBloc(repository: GetIt.I.get<PostRepository>())
);
```

**Why Factory for BLoCs?**
- BLoCs need proper lifecycle management
- Each screen/feature should get a fresh BLoC instance
- BLoCs are automatically disposed when the widget is removed
- Using singleton would cause state persistence issues

## Accessing Dependencies

```dart
// In widgets (during didChangeDependencies)
final bloc = GetIt.I.get<PostBloc>();

// In services/repositories (during construction)
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl({PostApi? postApi})
      : _postApi = postApi ?? GetIt.I.get<PostApi>();

  final PostApi _postApi;
}
```

## Feature Modules

Organize features using the `Module` pattern. Each feature module registers its dependencies and routes.

```dart
abstract class Module {
  Future<void> registerDependencies({
    required GetIt getIt,
    required AppConfig appConfig,
  });

  List<GoRoute> get routes;
}

// Implement in feature
class PostModule extends Module {
  @override
  Future<void> registerDependencies({
    required GetIt getIt,
    required AppConfig appConfig,
  }) async {
    // Register API
    GetIt.I.registerLazySingleton<PostApi>(() => PostApiImpl());

    // Register Repository
    GetIt.I.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(postApi: GetIt.I.get<PostApi>())
    );

    // Register BLoC
    GetIt.I.registerFactory<PostBloc>(
      () => PostBloc(repository: GetIt.I.get<PostRepository>())
    );
  }

  @override
  List<GoRoute> get routes => [
    GoRoute(
      path: PostListPage.path,
      pageBuilder: (context, state) => const MaterialPage(child: PostListPage()),
    ),
  ];
}
```

## Registration in ServiceLocator

All feature modules should be registered in the main `ServiceLocator`:

```dart
class ServiceLocator {
  static Future<void> init() async {
    // Register core dependencies
    GetIt.I.registerLazySingleton<HttpClient>(() => DioClient());

    // Register feature modules
    await PostModule().registerDependencies(
      getIt: GetIt.I,
      appConfig: AppConfig(),
    );
  }
}
```
