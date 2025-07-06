import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/core/helpers/result.dart';

void main() {
  group('Result', () {
    group('Ok', () {
      test('should store the value correctly', () {
        final result = Result.ok(123);
        expect(result.value, 123);
        expect(result.isOk, isTrue);
        expect(result.isError, isFalse);
      });

      test('should return the correct value when pattern matching', () {
        final result = Result.ok('Success');
        final value = switch (result) {
          Ok(value: final v) => v,
          Error() => null,
        };
        expect(value, 'Success');
      });
    });

    group('Error', () {
      test('should store the error correctly', () {
        final error = Exception('Something went wrong');
        final result = Result.error(error);
        expect(result.error, error);
        expect(result.isOk, isFalse);
        expect(result.isError, isTrue);
      });

      test('should return the correct error when pattern matching', () {
        final error = Exception('Failed');
        final result = Result.error(error);
        final err = switch (result) {
          Ok() => null,
          Error(error: final e) => e,
        };
        expect(err, error);
      });
    });
  });
}
