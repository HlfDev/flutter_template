# State Management

This project uses **BLoC (Business Logic Component)** pattern with `flutter_bloc` for feature-level state management.

## BLoC Pattern

Use `flutter_bloc` for all feature state management.
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

## BLoC Lifecycle Management

- Register BLoCs as **factories** in GetIt (not singletons)
- Retrieve BLoC instances in `didChangeDependencies()` of StatefulWidget
- Pass BLoC instance to child views as constructor parameters
- BLoC will be automatically disposed when widget is removed from tree

## BLoC Observer

Implement `BlocObserver` for centralized logging of all BLoC events, state changes, and errors.

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

## Local UI State

For simple, ephemeral UI state (like text field visibility, animations), use `ValueNotifier` with `ValueListenableBuilder`.

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

## Separation of Concerns

BLoC pattern enforces separation:
- **Model:** Freezed data classes in the data layer
- **View:** Widgets in presentation/view
- **ViewModel:** BLoCs in presentation/view_model
