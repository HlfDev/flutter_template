# Creating a New Feature: Step-by-Step Guide

This template makes it easy to create new features following the established architecture patterns. Here's a comprehensive step-by-step guide.

## Step 1: Create Feature Directory Structure

```bash
# Create the feature directory structure
mkdir -p features/your_feature/lib/data/{models,repositories,sources}
mkdir -p features/your_feature/lib/presentation/{view,view_model,widgets}
```

## Step 2: Create pubspec.yaml

Create `features/your_feature/pubspec.yaml`:

```yaml
name: your_feature
description: "Your feature description"
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: ^3.8.1

resolution: workspace

dependencies:
  flutter:
    sdk: flutter

  core:
  design_system:
  localization:

  json_annotation: ^4.9.0
  shimmer: ^3.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner: ^2.4.14
  freezed: ^3.0.6
  json_serializable: ^6.9.0

flutter:
  uses-material-design: true
```

## Step 3: Create Data Layer

### Model (`lib/data/models/your_model.dart`)

```dart
import 'package:core/core.dart';

part 'your_model.freezed.dart';
part 'your_model.g.dart';

@freezed
abstract class YourModel with _$YourModel {
  const factory YourModel({
    required String id,
    required String name,
    // Add your fields
  }) = _YourModel;

  factory YourModel.fromJson(Map<String, Object?> json) =>
      _$YourModelFromJson(json);
}
```

### API (`lib/data/sources/your_api.dart`)

```dart
import 'dart:io';
import 'package:core/core.dart';
import 'package:your_feature/data/models/your_model.dart';

abstract class YourApi {
  Future<Result<List<YourModel>>> getList();
  Future<Result<YourModel>> getById(String id);
  Future<Result<YourModel>> create(YourModel model);
  Future<Result<YourModel>> update(YourModel model);
  Future<Result<void>> delete(String id);
}

class YourApiImpl implements YourApi {
  YourApiImpl({HttpClient? httpClient})
      : _httpClient = httpClient ?? GetIt.I.get<HttpClient>();

  final HttpClient _httpClient;

  @override
  Future<Result<List<YourModel>>> getList() async {
    try {
      final response = await _httpClient.get('/your-endpoint');
      if (response.statusCode != HttpStatus.ok) throw Exception();

      final list = response.data as List<dynamic>;
      final models = list.map((json) => YourModel.fromJson(json)).toList();
      return Result.ok(models);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<YourModel>> create(YourModel model) async {
    try {
      final response = await _httpClient.post('/your-endpoint', model.toJson());
      if (response.statusCode != HttpStatus.created) throw Exception();

      final created = YourModel.fromJson(response.data);
      return Result.ok(created);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    try {
      final response = await _httpClient.delete('/your-endpoint/$id');
      if (response.statusCode != HttpStatus.noContent &&
          response.statusCode != HttpStatus.ok) {
        throw Exception();
      }
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  // Implement other methods...
}
```

### Repository (`lib/data/repositories/your_repository.dart`)

```dart
import 'package:core/core.dart';
import 'package:your_feature/data/models/your_model.dart';
import 'package:your_feature/data/sources/your_api.dart';

abstract class YourRepository {
  Future<Result<List<YourModel>>> getList();
  Future<Result<YourModel>> getById(String id);
  Future<Result<YourModel>> create(YourModel model);
  Future<Result<YourModel>> update(YourModel model);
  Future<Result<void>> delete(String id);
}

class YourRepositoryImpl implements YourRepository {
  YourRepositoryImpl({required YourApi api}) : _api = api;

  final YourApi _api;

  @override
  Future<Result<List<YourModel>>> getList() async {
    return _api.getList();
  }

  @override
  Future<Result<YourModel>> create(YourModel model) async {
    return _api.create(model);
  }

  @override
  Future<Result<void>> delete(String id) async {
    return _api.delete(id);
  }

  // Implement other methods...
}
```

## Step 4: Create Presentation Layer

### Events (`lib/presentation/view_model/your_event.dart`)

