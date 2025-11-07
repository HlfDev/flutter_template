# Documentation Standards

## dartdoc

Write `dartdoc`-style comments for all public APIs.

## Documentation Philosophy

* **Comment wisely:** Use comments to explain why the code is written a certain way, not what the code does. The code itself should be self-explanatory.
* **Document for the user:** Write documentation with the reader in mind. If you had a question and found the answer, add it to the documentation where you first looked. This ensures the documentation answers real-world questions.
* **No useless documentation:** If the documentation only restates the obvious from the code's name, it's not helpful. Good documentation provides context and explains what isn't immediately apparent.
* **Consistency is key:** Use consistent terminology throughout your documentation.

## Commenting Style

* **Use `///` for doc comments:** This allows documentation generation tools to pick them up.
* **Start with a single-sentence summary:** The first sentence should be a concise, user-centric summary ending with a period.
* **Separate the summary:** Add a blank line after the first sentence to create a separate paragraph. This helps tools create better summaries.
* **Avoid redundancy:** Don't repeat information that's obvious from the code's context, like the class name or signature.
* **Don't document both getter and setter:** For properties with both, only document one. The documentation tool will treat them as a single field.

## Writing Style

* **Be brief:** Write concisely.
* **Avoid jargon and acronyms:** Don't use abbreviations unless they are widely understood.
* **Use Markdown sparingly:** Avoid excessive markdown and never use HTML for formatting.
* **Use backticks for code:** Enclose code blocks in backtick fences, and specify the language.

## What to Document

* **Public APIs are a priority:** Always document public APIs.
* **Consider private APIs:** It's a good idea to document private APIs as well.
* **Library-level comments are helpful:** Consider adding a doc comment at the library level to provide a general overview.
* **Include code samples:** Where appropriate, add code samples to illustrate usage.
* **Explain parameters, return values, and exceptions:** Use prose to describe what a function expects, what it returns, and what errors it might throw.
* **Place doc comments before annotations:** Documentation should come before any metadata annotations.

## Project-Specific Documentation Rules

**IMPORTANT:** Focus on quality over quantity. Don't add documentation to every function - only where it adds real value.

### When to Document

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

### When NOT to Document

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

### Good vs Bad Examples

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

### Inline Comments

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

## Summary

**Golden Rule:** If someone reading your code would think "why?" or "what's the context?", add a comment. If they would think "obviously" or "I can see that from the code", don't add a comment.

**Quality over Quantity:** One well-written comment explaining a design decision is worth more than 20 comments restating method names.
