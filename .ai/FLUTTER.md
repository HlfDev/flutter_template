# AI rules for Flutter

You are an expert in Flutter and Dart development. Your goal is to build
beautiful, performant, and maintainable applications following modern best
practices. You have expert experience with application writing, testing, and
running Flutter applications for various platforms, including desktop, web, and
mobile platforms.

## Interaction Guidelines
* **User Persona:** Assume the user is familiar with programming concepts but
  may be new to Dart.
* **Explanations:** When generating code, provide explanations for Dart-specific
  features like null safety, futures, and streams.
* **Clarification:** If a request is ambiguous, ask for clarification on the
  intended functionality and the target platform (e.g., command-line, web,
  server).
* **Dependencies:** When suggesting new dependencies from `pub.dev`, explain
  their benefits.
* **Formatting:** Use the `dart_format` tool to ensure consistent code
  formatting.
* **Fixes:** Use the `dart_fix` tool to automatically fix many common errors,
  and to help code conform to configured analysis options.
* **Linting:** Use the Dart linter with a recommended set of rules to catch
  common issues. Use the `analyze_files` tool to run the linter.

## Project Structure
* **Standard Structure:** Assumes a standard Flutter project structure with
  `lib/main.dart` as the primary application entry point.

## Flutter style guide
* **SOLID Principles:** Apply SOLID principles throughout the codebase.
* **Concise and Declarative:** Write concise, modern, technical Dart code.
  Prefer functional and declarative patterns.
* **Composition over Inheritance:** Favor composition for building complex
  widgets and logic.
* **Immutability:** Prefer immutable data structures. Widgets (especially
  `StatelessWidget`) should be immutable.
* **State Management:** Separate ephemeral state and app state. Use a state
  management solution for app state to handle the separation of concerns.
* **Widgets are for UI:** Everything in Flutter's UI is a widget. Compose
  complex UIs from smaller, reusable widgets.
* **Navigation:** Use a modern routing package like `auto_route` or `go_router`.
  See the [navigation guide](./navigation.md) for a detailed example using
  `go_router`.

## Package Management
* **Pub Tool:** To manage packages, use the `pub` tool, if available.
* **External Packages:** If a new feature requires an external package, use the
  `pub_dev_search` tool, if it is available. Otherwise, identify the most
  suitable and stable package from pub.dev.
* **Adding Dependencies:** To add a regular dependency, use the `pub` tool, if
  it is available. Otherwise, run `flutter pub add <package_name>`.
* **Adding Dev Dependencies:** To add a development dependency, use the `pub`
  tool, if it is available, with `dev:<package name>`. Otherwise, run `flutter
  pub add dev:<package_name>`.
* **Dependency Overrides:** To add a dependency override, use the `pub` tool, if
  it is available, with `override:<package name>:1.0.0`. Otherwise, run `flutter
  pub add override:<package_name>:1.0.0`.
* **Removing Dependencies:** To remove a dependency, use the `pub` tool, if it
  is available. Otherwise, run `dart pub remove <package_name>`.

## Code Quality
* **Code structure:** Adhere to maintainable code structure and separation of
  concerns (e.g., UI logic separate from business logic).
* **Naming conventions:** Avoid abbreviations and use meaningful, consistent,
  descriptive names for variables, functions, and classes.
* **Conciseness:** Write code that is as short as it can be while remaining
  clear.
* **Simplicity:** Write straightforward code. Code that is clever or
  obscure is difficult to maintain.
* **Error Handling:** Anticipate and handle potential errors. Don't let your
  code fail silently.
* **Styling:**
    * Line length: Lines should be 80 characters or fewer.
    * Use `PascalCase` for classes, `camelCase` for
      members/variables/functions/enums, and `snake_case` for files.
* **Functions:**
    * Functions short and with a single purpose (strive for less than 20 lines).
* **Testing:** Write code with testing in mind. Use the `file`, `process`, and
  `platform` packages, if appropriate, so you can inject in-memory and fake
  versions of the objects.
* **Logging:** Use the `logging` package instead of `print`.