```dart
part of 'your_bloc.dart';

sealed class YourEvent extends Equatable {
  const YourEvent();
}

final class FetchItems extends YourEvent {
  const FetchItems();
  @override
  List<Object?> get props => [];
}

final class CreateItem extends YourEvent {
  const CreateItem({required this.item});
  final YourModel item;
  @override
  List<Object?> get props => [item];
}

final class DeleteItem extends YourEvent {
  const DeleteItem({required this.id});
  final String id;
  @override
  List<Object?> get props => [id];
}
```

### States (`lib/presentation/view_model/your_state.dart`)

```dart
part of 'your_bloc.dart';

sealed class YourState extends Equatable {
  const YourState();
}

final class YourInitial extends YourState {
  const YourInitial();
  @override
  List<Object?> get props => [];
}

final class YourLoading extends YourState {
  const YourLoading();
  @override
  List<Object?> get props => [];
}

final class YourLoaded extends YourState {
  const YourLoaded({required this.items});
  final List<YourModel> items;
  @override
  List<Object?> get props => [items];
}

final class YourEmpty extends YourState {
  const YourEmpty();
  @override
  List<Object?> get props => [];
}

final class YourError extends YourState {
  const YourError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}
```

### BLoC (`lib/presentation/view_model/your_bloc.dart`)

```dart
import 'package:core/core.dart';
import 'package:your_feature/data/models/your_model.dart';
import 'package:your_feature/data/repositories/your_repository.dart';

part 'your_event.dart';
part 'your_state.dart';

class YourBloc extends Bloc<YourEvent, YourState> {
  YourBloc({required YourRepository repository})
      : _repository = repository,
        super(const YourInitial()) {
    on<FetchItems>(_onFetchItems);
    on<CreateItem>(_onCreateItem);
    on<DeleteItem>(_onDeleteItem);
  }

  final YourRepository _repository;

  Future<void> _onFetchItems(
    FetchItems event,
    Emitter<YourState> emit,
  ) async {
    emit(const YourLoading());
    final result = await _repository.getList();

    switch (result) {
      case Ok<List<YourModel>>():
        if (result.value.isEmpty) {
          emit(const YourEmpty());
        } else {
          emit(YourLoaded(items: result.value));
        }
      case Error<List<YourModel>>():
        emit(YourError(message: result.error.toString()));
    }
  }

  Future<void> _onCreateItem(
    CreateItem event,
    Emitter<YourState> emit,
  ) async {
    final currentState = state;
    emit(const YourLoading());

    final result = await _repository.create(event.item);

    switch (result) {
      case Ok<YourModel>():
        AppLogger.info('YourBloc', 'Item created: ${result.value.id}');

        // Optimistic update
        if (currentState is YourLoaded) {
          final updatedItems = [...currentState.items, result.value];
          emit(YourLoaded(items: updatedItems));
        } else {
          add(const FetchItems());
        }
      case Error<YourModel>():
        emit(YourError(message: result.error.toString()));
    }
  }

  Future<void> _onDeleteItem(
    DeleteItem event,
    Emitter<YourState> emit,
  ) async {
    final currentState = state;
    emit(const YourLoading());

    final result = await _repository.delete(event.id);

    switch (result) {
      case Ok<void>():
        AppLogger.info('YourBloc', 'Item deleted: ${event.id}');

        // Remove from list
        if (currentState is YourLoaded) {
          final updatedItems =
              currentState.items.where((item) => item.id != event.id).toList();

          if (updatedItems.isEmpty) {
            emit(const YourEmpty());
          } else {
            emit(YourLoaded(items: updatedItems));
          }
        } else {
          add(const FetchItems());
        }
      case Error<void>():
        emit(YourError(message: result.error.toString()));
    }
  }
}
```

### Page (`lib/presentation/view/your_list_page.dart`)

```dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:your_feature/presentation/view/your_list_view.dart';
import 'package:your_feature/presentation/view_model/your_bloc.dart';

class YourListPage extends StatefulWidget {
  const YourListPage({super.key});
  static const String path = '/your_list';

  @override
  State<YourListPage> createState() => _YourListPageState();
}

class _YourListPageState extends State<YourListPage> {
  late YourBloc _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = GetIt.I.get<YourBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return YourListView(viewModel: _viewModel);
  }
}
```

### View (`lib/presentation/view/your_list_view.dart`)

```dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:your_feature/data/models/your_model.dart';
import 'package:your_feature/presentation/view_model/your_bloc.dart';

class YourListView extends StatefulWidget {
  const YourListView({required this.viewModel, super.key});
  final YourBloc viewModel;

  @override
  State<YourListView> createState() => _YourListViewState();
}

class _YourListViewState extends State<YourListView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.add(const FetchItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Feature'),
      ),
      body: BlocBuilder<YourBloc, YourState>(
        bloc: widget.viewModel,
        builder: (context, state) {
          return switch (state) {
            YourInitial() => const Center(child: Text('Welcome!')),
            YourLoading() => const Center(child: CircularProgressIndicator()),
            YourEmpty() => const Center(child: Text('No items found')),
            YourLoaded() => ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.id),
                  );
                },
              ),
            YourError() => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () => widget.viewModel.add(const FetchItems()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
```

## Step 5: Create Feature Module

**Module** (`lib/your_module.dart`):

```dart
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:your_feature/data/repositories/your_repository.dart';
import 'package:your_feature/data/sources/your_api.dart';
import 'package:your_feature/presentation/view/your_list_page.dart';
import 'package:your_feature/presentation/view_model/your_bloc.dart';

class YourModule extends Module {
  @override
  Future<void> registerDependencies({
    required GetIt getIt,
    required AppConfig appConfig,
  }) async {
    AppLogger.info('YourModule', 'Registering Dependencies');

    // Register API
    GetIt.I.registerLazySingleton<YourApi>(() => YourApiImpl());

    // Register Repository
    GetIt.I.registerLazySingleton<YourRepository>(
      () => YourRepositoryImpl(api: GetIt.I.get<YourApi>()),
    );

    // Register BLoC as factory
    GetIt.I.registerFactory<YourBloc>(
      () => YourBloc(repository: GetIt.I.get<YourRepository>()),
    );
  }

  @override
  List<GoRoute> get routes => [
        GoRoute(
          path: YourListPage.path,
          pageBuilder: (context, state) => const MaterialPage(
            child: YourListPage(),
          ),
        ),
      ];
}
```

## Step 6: Register Feature in Workspace

### 1. Add to workspace (`pubspec.yaml` root)

```yaml
workspace:
  - packages/app
  - packages/core
  - packages/design_system
  - packages/localization
  - features/post
  - features/your_feature  # Add this line
```

### 2. Add to app dependencies (`packages/app/pubspec.yaml`)

```yaml
dependencies:
  core:
  localization:
  design_system:
  post:
  your_feature:  # Add this line
```

### 3. Register module (`packages/app/lib/service_locator/service_locator.dart`)

```dart
import 'package:your_feature/your_module.dart';

static final List<Module> _modules = [
  PostModule(),
  YourModule(),  // Add this line
];
```

### 4. Register routes (`packages/app/lib/routing/router.dart`)

```dart
final modules = [
  PostModule(),
  YourModule(),  // Add this line
];
```

## Step 7: Generate Code and Test

```bash
# Get dependencies
flutter pub get

# Generate Freezed files
cd features/your_feature
dart run build_runner build --delete-conflicting-outputs

# Analyze for errors
cd ../..
flutter analyze

# Run the app
./scripts/run_dev.sh
```

## Common Gotchas

1. **Import `dart:io`** for `HttpStatus` constants in API implementations
2. **Use `core` package import** instead of direct `flutter_bloc`, `go_router`, etc.
3. **Add `json_annotation`** to feature dependencies, not just dev dependencies
4. **Use `sealed` classes** for events and states for exhaustive pattern matching
5. **Register BLoCs as factories**, not singletons, for proper lifecycle management
6. **Use `abstract class`** keyword with Freezed models (matches project pattern)
7. **Update `.withOpacity()` to `.withValues(alpha:)`** for latest Flutter API

## Real Examples

See these features in the codebase for complete working examples:

### Post Feature (`features/post/`)
- Full CRUD operations
- Modal dialogs for create/update/delete
- Shimmer loading states
- Empty and error states
- Optimistic updates

### User Feature (`features/user/`)
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

## Quick Reference: Feature Checklist

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
- [ ] Register routes in Router
- [ ] Run `flutter pub get` and `dart run build_runner build`
- [ ] Run `flutter analyze` to verify no errors
