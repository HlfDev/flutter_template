# Application Architecture

This project uses a **monorepo workspace structure** with feature-based modular architecture.

## Workspace Structure

The project is organized as a Dart workspace with multiple packages:

```
flutter_template/
├── packages/
│   ├── app/           # Main application entry and setup
│   ├── core/          # Shared utilities, helpers, and base classes
│   ├── design_system/ # UI components and design tokens
│   └── localization/  # i18n and l10n resources
├── features/
│   └── post/          # Feature modules (e.g., post feature)
└── pubspec.yaml       # Root workspace configuration
```

## Feature Architecture

Each feature follows a layered architecture with:
- **Presentation Layer:** Widgets, pages, and BLoCs (view_model)
- **Data Layer:** Models, repositories, and API sources
- **Module:** Dependency registration and routing configuration

```
features/post/
├── lib/
│   ├── data/
│   │   ├── models/        # Freezed data models
│   │   ├── sources/       # API implementations
│   │   └── repositories/  # Repository implementations
│   ├── presentation/
│   │   ├── view/          # Pages and views
│   │   ├── view_model/    # BLoCs (events, states, bloc)
│   │   └── widgets/       # Feature-specific widgets
│   └── post_module.dart   # Module for DI and routing
└── pubspec.yaml
```

## Separation of Concerns

BLoC pattern enforces separation:
- **Model:** Freezed data classes in the data layer
- **View:** Widgets in presentation/view
- **ViewModel:** BLoCs in presentation/view_model

## Core Package

Contains shared functionality:
- Result type for error handling
- HTTP client abstractions (Dio)
- Logging utilities (AppLogger, BlocLogger)
- Module abstraction for feature registration
- Common helpers and extensions

## Feature Module Pattern

Each feature implements the `Module` interface:

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
    // Register dependencies
    GetIt.I.registerLazySingleton<PostApi>(() => PostApiImpl());
    GetIt.I.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(postApi: GetIt.I.get<PostApi>())
    );
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

## Page/View Separation

### Page - BLoC Lifecycle Management

```dart
class PostListPage extends StatefulWidget {
  const PostListPage({super.key});
  static const String path = '/posts';

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late PostBloc _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = GetIt.I.get<PostBloc>();  // Get from DI
  }

  @override
  Widget build(BuildContext context) {
    return PostListView(viewModel: _viewModel);  // Pass to view
  }
}
```

### View - UI Rendering

```dart
class PostListView extends StatefulWidget {
  const PostListView({required this.viewModel, super.key});
  final PostBloc viewModel;

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.add(const FetchPosts());  // Initial fetch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        bloc: widget.viewModel,
        builder: (context, state) {
          return switch (state) {
            PostInitial() => const EmptyView(),
            PostLoading() => const LoadingView(),
            PostLoaded() => ListView(children: state.posts),
            PostError() => ErrorView(message: state.message),
          };
        },
      ),
    );
  }
}
```

## Workspace Configuration

Root `pubspec.yaml`:

```yaml
name: flutter_template
description: A Flutter template project

workspace:
  - packages/app
  - packages/core
  - packages/design_system
  - packages/localization
  - features/post
  - features/user
```

## Best Practices

* Keep features isolated and independent
* Use the core package for shared functionality
* Follow the layered architecture (presentation, data)
* Implement the Module pattern for all features
* Separate Page (lifecycle) from View (UI)
* Register feature modules in ServiceLocator