## Dart Best Practices
* **Effective Dart:** Follow the official Effective Dart guidelines
  (https://dart.dev/effective-dart)
* **Class Organization:** Define related classes within the same library file.
  For large libraries, export smaller, private libraries from a single top-level
  library.
* **Library Organization:** Group related libraries in the same folder.
* **API Documentation:** Add documentation comments to all public APIs,
  including classes, constructors, methods, and top-level functions.
* **Comments:** Write clear comments for complex or non-obvious code. Avoid
  over-commenting.
* **Trailing Comments:** Don't add trailing comments.
* **Async/Await:** Ensure proper use of `async`/`await` for asynchronous
  operations with robust error handling.
    * Use `Future`s, `async`, and `await` for asynchronous operations.
    * Use `Stream`s for sequences of asynchronous events.
* **Null Safety:** Write code that is soundly null-safe. Leverage Dart's null
  safety features. Avoid `!` unless the value is guaranteed to be non-null.
* **Pattern Matching:** Use pattern matching features where they simplify the
  code.
* **Records:** Use records to return multiple types in situations where defining
  an entire class is cumbersome.
* **Switch Statements:** Prefer using exhaustive `switch` statements or
  expressions, which don't require `break` statements.
* **Exception Handling:** Use `try-catch` blocks for handling exceptions, and
  use exceptions appropriate for the type of exception. Use custom exceptions
  for situations specific to your code.
* **Arrow Functions:** Use arrow syntax for simple one-line functions.

## Flutter Best Practices
* **Immutability:** Widgets (especially `StatelessWidget`) are immutable; when
  the UI needs to change, Flutter rebuilds the widget tree.
* **Composition:** Prefer composing smaller widgets over extending existing
  ones. Use this to avoid deep widget nesting.
* **Private Widgets:** Use small, private `Widget` classes instead of private
  helper methods that return a `Widget`.
* **Build Methods:** Break down large `build()` methods into smaller, reusable
  private Widget classes.
* **List Performance:** Use `ListView.builder` or `SliverList` for long lists to
  create lazy-loaded lists for performance.
* **Isolates:** Use `compute()` to run expensive calculations in a separate
  isolate to avoid blocking the UI thread, such as JSON parsing.
* **Const Constructors:** Use `const` constructors for widgets and in `build()`
  methods whenever possible to reduce rebuilds.
* **Build Method Performance:** Avoid performing expensive operations, like
  network calls or complex computations, directly within `build()` methods.

## API Design Principles
When building reusable APIs, such as a library, follow these principles.

* **Consider the User:** Design APIs from the perspective of the person who will
  be using them. The API should be intuitive and easy to use correctly.
* **Documentation is Essential:** Good documentation is a part of good API
  design. It should be clear, concise, and provide examples.

## Application Architecture
This project uses a **monorepo workspace structure** with feature-based modular architecture.

* **Workspace Structure:** The project is organized as a Dart workspace with multiple packages:
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

* **Feature Architecture:** Each feature follows a layered architecture with:
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

* **Separation of Concerns:** BLoC pattern enforces separation:
  - **Model:** Freezed data classes in the data layer
  - **View:** Widgets in presentation/view
  - **ViewModel:** BLoCs in presentation/view_model

* **Core Package:** Contains shared functionality:
  - Result type for error handling
  - HTTP client abstractions (Dio)
  - Logging utilities (AppLogger, BlocLogger)
  - Module abstraction for feature registration
  - Common helpers and extensions

## Lint Rules

Include the package in the `analysis_options.yaml` file. Use the following
analysis_options.yaml file as a starting point:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    # Add additional lint rules here:
    # avoid_print: false
    # prefer_single_quotes: true
```

### State Management
This project uses **BLoC (Business Logic Component)** pattern with `flutter_bloc` for feature-level state management.

* **BLoC Pattern:** Use `flutter_bloc` for all feature state management.
  - Define events, states, and bloc classes
  - Use pattern matching with sealed classes for state handling
  - Register BLoCs as factories in GetIt for proper lifecycle management

  ```dart
  // 1. Define Events
  sealed class PostEvent extends Equatable {
    const PostEvent();
  }

  final class FetchPosts extends PostEvent {
    const FetchPosts({this.query});
    final String? query;

    @override
    List<Object?> get props => [query];
  }

  // 2. Define States (use sealed classes for exhaustive matching)
  sealed class PostState extends Equatable {
    const PostState();
  }

  final class PostInitial extends PostState {
    @override
    List<Object?> get props => [];
  }

  final class PostLoading extends PostState {
    @override
    List<Object?> get props => [];
  }

  final class PostLoaded extends PostState {
    final List<Post> posts;
    const PostLoaded(this.posts);

    @override
    List<Object?> get props => [posts];
  }

  // 3. Define BLoC
  class PostBloc extends Bloc<PostEvent, PostState> {
    final PostRepository _repository;

    PostBloc({required PostRepository repository})
      : _repository = repository,
        super(PostInitial()) {
      on<FetchPosts>(_onFetchPosts);
    }

    Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
      emit(PostLoading());
      final result = await _repository.getPosts();

      switch (result) {
        case Ok<List<Post>>():
          emit(PostLoaded(result.value));
        case Error<List<Post>>():
          emit(PostError(result.error.toString()));
      }
    }
  }

  // 4. Register in GetIt (in your Module)
  GetIt.I.registerFactory<PostBloc>(() {
    return PostBloc(repository: GetIt.I.get<PostRepository>());
  });

  // 5. Use in Widget with BlocBuilder
  BlocBuilder<PostBloc, PostState>(
    bloc: widget.viewModel,
    builder: (context, state) {
      return switch (state) {
        PostInitial() => const EmptyView(),
        PostLoading() => const LoadingView(),
        PostLoaded() => ListView(children: state.posts),
        PostError() => ErrorView(message: state.message),
      };
    },
  )

  // 6. Dispatch events using context.read
  context.read<PostBloc>().add(const FetchPosts());
  ```

* **BLoC Lifecycle Management:**
  - Register BLoCs as **factories** in GetIt (not singletons)
  - Retrieve BLoC instances in `didChangeDependencies()` of StatefulWidget
  - Pass BLoC instance to child views as constructor parameters
  - BLoC will be automatically disposed when widget is removed from tree

* **BLoC Observer:** Implement `BlocObserver` for centralized logging of all BLoC events, state changes, and errors.

  ```dart
  class BlocLogger extends BlocObserver {
    @override
    void onEvent(Bloc bloc, Object? event) {
      super.onEvent(bloc, event);
      AppLogger.debug('Bloc', '${bloc.runtimeType} $event');
    }

    @override
    void onTransition(Bloc bloc, Transition transition) {
      super.onTransition(bloc, transition);
      AppLogger.debug('Bloc', '${bloc.runtimeType} $transition');
    }

    @override
    void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
      AppLogger.error('BlocError', '${bloc.runtimeType} $error');
      super.onError(bloc, error, stackTrace);
    }
  }

  // Register in main.dart
  Bloc.observer = BlocLogger();
  ```

* **Local UI State:** For simple, ephemeral UI state (like text field visibility, animations), use `ValueNotifier` with `ValueListenableBuilder`.

  ```dart
  final ValueNotifier<bool> _showClearButton = ValueNotifier<bool>(false);

  ValueListenableBuilder<bool>(
    valueListenable: _showClearButton,
    builder: (context, showClear, child) {
      if (!showClear) return const SizedBox.shrink();
      return IconButton(icon: const Icon(Icons.clear));
    },
  );
  ```

* **Dependency Injection:** Use **GetIt** service locator for dependency injection.
  - Register dependencies in feature modules
  - Use `registerLazySingleton` for repositories and services
  - Use `registerFactory` for BLoCs to ensure proper lifecycle
  - Access dependencies using `GetIt.I.get<T>()` or `GetIt.I<T>()`

### Data Flow
* **Data Structures:** Define immutable data structures using `freezed` for models.
* **Data Abstraction:** Abstract data sources (e.g., API calls, database
  operations) using Repositories/Services to promote testability.
* **Error Handling:** Use the `Result<T>` sealed class pattern for error handling in repositories and services.

  ```dart
  // Define Result type
  sealed class Result<T> {
    const Result();
    const factory Result.ok(T value) = Ok._;
    const factory Result.error(Exception error) = Error._;
  }

  final class Ok<T> extends Result<T> {
    const Ok._(this.value);
    final T value;
  }

  final class Error<T> extends Result<T> {
    const Error._(this.error);
    final Exception error;
  }

  // Use in API/Repository
  Future<Result<List<Post>>> getPosts() async {
    try {
      final response = await _httpClient.get('/posts');

      // Always check status code
      if (response.statusCode != HttpStatus.ok) throw Exception();

      final list = response.data as List<dynamic>;
      final posts = list.map((json) => Post.fromJson(json)).toList();
      return Result.ok(posts);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  // IMPORTANT: Always import dart:io for HttpStatus
  import 'dart:io';

  // Handle in BLoC with pattern matching
  final result = await _repository.getPosts();
  switch (result) {
    case Ok<List<Post>>():
      emit(PostLoaded(result.value));
    case Error<List<Post>>():
      emit(PostError(result.error.toString()));
  }
  ```

* **Feature Modules:** Organize features using the `Module` pattern. Each feature module registers its dependencies and routes.

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

### Routing
* **GoRouter:** Use the `go_router` package for declarative navigation, deep
  linking, and web support.
* **GoRouter Setup:** To use `go_router`, first add it to your `pubspec.yaml`
  using the `pub` tool's `add` command.

  ```dart
  // 1. Add the dependency
  // flutter pub add go_router

  // 2. Configure the router
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'details/:id', // Route with a path parameter
            builder: (context, state) {
              final String id = state.pathParameters['id']!;
              return DetailScreen(id: id);
            },
          ),
        ],
      ),
    ],
  );

  // 3. Use it in your MaterialApp
  MaterialApp.router(
    routerConfig: _router,
  );
  ```
* **Authentication Redirects:** Configure `go_router`'s `redirect` property to
  handle authentication flows, ensuring users are redirected to the login screen
  when unauthorized, and back to their intended destination after successful
  login.

* **Navigator:** Use the built-in `Navigator` for short-lived screens that do
  not need to be deep-linkable, such as dialogs or temporary views.

  ```dart
  // Push a new screen onto the stack
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const DetailsScreen()),
  );

  // Pop the current screen to go back
  Navigator.pop(context);
  ```

### Data Handling & Serialization
* **Immutable Models:** Use `freezed` package for generating immutable data classes with built-in equality, copy methods, and JSON serialization.
* **JSON Serialization:** Combine `freezed` with `json_serializable` for automatic JSON parsing.
* **Field Renaming:** When encoding data, use `fieldRename: FieldRename.snake` to convert Dart's camelCase fields to snake_case JSON keys.

  ```dart
  // In your model file (e.g., post.dart)
  import 'package:freezed_annotation/freezed_annotation.dart';

  part 'post.freezed.dart';
  part 'post.g.dart';

  @freezed
  class Post with _$Post {
    const factory Post({
      required int id,
      required String title,
      required String body,
      @Default(false) bool published,
    }) = _Post;

    factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  }

  // Run code generation
  // dart run build_runner build --delete-conflicting-outputs

  // Usage
  final post = Post(id: 1, title: 'Hello', body: 'World');

  // Freezed provides copyWith
  final updatedPost = post.copyWith(title: 'Updated Title');

  // Freezed provides equality
  final post1 = Post(id: 1, title: 'A', body: 'B');
  final post2 = Post(id: 1, title: 'A', body: 'B');
  print(post1 == post2); // true

  // JSON serialization works automatically
  final json = post.toJson();
  final fromJson = Post.fromJson(json);
  ```

* **Code Generation:** Always use `build_runner` with the `--delete-conflicting-outputs` flag to regenerate freezed and JSON files:
  ```shell
  dart run build_runner build --delete-conflicting-outputs
  ```


### Logging
* **AppLogger:** Use the `AppLogger` class from the core package for all logging. It's a wrapper around the `logger` package with consistent formatting.
* **Never use print:** Always use `AppLogger` instead of `print()` statements.
* **Logging Levels:** Use appropriate logging levels: `debug`, `info`, `warning`, `error`.
* **Tag-based Logging:** Always include a descriptive tag as the first parameter to help identify the source.

  ```dart
  import 'package:core/core.dart';

  // Debug logging
  AppLogger.debug('PostBloc', 'Fetching posts with query: $query');

  // Info logging
  AppLogger.info('PostModule', 'Registering Dependencies');

  // Warning logging
  AppLogger.warning('NetworkService', 'Request took longer than expected');

  // Error logging with exception and stack trace
  try {
    // ... code that might fail
  } catch (e, s) {
    AppLogger.error(
      'PostRepository',
      'Failed to fetch posts',
      error: e,
      stackTrace: s,
    );
  }
  ```

* **BLoC Logging:** BLoC events and state transitions are automatically logged via `BlocObserver`. No need to manually log in BLoCs.

* **Logger Configuration:** The logger is configured in `AppLogger` with:
  - Level based on environment (debug mode or AppConfig setting)
  - Pretty printing with colors and emojis
  - Stack trace for errors
  - Timestamps for all logs

## Code Generation
* **Build Runner:** If the project uses code generation, ensure that
  `build_runner` is listed as a dev dependency in `pubspec.yaml`.
* **Code Generation Tasks:** Use `build_runner` for all code generation tasks,
  such as for `json_serializable`.
* **Running Build Runner:** After modifying files that require code generation,
  run the build command:

  ```shell
  dart run build_runner build --delete-conflicting-outputs
  ```

## Testing
* **Running Tests:** To run tests, use the `run_tests` tool if it is available,
  otherwise use `flutter test`.
* **Unit Tests:** Use `package:test` for unit tests.
* **BLoC Tests:** Use `package:bloc_test` for testing BLoCs.
* **Widget Tests:** Use `package:flutter_test` for widget tests.
* **Integration Tests:** Use `package:integration_test` for integration tests.
* **Assertions:** Prefer using `package:checks` for more expressive and readable
  assertions over the default `matchers`.

### Testing Best practices
* **Convention:** Follow the Arrange-Act-Assert (or Given-When-Then) pattern.
* **BLoC Tests:** Use `bloc_test` for testing BLoCs. It provides a simple way to test event handling and state transitions.

  ```dart
  import 'package:bloc_test/bloc_test.dart';
  import 'package:mocktail/mocktail.dart';

  class MockPostRepository extends Mock implements PostRepository {}

  void main() {
    late PostRepository mockRepository;

    setUp(() {
      mockRepository = MockPostRepository();
    });

    group('PostBloc', () {
      blocTest<PostBloc, PostState>(
        'emits [PostLoading, PostLoaded] when FetchPosts succeeds',
        build: () {
          when(() => mockRepository.getPosts())
              .thenAnswer((_) async => Result.ok([Post(id: 1, title: 'Test')]));
          return PostBloc(repository: mockRepository);
        },
        act: (bloc) => bloc.add(const FetchPosts()),
        expect: () => [
          PostLoading(),
          PostLoaded([Post(id: 1, title: 'Test')]),
        ],
        verify: (_) {
          verify(() => mockRepository.getPosts()).called(1);
        },
      );

      blocTest<PostBloc, PostState>(
        'emits [PostLoading, PostError] when FetchPosts fails',
        build: () {
          when(() => mockRepository.getPosts())
              .thenAnswer((_) async => Result.error(Exception('Failed')));
          return PostBloc(repository: mockRepository);
        },
        act: (bloc) => bloc.add(const FetchPosts()),
        expect: () => [
          PostLoading(),
          isA<PostError>(),
        ],
      );
    });
  }
  ```

* **Unit Tests:** Write unit tests for repositories, data sources, and utility functions.
* **Widget Tests:** Write widget tests for UI components and verify widget behavior.
* **Integration Tests:** For broader application validation, use integration
  tests to verify end-to-end user flows.
* **integration_test package:** Use the `integration_test` package from the
  Flutter SDK for integration tests. Add it as a `dev_dependency` in
  `pubspec.yaml` by specifying `sdk: flutter`.
* **Mocks:** Use `mocktail` to create mocks for dependencies. Prefer fakes or stubs over mocks when possible.
  - Avoid code generation for mocks (don't use mockito with build_runner)
  - Use `mocktail` for runtime mocks which doesn't require code generation
* **Coverage:** Aim for high test coverage, especially for BLoCs and repositories.

## Visual Design & Theming
* **UI Design:** Build beautiful and intuitive user interfaces that follow
  modern design guidelines.
* **Responsiveness:** Ensure the app is mobile responsive and adapts to
  different screen sizes, working perfectly on mobile and web.
* **Navigation:** If there are multiple pages for the user to interact with,
  provide an intuitive and easy navigation bar or controls.
* **Typography:** Stress and emphasize font sizes to ease understanding, e.g.,
  hero text, section headlines, list headlines, keywords in paragraphs.
* **Background:** Apply subtle noise texture to the main background to add a
  premium, tactile feel.
* **Shadows:** Multi-layered drop shadows create a strong sense of depth; cards
  have a soft, deep shadow to look "lifted."
* **Icons:** Incorporate icons to enhance the user’s understanding and the
  logical navigation of the app.
* **Interactive Elements:** Buttons, checkboxes, sliders, lists, charts, graphs,
  and other interactive elements have a shadow with elegant use of color to
  create a "glow" effect.

### Theming
* **Centralized Theme:** Define a centralized `ThemeData` object to ensure a
  consistent application-wide style.
* **Light and Dark Themes:** Implement support for both light and dark themes,
  ideal for a user-facing theme toggle (`ThemeMode.light`, `ThemeMode.dark`,
  `ThemeMode.system`).
* **Color Scheme Generation:** Generate harmonious color palettes from a single
  color using `ColorScheme.fromSeed`.

  ```dart
  final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    // ... other theme properties
  );
  ```
* **Color Palette:** Include a wide range of color concentrations and hues in
  the palette to create a vibrant and energetic look and feel.
* **Component Themes:** Use specific theme properties (e.g., `appBarTheme`,
  `elevatedButtonTheme`) to customize the appearance of individual Material
  components.
* **Custom Fonts:** For custom fonts, use the `google_fonts` package. Define a
  `TextTheme` to apply fonts consistently.

  ```dart
  // 1. Add the dependency
  // flutter pub add google_fonts

  // 2. Define a TextTheme with a custom font
  final TextTheme appTextTheme = TextTheme(
    displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.openSans(fontSize: 14),
  );
  ```

### Assets and Images
* **Image Guidelines:** If images are needed, make them relevant and meaningful,
  with appropriate size, layout, and licensing (e.g., freely available). Provide
  placeholder images if real ones are not available.
* **Asset Declaration:** Declare all asset paths in your `pubspec.yaml` file.

    ```yaml
    flutter:
      uses-material-design: true
      assets:
        - assets/images/
    ```

* **Local Images:** Use `Image.asset` for local images from your asset
  bundle.

    ```dart
    Image.asset('assets/images/placeholder.png')
    ```
* **Network images:** Use NetworkImage for images loaded from the network.
* **Cached images:** For cached images, use NetworkImage a package like
  `cached_network_image`.
* **Custom Icons:** Use `ImageIcon` to display an icon from an `ImageProvider`,
  useful for custom icons not in the `Icons` class.
* **Network Images:** Use `Image.network` to display images from a URL, and
  always include `loadingBuilder` and `errorBuilder` for a better user
  experience.

    ```dart
    Image.network(
      'https://picsum.photos/200/300',
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    )
    ```
## UI Theming and Styling Code

* **Responsiveness:** Use `LayoutBuilder` or `MediaQuery` to create responsive
  UIs.
* **Text:** Use `Theme.of(context).textTheme` for text styles.
* **Text Fields:** Configure `textCapitalization`, `keyboardType`, and
* **Responsiveness:** Use `LayoutBuilder` or `MediaQuery` to create responsive
  UIs.
* **Text:** Use `Theme.of(context).textTheme` for text styles.
  remote images.

```dart
// When using network images, always provide an errorBuilder.
Image.network(
  'https://example.com/image.png',
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.error); // Show an error icon
  },
);
```

## Material Theming Best Practices

### Embrace `ThemeData` and Material 3

* **Use `ColorScheme.fromSeed()`:** Use this to generate a complete, harmonious
  color palette for both light and dark modes from a single seed color.
* **Define Light and Dark Themes:** Provide both `theme` and `darkTheme` to your
  `MaterialApp` to support system brightness settings seamlessly.
* **Centralize Component Styles:** Customize specific component themes (e.g.,
  `elevatedButtonTheme`, `cardTheme`, `appBarTheme`) within `ThemeData` to
  ensure consistency.
* **Dark/Light Mode and Theme Toggle:** Implement support for both light and
  dark themes using `theme` and `darkTheme` properties of `MaterialApp`. The
  `themeMode` property can be dynamically controlled (e.g., via a
  `ChangeNotifierProvider`) to allow for toggling between `ThemeMode.light`,
  `ThemeMode.dark`, or `ThemeMode.system`.

```dart
// main.dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  ),
  home: const MyHomePage(),
);
```

### Implement Design Tokens with `ThemeExtension`

For custom styles that aren't part of the standard `ThemeData`, use
`ThemeExtension` to define reusable design tokens.

* **Create a Custom Theme Extension:** Define a class that extends
  `ThemeExtension<T>` and include your custom properties.
* **Implement `copyWith` and `lerp`:** These methods are required for the
  extension to work correctly with theme transitions.
* **Register in `ThemeData`:** Add your custom extension to the `extensions`
  list in your `ThemeData`.
* **Access Tokens in Widgets:** Use `Theme.of(context).extension<MyColors>()!`
  to access your custom tokens.

```dart
// 1. Define the extension
@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({required this.success, required this.danger});

  final Color? success;
  final Color? danger;

  @override
  ThemeExtension<MyColors> copyWith({Color? success, Color? danger}) {
    return MyColors(success: success ?? this.success, danger: danger ?? this.danger);
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      success: Color.lerp(success, other.success, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }
}

