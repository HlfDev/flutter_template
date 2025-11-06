# 🚀 Flutter HLFDev Template

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x.x-blue.svg)](https://flutter.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A production-ready Flutter project template built with multi-package workspace architecture, comprehensive environment support, and robust development tooling. Designed for rapid development with clean architecture patterns and a comprehensive design system.

## 🌟 Features

### Architecture & Organization
- **Multi-Package Workspace:** Organized into `app`, `core`, `design_system`, `localization`, and feature packages for clear separation of concerns
- **Clean Architecture:** Implements layered architecture with presentation, domain, and data layers
- **State Management:** BLoC pattern with abstract classes and Equatable for type-safe state management
- **Dependency Injection:** Module-based dependency injection using GetIt service locator
- **Result Pattern:** Type-safe error handling with sealed Result<T> class and pattern matching

### Development Experience
- **Environment Support:** Development, staging, and production configurations with flavor-specific settings
- **Design System:** Dedicated package with Widgetbook integration for component development
- **Comprehensive Tooling:** Scripts for building, running, testing, and asset generation
- **Clean Imports:** Single package exports for simplified import patterns

### Production Features
- **Internationalization:** Multi-language support with `flutter_localizations`
- **Network Layer:** Robust HTTP client with Dio, interceptors, and error handling
- **Error Handling:** Custom Result pattern for type-safe error management
- **Logging:** Environment-based logging with structured output
- **Testing:** Comprehensive test setup with unit, widget, and BLoC tests

## 🚀 Quick Start

### Prerequisites
- Flutter 3.x.x or later
- Dart SDK 3.x.x or later

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/hlfdev/flutter_template.git
   cd flutter_template
   ```

2. Install dependencies for all packages:
   ```bash
   flutter pub get
   ```

3. Generate code and localization files:
   ```bash
   # Run from project root
   ./scripts/development/run_build_runner.sh
   ./scripts/development/generate_localization.sh
   ```

4. Generate app icons for all flavors:
   ```bash
   ./scripts/icons/generate_all_icons.sh
   ```

## 🏃‍♂️ Running the Application

### Environment-Based Execution

The project supports three environments with different configurations:

| Environment | App Name | Bundle ID | API Base URL | Logging |
|-------------|----------|-----------|--------------|---------|
| **Development** | Flutter Template Dev | `com.hlfdev.flutter_template.dev` | `http://10.0.2.2:8080` | ✅ Enabled |
| **Staging** | Flutter Template Staging | `com.hlfdev.flutter_template.staging` | `https://api-staging.example.com` | ✅ Enabled |
| **Production** | Flutter Template | `com.hlfdev.flutter_template` | `https://api.example.com` | ❌ Disabled |

#### Using Scripts (Recommended)
```bash
# Development environment
./scripts/run_dev.sh

# Staging environment
./scripts/run_staging.sh

# Production environment
./scripts/run_prod.sh

# Design system development
./scripts/run_widgetbook.sh
```

#### Manual Commands
```bash
# Development
flutter run --flavor development --dart-define=ENVIRONMENT=development

# Staging
flutter run --flavor staging --dart-define=ENVIRONMENT=staging

# Production
flutter run --flavor production --dart-define=ENVIRONMENT=production

# Widgetbook
flutter run -t packages/design_system/lib/widgetbook/main_widgetbook.dart
```

## 🏗️ Building for Production

### Using Scripts
```bash
# Build for specific environment
./scripts/build/build_dev.sh      # Development APK
./scripts/build/build_staging.sh  # Staging APK
./scripts/build/build_prod.sh     # Production APK (release)
```

### Manual Commands
```bash
# Development build
flutter build apk --flavor development --dart-define=ENVIRONMENT=development

# Staging build
flutter build apk --flavor staging --dart-define=ENVIRONMENT=staging

# Production release build
flutter build apk --flavor production --dart-define=ENVIRONMENT=production --release
```

## 📂 Project Structure

```
flutter_template/
├── lib/main.dart                    # Entry point - calls AppBootstrap.main()
├── pubspec.yaml                     # Workspace root configuration
├── analysis_options.yaml            # Shared linting rules
├── scripts/                         # Development and build scripts
│   ├── build/                       # Build scripts for each flavor
│   ├── development/                 # Development tools (build_runner, localization)
│   └── icons/                       # Icon generation scripts
├── assets/
│   └── icon/flavors/               # Flavor-specific app icons
└── packages/
    ├── app/                         # App initialization, routing, and service locator
    │   ├── lib/
    │   │   ├── routing/             # GoRouter configuration and routes
    │   │   ├── service_locator/     # GetIt dependency injection
    │   │   └── app.dart             # Main package export
    │   └── pubspec.yaml
    ├── core/                        # Core utilities, networking, and configuration
    │   ├── lib/
    │   │   ├── config/              # Environment and app configuration
    │   │   ├── helpers/             # Result pattern, Command pattern
    │   │   ├── http/                # Dio HTTP client
    │   │   ├── logs/                # BLoC & Http & Router loggers
    │   │   ├── utils/               # AppLogger and utilities
    │   │   └── core.dart            # Main package export
    │   └── pubspec.yaml
    ├── design_system/               # UI components & design tokens
    │   ├── lib/
    │   │   ├── atoms/               # Basic UI components
    │   │   ├── tokens/              # Design tokens (colors, theme)
    │   │   ├── widgetbook/          # Component development environment
    │   │   └── design_system.dart   # Main package export
    │   └── pubspec.yaml
    ├── localization/               # Internationalization and localization
    │   ├── lib/
    │   │   ├── arb/                 # Translation files
    │   │   ├── generated/           # Generated localization code
    │   │   └── localization.dart    # Main package export
    │   └── pubspec.yaml
└── features/
    └── post/                        # Post feature module
        ├── lib/
        │   ├── data/
        │   │   ├── models/          # Data models with freezed & json_serializable
        │   │   ├── repositories/    # Repository implementations
        │   │   └── sources/         # API data sources (PostApi, PostApiImpl)
        │   ├── presentation/
        │   │   ├── view/            # Pages and Views
        │   │   ├── view_model/      # BLoC (post_bloc.dart, post_event.dart, post_state.dart)
        │   │   └── widgets/         # Feature-specific widgets and modals
        │   └── post_module.dart     # Module registration (dependencies & routes)
        └── pubspec.yaml
```

## 🏗️ Architecture Patterns

### BLoC Pattern

This project uses **abstract classes extending Equatable** for BLoC events and states (not sealed classes or freezed).

#### Events
```dart
abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => [];
}

class FetchPosts extends PostEvent {
  final String? query;
  const FetchPosts({this.query});
  @override
  List<Object> get props => query != null ? [query!] : [];
}
```

#### States
```dart
abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}
class PostLoading extends PostState {}
class PostLoaded extends PostState {
  final List<Post> posts;
  const PostLoaded(this.posts);
  @override
  List<Object> get props => [posts];
}
class PostError extends PostState {
  final String message;
  const PostError(this.message);
  @override
  List<Object> get props => [message];
}
```

#### BLoC Implementation
```dart
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    final result = await _postRepository.getPostsList();

    switch (result) {
      case Ok<List<Post>>():
        emit(PostLoaded(result.value));
      case Error<List<Post>>():
        emit(PostError(result.error.toString()));
    }
  }
}
```

### Result Pattern

Type-safe error handling using sealed class with pattern matching:

```dart
// Usage in repositories/APIs
Future<Result<List<Post>>> getPostsList() async {
  try {
    final response = await _httpClient.get('/posts');
    final posts = (response.data as List).map((json) => Post.fromJson(json)).toList();
    return Result.ok(posts);
  } catch (e) {
    return Result.error(Exception('Failed to fetch posts: $e'));
  }
}

// Pattern matching in BLoC
final result = await _postRepository.getPostsList();
switch (result) {
  case Ok<List<Post>>():
    emit(PostLoaded(result.value));
  case Error<List<Post>>():
    emit(PostError(result.error.toString()));
}
```

### Module Pattern

Each feature is a self-contained module that registers dependencies and routes:

```dart
class PostModule extends Module {
  @override
  Future<void> registerDependencies({
    required GetIt getIt,
    required AppConfig appConfig,
  }) async {
    // Sources - lazy singleton
    GetIt.I.registerLazySingleton<PostApi>(() {
      return PostApiImpl(httpClient: DioHttpClient(baseUrl: 'http://10.0.2.2:8080'));
    });

    // Repositories - lazy singleton
    GetIt.I.registerLazySingleton<PostRepository>(() {
      return PostRepositoryImpl(postApi: GetIt.I.get<PostApi>());
    });

    // BLoCs - factory (new instance each time)
    GetIt.I.registerFactory<PostBloc>(() {
      return PostBloc(postRepository: GetIt.I.get<PostRepository>());
    });
  }

  @override
  List<GoRoute> get routes => [
    GoRoute(
      path: PostListPage.path,
      pageBuilder: (context, state) => MaterialPage(child: PostListPage()),
    ),
  ];
}
```

### Page/View Separation

**Page** manages BLoC lifecycle, **View** renders UI:

```dart
// Page - manages BLoC
class PostListPage extends StatefulWidget {
  static const path = '/post_list';
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late final PostBloc _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = GetIt.I<PostBloc>();
  }

  @override
  void dispose() {
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PostListView(viewModel: _viewModel);
  }
}

// View - renders UI
class PostListView extends StatefulWidget {
  final PostBloc viewModel;
  const PostListView({super.key, required this.viewModel});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.add(const FetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostState>(
        bloc: widget.viewModel,
        builder: (context, state) {
          return switch (state) {
            PostInitial() => const PostListEmpty(),
            PostLoading() => const PostListShimmer(),
            PostLoaded() => PostListList(posts: state.posts),
            PostError() => PostListRetry(
                onRetry: () => context.read<PostBloc>().add(const FetchPosts()),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
```

### Repository Pattern

Abstract interface with implementation:

```dart
// Abstract repository
abstract class PostRepository {
  Future<Result<List<Post>>> getPostsList();
  Future<Result<Post>> getPost(String id);
}

// Implementation
class PostRepositoryImpl implements PostRepository {
  final PostApi _postApi;

  PostRepositoryImpl({required PostApi postApi}) : _postApi = postApi;

  @override
  Future<Result<List<Post>>> getPostsList() async {
    return await _postApi.getPostsList();
  }
}
```

### Localization

Use the `context.l10n` extension method:

```dart
// Correct usage
Text(context.l10n.appTitle)
AppBar(title: Text(context.l10n.posts))

// Don't use
AppLocalizations.of(context)!.appTitle
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests for specific package
cd packages/core && flutter test
cd packages/post && flutter test

# Run with coverage
flutter test --coverage
```

## 🔧 Development Scripts

The project includes several convenience scripts in the `scripts/` directory:

### Development Tools
- `./scripts/development/clean_and_get_packages.sh` - Clean and reinstall all dependencies
- `./scripts/development/run_build_runner.sh` - Generate code for all packages
- `./scripts/development/generate_localization.sh` - Generate localization files

### Icon Management
- `./scripts/icons/generate_all_icons.sh` - Generate icons for all flavors
- `./scripts/icons/generate_icons_dev.sh` - Generate development icons only
- `./scripts/icons/generate_icons_staging.sh` - Generate staging icons only
- `./scripts/icons/generate_icons_prod.sh` - Generate production icons only

### Build Scripts
- `./scripts/build/build_dev.sh` - Build development APK
- `./scripts/build/build_staging.sh` - Build staging APK
- `./scripts/build/build_prod.sh` - Build production APK

### Run Scripts
- `./scripts/run_dev.sh` - Run development environment
- `./scripts/run_staging.sh` - Run staging environment
- `./scripts/run_prod.sh` - Run production environment
- `./scripts/run_widgetbook.sh` - Run Widgetbook for component development

## 🎨 Design System

The design system is organized in a separate package with Widgetbook integration:

```bash
# Run Widgetbook for component development
./scripts/run_widgetbook.sh
```

### Package Structure
- **Tokens:** Colors, typography, spacing, and theme definitions
- **Atoms:** Basic UI components (labels, buttons, inputs)
- **Widgetbook:** Interactive component showcase and development environment

## 🌍 Internationalization

The project supports multiple languages with centralized translation management:

- Translation files: `packages/localization/lib/arb/`
- Supported languages: English (en), Spanish (es), Portuguese (pt)
- Generated code: `packages/localization/lib/generated/`

## 🔍 Code Quality

- **Linting:** Shared `analysis_options.yaml` with strict rules
- **Package Imports:** Clean import pattern using single package exports
- **Type Safety:** Strict type checking and null safety
- **Error Handling:** Custom Result pattern for type-safe error management

## 🤖 AI Development Rules

AI development rules are available in the `.ai/` directory to help AI assistants understand the project architecture and maintain code consistency:

- **`.ai/FLUTTER.md`** - Shared Flutter development rules
- **`.ai/CLAUDE.md`** - Symlink to FLUTTER.md (for Anthropic's Claude)
- **`.ai/GEMINI.md`** - Symlink to FLUTTER.md (for Google's Gemini)
- **`.ai/COPILOT.md`** - Rules for GitHub Copilot
- **`.ai/CHATGPT.md`** - Rules for OpenAI's ChatGPT

These files contain comprehensive guidelines on:
- Architecture patterns and project structure
- Code style and naming conventions
- State management with BLoC
- Testing requirements and coverage expectations
- Development workflow and best practices

**For AI assistants:** Please read the appropriate rules file from `.ai/` directory before starting development work.

## 📚 Additional Resources

- **Widgetbook** - Interactive component library at `./scripts/run_widgetbook.sh`
- **Package Documentation** - Each package contains detailed README files
- **AI Development Rules** - See `.ai/` directory for AI assistant guidelines

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

**HLFDev Flutter Template** - Ready for production, optimized for development.