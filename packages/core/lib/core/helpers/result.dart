sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;
  const factory Result.error(Exception error) = Error._;

  T? get value => null;
  Exception? get error => null;
  bool get isOk => false;
  bool get isError => false;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  @override
  final T value;

  @override
  bool get isOk => true;

  @override
  String toString() => 'Result<\$T>.ok(\$value)';
}

final class Error<T> extends Result<T> {
  const Error._(this.error);

  @override
  final Exception error;

  @override
  bool get isError => true;

  @override
  String toString() => 'Result<\$T>.error(\$error)';
}