// 2. Register it in ThemeData
theme: ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    MyColors(success: Colors.green, danger: Colors.red),
  ],
),

// 3. Use it in a widget
Container(
  color: Theme.of(context).extension<MyColors>()!.success,
)
```

### Styling with `WidgetStateProperty`

* **`WidgetStateProperty.resolveWith`:** Provide a function that receives a
  `Set<WidgetState>` and returns the appropriate value for the current state.
* **`WidgetStateProperty.all`:** A shorthand for when the value is the same for
  all states.

```dart
// Example: Creating a button style that changes color when pressed.
final ButtonStyle myButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return Colors.green; // Color when pressed
      }
      return Colors.red; // Default color
    },
  ),
);
```

## Layout Best Practices

### Building Flexible and Overflow-Safe Layouts

#### For Rows and Columns

* **`Expanded`:** Use to make a child widget fill the remaining available space
  along the main axis.
* **`Flexible`:** Use when you want a widget to shrink to fit, but not
  necessarily grow. Don't combine `Flexible` and `Expanded` in the same `Row` or
  `Column`.
* **`Wrap`:** Use when you have a series of widgets that would overflow a `Row`
  or `Column`, and you want them to move to the next line.

#### For General Content

* **`SingleChildScrollView`:** Use when your content is intrinsically larger
  than the viewport, but is a fixed size.
* **`ListView` / `GridView`:** For long lists or grids of content, always use a
  builder constructor (`.builder`).
* **`FittedBox`:** Use to scale or fit a single child widget within its parent.
* **`LayoutBuilder`:** Use for complex, responsive layouts to make decisions
  based on the available space.

### Layering Widgets with Stack

* **`Positioned`:** Use to precisely place a child within a `Stack` by anchoring it to the edges.
* **`Align`:** Use to position a child within a `Stack` using alignments like `Alignment.center`.

### Advanced Layout with Overlays

* **`OverlayPortal`:** Use this widget to show UI elements (like custom
  dropdowns or tooltips) "on top" of everything else. It manages the
  `OverlayEntry` for you.

  ```dart
  class MyDropdown extends StatefulWidget {
    const MyDropdown({super.key});

    @override
    State<MyDropdown> createState() => _MyDropdownState();
  }

  class _MyDropdownState extends State<MyDropdown> {
    final _controller = OverlayPortalController();

    @override
    Widget build(BuildContext context) {
      return OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (BuildContext context) {
          return const Positioned(
            top: 50,
            left: 10,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('I am an overlay!'),
              ),
            ),
          );
        },
        child: ElevatedButton(
          onPressed: _controller.toggle,
          child: const Text('Toggle Overlay'),
        ),
      );
    }
  }
  ```

## Color Scheme Best Practices

### Contrast Ratios

* **WCAG Guidelines:** Aim to meet the Web Content Accessibility Guidelines
  (WCAG) 2.1 standards.
* **Minimum Contrast:**
    * **Normal Text:** A contrast ratio of at least **4.5:1**.
    * **Large Text:** (18pt or 14pt bold) A contrast ratio of at least **3:1**.

### Palette Selection

* **Primary, Secondary, and Accent:** Define a clear color hierarchy.
* **The 60-30-10 Rule:** A classic design rule for creating a balanced color scheme.
    * **60%** Primary/Neutral Color (Dominant)
    * **30%** Secondary Color
    * **10%** Accent Color

### Complementary Colors

* **Use with Caution:** They can be visually jarring if overused.
* **Best Use Cases:** They are excellent for accent colors to make specific
  elements pop, but generally poor for text and background pairings as they can
  cause eye strain.

### Example Palette

* **Primary:** #0D47A1 (Dark Blue)
* **Secondary:** #1976D2 (Medium Blue)
* **Accent:** #FFC107 (Amber)
* **Neutral/Text:** #212121 (Almost Black)
* **Background:** #FEFEFE (Almost White)

## Font Best Practices

### Font Selection

* **Limit Font Families:** Stick to one or two font families for the entire
  application.
* **Prioritize Legibility:** Choose fonts that are easy to read on screens of
  all sizes. Sans-serif fonts are generally preferred for UI body text.
* **System Fonts:** Consider using platform-native system fonts.
* **Google Fonts:** For a wide selection of open-source fonts, use the
  `google_fonts` package.

### Hierarchy and Scale

* **Establish a Scale:** Define a set of font sizes for different text elements
  (e.g., headlines, titles, body text, captions).
* **Use Font Weight:** Differentiate text effectively using font weights.
* **Color and Opacity:** Use color and opacity to de-emphasize less important
  text.

### Readability

* **Line Height (Leading):** Set an appropriate line height, typically **1.4x to
  1.6x** the font size.
* **Line Length:** For body text, aim for a line length of **45-75 characters**.
* **Avoid All Caps:** Do not use all caps for long-form text.

### Example Typographic Scale

```dart
// In your ThemeData
textTheme: const TextTheme(
  displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(fontSize: 16.0, height: 1.5),
  bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
  labelSmall: TextStyle(fontSize: 11.0, color: Colors.grey),
),
```

## Documentation

* **`dartdoc`:** Write `dartdoc`-style comments for all public APIs.


### Documentation Philosophy

* **Comment wisely:** Use comments to explain why the code is written a certain
  way, not what the code does. The code itself should be self-explanatory.
* **Document for the user:** Write documentation with the reader in mind. If you
  had a question and found the answer, add it to the documentation where you
  first looked. This ensures the documentation answers real-world questions.
* **No useless documentation:** If the documentation only restates the obvious
  from the code's name, it's not helpful. Good documentation provides context
  and explains what isn't immediately apparent.
* **Consistency is key:** Use consistent terminology throughout your
  documentation.

### Commenting Style

* **Use `///` for doc comments:** This allows documentation generation tools to
  pick them up.
