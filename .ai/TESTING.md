# Testing

## Running Tests

To run tests, use the `run_tests` tool if it is available, otherwise use `flutter test`.

## Test Types

### Unit Tests

Use `package:test` for unit tests.

### BLoC Tests

Use `package:bloc_test` for testing BLoCs.

### Widget Tests

Use `package:flutter_test` for widget tests.

### Integration Tests

Use `package:integration_test` for integration tests.

## Assertions

Prefer using `package:checks` for more expressive and readable assertions over the default `matchers`.

## Testing Best Practices

### Convention

Follow the Arrange-Act-Assert (or Given-When-Then) pattern.

### BLoC Tests

Use `bloc_test` for testing BLoCs. It provides a simple way to test event handling and state transitions.

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

### Unit Tests

Write unit tests for repositories, data sources, and utility functions.

### Widget Tests

Write widget tests for UI components and verify widget behavior.

### Integration Tests

For broader application validation, use integration tests to verify end-to-end user flows.

### integration_test Package

Use the `integration_test` package from the Flutter SDK for integration tests. Add it as a `dev_dependency` in `pubspec.yaml` by specifying `sdk: flutter`.

## Mocks

Use `mocktail` to create mocks for dependencies. Prefer fakes or stubs over mocks when possible.

- Avoid code generation for mocks (don't use mockito with build_runner)
- Use `mocktail` for runtime mocks which doesn't require code generation

```dart
import 'package:mocktail/mocktail.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  late PostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();
  });

  test('should fetch posts successfully', () async {
    // Arrange
    when(() => mockRepository.getPosts())
        .thenAnswer((_) async => Result.ok([Post(id: 1, title: 'Test')]));

    // Act
    final result = await mockRepository.getPosts();

    // Assert
    expect(result, isA<Ok<List<Post>>>());
    verify(() => mockRepository.getPosts()).called(1);
  });
}
```

## Coverage

Aim for high test coverage, especially for BLoCs and repositories.

## Test Organization

```
test/
├── unit/
│   ├── repositories/
│   ├── services/
│   └── utils/
├── bloc/
│   └── post_bloc_test.dart
├── widget/
│   └── post_list_test.dart
└── integration/
    └── user_flow_test.dart
```

## Best Practices Summary

* Follow Arrange-Act-Assert pattern
* Use `bloc_test` for BLoC testing
* Use `mocktail` for mocking (no code generation)
* Write tests for repositories and services
* Test widgets with `flutter_test`
* Use integration tests for end-to-end flows
* Aim for high coverage on critical paths
* Organize tests by type (unit, bloc, widget, integration)
