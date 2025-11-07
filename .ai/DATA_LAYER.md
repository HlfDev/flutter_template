# Data Layer

## Data Handling & Serialization

### Immutable Models

Use `freezed` package for generating immutable data classes with built-in equality, copy methods, and JSON serialization.

### JSON Serialization

Combine `freezed` with `json_serializable` for automatic JSON parsing.

### Field Renaming

When encoding data, use `fieldRename: FieldRename.snake` to convert Dart's camelCase fields to snake_case JSON keys.

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

### Code Generation

Always use `build_runner` with the `--delete-conflicting-outputs` flag to regenerate freezed and JSON files:

```shell
dart run build_runner build --delete-conflicting-outputs
```

## Error Handling with Result Type

Use the `Result<T>` sealed class pattern for error handling in repositories and services.

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

## Repository Pattern

Abstract data sources (e.g., API calls, database operations) using Repositories/Services to promote testability.

```dart
// Repository abstraction
abstract class PostRepository {
  Future<Result<List<Post>>> getPosts();
  Future<Result<Post>> getPostById(String id);
  Future<Result<Post>> createPost(Post post);
  Future<Result<Post>> updatePost(Post post);
  Future<Result<void>> deletePost(String id);
}

// Repository implementation
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl({required PostApi postApi}) : _postApi = postApi;

  final PostApi _postApi;

  @override
  Future<Result<List<Post>>> getPosts() async {
    return await _postApi.getPosts();
  }

  @override
  Future<Result<Post>> createPost(Post post) async {
    return await _postApi.createPost(post);
  }

  // ... other methods
}
```

## API Layer

Define API abstractions and implementations:

```dart
import 'dart:io';  // REQUIRED for HttpStatus
import 'package:core/core.dart';

abstract class PostApi {
  Future<Result<List<Post>>> getPosts();
  Future<Result<Post>> createPost(Post post);
  Future<Result<Post>> updatePost(Post post);
  Future<Result<void>> deletePost(String id);
}

class PostApiImpl implements PostApi {
  PostApiImpl({HttpClient? httpClient})
      : _httpClient = httpClient ?? GetIt.I.get<HttpClient>();

  final HttpClient _httpClient;

  @override
  Future<Result<List<Post>>> getPosts() async {
    try {
      final response = await _httpClient.get('/posts');

      // Always check status codes
      if (response.statusCode != HttpStatus.ok) throw Exception();

      final list = response.data as List<dynamic>;
      final posts = list.map((json) => Post.fromJson(json)).toList();
      return Result.ok(posts);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<Post>> createPost(Post post) async {
    try {
      final response = await _httpClient.post('/posts', post.toJson());

      // Use appropriate status code for each operation
      if (response.statusCode != HttpStatus.created) throw Exception();

      final createdPost = Post.fromJson(response.data);
      return Result.ok(createdPost);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  @override
  Future<Result<void>> deletePost(String id) async {
    try {
      final response = await _httpClient.delete('/posts/$id');

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

## Key Patterns

* **Immutable Models:** Use `freezed` for all data models
* **Result Type:** Use `Result<T>` for error handling
* **Repository Pattern:** Abstract data sources with repositories
* **API Abstraction:** Define API interfaces and implementations
* **Status Codes:** Always import `dart:io` and check HTTP status codes explicitly
* **Code Generation:** Run `build_runner` after modifying models