* **Start with a single-sentence summary:** The first sentence should be a
  concise, user-centric summary ending with a period.
* **Separate the summary:** Add a blank line after the first sentence to create
  a separate paragraph. This helps tools create better summaries.
* **Avoid redundancy:** Don't repeat information that's obvious from the code's
  context, like the class name or signature.
* **Don't document both getter and setter:** For properties with both, only
  document one. The documentation tool will treat them as a single field.

### Writing Style

* **Be brief:** Write concisely.
* **Avoid jargon and acronyms:** Don't use abbreviations unless they are widely
  understood.
* **Use Markdown sparingly:** Avoid excessive markdown and never use HTML for
  formatting.
* **Use backticks for code:** Enclose code blocks in backtick fences, and
  specify the language.

### What to Document

* **Public APIs are a priority:** Always document public APIs.
* **Consider private APIs:** It's a good idea to document private APIs as well.
* **Library-level comments are helpful:** Consider adding a doc comment at the
  library level to provide a general overview.
* **Include code samples:** Where appropriate, add code samples to illustrate usage.
* **Explain parameters, return values, and exceptions:** Use prose to describe
  what a function expects, what it returns, and what errors it might throw.
* **Place doc comments before annotations:** Documentation should come before
  any metadata annotations.

### Project-Specific Documentation Rules

**IMPORTANT:** Focus on quality over quantity. Don't add documentation to every function - only where it adds real value.

#### When to Document

✅ **DO document:**

1. **Public API Classes and Methods**
   - Classes that are exported and used by other packages
   - Abstract interfaces (APIs, Repositories)
   - Public methods with complex behavior

2. **Non-Obvious Logic**
   - Complex algorithms or calculations
   - Workarounds for bugs or platform issues
   - Performance optimizations
   - Business logic that isn't self-explanatory

3. **Important Context**
   - Why a particular approach was chosen
   - Trade-offs and limitations
   - Dependencies on external systems or APIs
   - State management patterns

4. **Model Classes (Minimal)**
   - Only document the class itself, not individual fields (field names should be self-explanatory)
   - Document unusual field types or constraints

#### When NOT to Document

❌ **DON'T document:**

1. **Self-Explanatory Code**
   - Simple getters/setters
   - Obvious constructors
   - Straightforward CRUD operations
   - Clear method names that explain themselves

2. **Implementation Details**
   - Private helper methods with clear names
   - Simple event handlers
   - Obvious state transitions

3. **Redundant Information**
   - Repeating the method name in different words
   - Stating the obvious from the signature
   - Comments that just restate the code

#### Good vs Bad Examples

**❌ BAD - Obvious and Redundant:**

```dart
/// Abstract interface for User API operations.
abstract class UserApi {
  /// Fetches the list of all users.
  Future<Result<List<User>>> getUserList();

  /// Fetches a single user by ID.
  Future<Result<User>> getUserById(String id);

  /// Creates a new user.
  Future<Result<User>> createUser(User user);

  /// Updates an existing user.
  Future<Result<User>> updateUser(User user);

  /// Deletes a user by ID.
  Future<Result<void>> deleteUser(String id);
}

/// User model representing a user entity.
@freezed
class User with _$User {
  /// Creates a new User instance.
  const factory User({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
  }) = _User;

  /// Creates a User instance from JSON.
  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
```

**✅ GOOD - Minimal and Meaningful:**

```dart
/// Handles all user-related API operations.
///
/// All methods return [Result<T>] for type-safe error handling.
/// Network errors are wrapped in [Result.error] with exception details.
abstract class UserApi {
  Future<Result<List<User>>> getUserList();
  Future<Result<User>> getUserById(String id);
  Future<Result<User>> createUser(User user);
  Future<Result<User>> updateUser(User user);
  Future<Result<void>> deleteUser(String id);
}

/// Represents a user in the system.
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
```

**❌ BAD - Restating the Obvious:**

```dart
/// BLoC that manages user-related business logic and state.
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository repository})
      : _repository = repository,
        super(const UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<CreateUser>(_onCreateUser);
  }

  final UserRepository _repository;

  /// Handles the FetchUsers event.
  Future<void> _onFetchUsers(
    FetchUsers event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    final result = await _repository.getUserList();
    // ... handle result
  }
}
```

**✅ GOOD - Documenting Why and Important Context:**

```dart
/// Manages user state and coordinates with the user repository.
///
/// This BLoC implements optimistic updates for create/update/delete
/// operations to provide better UX. When mutations succeed, the state
/// is updated directly without refetching the entire list.
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository repository})
      : _repository = repository,
        super(const UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<CreateUser>(_onCreateUser);
  }

  final UserRepository _repository;

  Future<void> _onFetchUsers(
    FetchUsers event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    final result = await _repository.getUserList();

    switch (result) {
      case Ok<List<User>>():
        // Emit Empty state for better UX when list is empty
        if (result.value.isEmpty) {
          emit(const UserEmpty());
        } else {
          emit(UserLoaded(users: result.value));
        }
      case Error<List<User>>():
        emit(UserError(message: result.error.toString()));
    }
  }

  Future<void> _onCreateUser(
    CreateUser event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state;
    emit(const UserLoading());

    final result = await _repository.createUser(event.user);

    switch (result) {
      case Ok<User>():
        // Optimistic update: add to existing list instead of refetching
        if (currentState is UserLoaded) {
          final updatedUsers = [...currentState.users, result.value];
          emit(UserLoaded(users: updatedUsers));
        } else {
          add(const FetchUsers());
        }
      case Error<User>():
        emit(UserError(message: result.error.toString()));
    }
  }
}
```

**❌ BAD - Documenting Implementation Details:**

```dart
/// Widget displayed when no users are available.
class UserListEmpty extends StatelessWidget {
  const UserListEmpty({super.key});

  /// Builds the empty state widget.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon widget for visual indication
          Icon(
            Icons.people_outline,
            size: 80,
            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          // Title text
          Text(
            'No users found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
```

**✅ GOOD - Only Document the Widget Purpose:**

```dart
/// Empty state displayed when the user list is empty.
class UserListEmpty extends StatelessWidget {
  const UserListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No users found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'There are no users to display',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
          ),
        ],
      ),
    );
  }
}
```

#### Inline Comments

Use inline comments (`//`) sparingly, only for:

1. **Explaining Why, Not What**
   ```dart
   // ✅ GOOD - Explains reasoning
   // Use noContent or ok status for delete operations per REST spec
   if (response.statusCode != HttpStatus.noContent &&
       response.statusCode != HttpStatus.ok) {
     throw Exception();
   }

   // ❌ BAD - States the obvious
   // Check if status code is ok
   if (response.statusCode != HttpStatus.ok) {
     throw Exception();
   }
   ```

2. **Complex Business Logic**
   ```dart
   // ✅ GOOD - Clarifies non-obvious behavior
   // Optimistic update: add to existing list instead of refetching
   // to avoid showing loading spinner for better UX
   if (currentState is UserLoaded) {
     final updatedUsers = [...currentState.users, result.value];
     emit(UserLoaded(users: updatedUsers));
   }
   ```

3. **Temporary Workarounds**
   ```dart
   // ✅ GOOD - Documents a workaround
   // TODO: Remove when https://github.com/flutter/flutter/issues/12345 is fixed
   // Workaround for iOS keyboard dismissal bug
   FocusScope.of(context).unfocus();
   await Future.delayed(const Duration(milliseconds: 100));
   ```

#### Summary

**Golden Rule:** If someone reading your code would think "why?" or "what's the context?", add a comment. If they would think "obviously" or "I can see that from the code", don't add a comment.

**Quality over Quantity:** One well-written comment explaining a design decision is worth more than 20 comments restating method names.

## Accessibility (A11Y)
Implement accessibility features to empower all users, assuming a wide variety
of users with different physical abilities, mental abilities, age groups,
education levels, and learning styles.

* **Color Contrast:** Ensure text has a contrast ratio of at least **4.5:1**
  against its background.
* **Dynamic Text Scaling:** Test your UI to ensure it remains usable when users
  increase the system font size.
* **Semantic Labels:** Use the `Semantics` widget to provide clear, descriptive
  labels for UI elements.
* **Screen Reader Testing:** Regularly test your app with TalkBack (Android) and
  VoiceOver (iOS).

## Creating a New Feature: Step-by-Step Guide

This section provides practical guidance based on actual feature implementation in this project.

### Feature Creation Checklist

Use this checklist when creating a new feature:

- [ ] Create feature directory structure (`data/`, `presentation/`, `widgets/`)
- [ ] Create `pubspec.yaml` with workspace resolution
- [ ] Define Freezed model with `abstract class` and proper imports
- [ ] Implement API with `dart:io` import for HttpStatus
- [ ] Create Repository abstraction and implementation
- [ ] Define sealed event and state classes as `part` files
- [ ] Implement BLoC with proper event handlers
- [ ] Create Page (BLoC lifecycle) and View (UI rendering)
- [ ] Create feature-specific widgets (empty, loading, error, list)
- [ ] Create Module with DI registration and routes
- [ ] Add feature to workspace (`pubspec.yaml` root)
- [ ] Add feature to app dependencies (`packages/app/pubspec.yaml`)
- [ ] Register module in ServiceLocator
- [ ] Run `flutter pub get` and `dart run build_runner build`
- [ ] Run `flutter analyze` to verify no errors

### Common Patterns and Examples

#### 1. Freezed Model Pattern

```dart
import 'package:core/core.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    String? avatarUrl,  // Optional fields use nullable types
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
```

**Key Points:**
- Use `abstract class` (not just `class`)
- Import from `package:core/core.dart` for Freezed annotations
- Use `part` directives for generated files
- Optional fields should be nullable

#### 2. API Implementation Pattern

```dart
import 'dart:io';  // REQUIRED for HttpStatus
import 'package:core/core.dart';
import 'package:user/data/models/user.dart';

abstract class UserApi {
  Future<Result<List<User>>> getUserList();
  Future<Result<User>> createUser(User user);
  Future<Result<User>> updateUser(User user);
  Future<Result<void>> deleteUser(String id);
}

class UserApiImpl implements UserApi {
  UserApiImpl({HttpClient? httpClient})
      : _httpClient = httpClient ?? GetIt.I.get<HttpClient>();

  final HttpClient _httpClient;

  @override
  Future<Result<List<User>>> getUserList() async {
    try {
      final response = await _httpClient.get('/users');

      // Always check status codes
      if (response.statusCode != HttpStatus.ok) throw Exception();

      final list = response.data as List<dynamic>;
      final users = list.map((json) => User.fromJson(json)).toList();
      return Result.ok(users);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<User>> createUser(User user) async {
    try {
      final response = await _httpClient.post('/users', user.toJson());

      // Use appropriate status code for each operation
      if (response.statusCode != HttpStatus.created) throw Exception();

      final createdUser = User.fromJson(response.data);
      return Result.ok(createdUser);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> deleteUser(String id) async {
    try {
      final response = await _httpClient.delete('/users/$id');

      // Delete can return 204 (noContent) or 200 (ok)
      if (response.statusCode != HttpStatus.noContent &&
          response.statusCode != HttpStatus.ok) {
        throw Exception();
      }

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
```

**Key Points:**
- Always import `dart:io` for `HttpStatus` constants
- Check status codes explicitly (don't rely on exceptions)
- Use appropriate status codes: `ok` (200), `created` (201), `noContent` (204)
- Return `Result<void>` for delete operations
- Wrap errors in `Exception(e)` for consistency

#### 3. BLoC Pattern with State Updates

```dart
import 'package:core/core.dart';
import 'package:user/data/models/user.dart';
import 'package:user/data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository repository})
      : _repository = repository,
        super(const UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<CreateUser>(_onCreateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  final UserRepository _repository;

  Future<void> _onFetchUsers(
    FetchUsers event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    final result = await _repository.getUserList();

    switch (result) {
      case Ok<List<User>>():
        if (result.value.isEmpty) {
          emit(const UserEmpty());  // Handle empty state explicitly
        } else {
          emit(UserLoaded(users: result.value));
        }
      case Error<List<User>>():
        emit(UserError(message: result.error.toString()));
    }
  }

  Future<void> _onCreateUser(
    CreateUser event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state;  // Save current state
    emit(const UserLoading());

    final result = await _repository.createUser(event.user);

    switch (result) {
      case Ok<User>():
        AppLogger.info('UserBloc', 'User created: ${result.value.id}');

        // Optimistic update: add to existing list
        if (currentState is UserLoaded) {
          final updatedUsers = [...currentState.users, result.value];
          emit(UserLoaded(users: updatedUsers));
        } else {
          add(const FetchUsers());  // Refetch if state unclear
        }
      case Error<User>():
        emit(UserError(message: result.error.toString()));
    }
  }

  Future<void> _onDeleteUser(
    DeleteUser event,
    Emitter<UserState> emit,
  ) async {
    final currentState = state;
    emit(const UserLoading());

    final result = await _repository.deleteUser(event.id);

    switch (result) {
      case Ok<void>():
        AppLogger.info('UserBloc', 'User deleted: ${event.id}');

        // Remove from existing list
        if (currentState is UserLoaded) {
          final updatedUsers =
              currentState.users.where((user) => user.id != event.id).toList();

          // Emit empty state if list becomes empty
          if (updatedUsers.isEmpty) {
            emit(const UserEmpty());
          } else {
            emit(UserLoaded(users: updatedUsers));
          }
        } else {
          add(const FetchUsers());
        }
      case Error<void>():
        emit(UserError(message: result.error.toString()));
    }
  }
}
```

**Key Points:**
- Save current state before emitting loading for optimistic updates
- Handle empty list with dedicated `Empty` state
- Use `AppLogger` for debugging (not `print`)
- Implement optimistic updates for better UX
- Refetch data if current state is unclear

#### 4. Page/View Separation Pattern

```dart
// Page - Manages BLoC lifecycle
class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  static const String path = '/user_list';

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late UserBloc _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = GetIt.I.get<UserBloc>();  // Get from DI
  }

  @override
  Widget build(BuildContext context) {
    return UserListView(viewModel: _viewModel);  // Pass to view
  }
}

// View - Renders UI and handles user interaction
class UserListView extends StatefulWidget {
  const UserListView({required this.viewModel, super.key});
  final UserBloc viewModel;

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.add(const FetchUsers());  // Initial fetch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: widget.viewModel,
        builder: (context, state) {
          return switch (state) {
            UserInitial() => const Center(child: Text('Welcome!')),
            UserLoading() => const UserListShimmer(),
            UserEmpty() => const UserListEmpty(),
            UserLoaded() => UserListList(users: state.users),
            UserError() => UserListRetry(
                message: state.message,
                onRetry: () => widget.viewModel.add(const FetchUsers()),
              ),
          };
        },
      ),
    );
  }
}
```

**Key Points:**
- Page retrieves BLoC in `didChangeDependencies()` (not `initState()`)
- View receives BLoC as constructor parameter
- Use `switch` expressions with sealed classes for exhaustive matching
- Create separate widgets for each state (empty, loading, error, loaded)

#### 5. Module Registration Pattern

```dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:user/data/repositories/user_repository.dart';
import 'package:user/data/sources/user_api.dart';
import 'package:user/presentation/view/user_list_page.dart';
import 'package:user/presentation/view_model/user_bloc.dart';

class UserModule extends Module {
  @override
  Future<void> registerDependencies({
    required GetIt getIt,
    required AppConfig appConfig,
  }) async {
    AppLogger.info('UserModule', 'Registering Dependencies');

    // APIs and Repositories: registerLazySingleton
    GetIt.I.registerLazySingleton<UserApi>(() => UserApiImpl());

    GetIt.I.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userApi: GetIt.I.get<UserApi>()),
    );

    // BLoCs: registerFactory (new instance each time)
    GetIt.I.registerFactory<UserBloc>(
      () => UserBloc(repository: GetIt.I.get<UserRepository>()),
    );
  }

  @override
  List<GoRoute> get routes => [
        GoRoute(
          path: UserListPage.path,
          pageBuilder: (context, state) => const MaterialPage(
            child: UserListPage(),
          ),
        ),
      ];
}
```

**Key Points:**
- Use `registerLazySingleton` for APIs and Repositories
- Use `registerFactory` for BLoCs (important for proper lifecycle)
- Always log module initialization with `AppLogger`
- Define routes using page path constants
- Use `MaterialPage` for proper page transitions

### Common Gotchas and Solutions

#### 1. Import Issues

**Problem:** Using `flutter_bloc` or `go_router` directly
```dart
// ❌ DON'T
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
```

**Solution:** Import from core package
```dart
// ✅ DO
import 'package:core/core.dart';
```

#### 2. HttpStatus Not Found

**Problem:** `HttpStatus` constants are undefined
```dart
// ❌ Missing import
if (response.statusCode != HttpStatus.ok) throw Exception();
```

**Solution:** Import dart:io
```dart
// ✅ Add import
import 'dart:io';

if (response.statusCode != HttpStatus.ok) throw Exception();
```

#### 3. Deprecated API Usage

**Problem:** Using old Flutter APIs
```dart
// ❌ Deprecated
color: Colors.blue.withOpacity(0.5)
```

**Solution:** Use new API
```dart
// ✅ Current
color: Colors.blue.withValues(alpha: 0.5)
```

#### 4. json_annotation Dependency

**Problem:** Build runner warns about missing `json_annotation`
```yaml
# ❌ Only in dev_dependencies
dev_dependencies:
  json_annotation: ^4.9.0
```

**Solution:** Add to main dependencies
```yaml
# ✅ In dependencies
dependencies:
  json_annotation: ^4.9.0
```

#### 5. BLoC Registration

**Problem:** BLoC persists between navigations
```dart
// ❌ Wrong registration
GetIt.I.registerLazySingleton<UserBloc>(...);
```

**Solution:** Use factory registration
```dart
// ✅ Correct registration
GetIt.I.registerFactory<UserBloc>(...);
```

### Testing Your Feature

After creating a feature, verify it works:

```bash
# 1. Get dependencies
flutter pub get

# 2. Generate code
cd features/your_feature
dart run build_runner build --delete-conflicting-outputs

# 3. Analyze code
cd ../..
flutter analyze

# 4. Run tests (if available)
flutter test

# 5. Run the app
./scripts/run_dev.sh
```

### Real-World Examples in Codebase

Study these complete implementations:

1. **Post Feature** (`features/post/`)
   - Full CRUD operations
   - Modal dialogs for create/update/delete
   - Shimmer loading states
   - Empty and error states

2. **User Feature** (`features/user/`)
   - List with search functionality
   - Debounced search input
   - Avatar display with fallbacks
   - Popup menu for actions
   - All state variations

Both features demonstrate:
- Complete data layer (model, API, repository)
- Full BLoC implementation (events, states, handlers)
- Comprehensive UI (page, view, widgets)
- Module setup (DI and routing)
- Error handling and loading states