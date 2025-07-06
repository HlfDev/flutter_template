import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_template/core/helpers/command.dart';
import 'package:flutter_template/core/helpers/result.dart';

void main() {
  group('Command0', () {
    test('execute sets status to running, then success on Ok result', () async {
      final command = Command0<String>(() async => Result.ok('Success'));

      expect(command.status, CommandStatus.initial);

      await command.execute();

      expect(command.status, CommandStatus.success);
      expect(command.data, 'Success');
      expect(command.exception, isNull);
    });

    test(
      'execute sets status to running, then failure on Error result',
      () async {
        final error = Exception('Failed');
        final command = Command0<String>(() async => Result.error(error));

        expect(command.status, CommandStatus.initial);

        await command.execute();

        expect(command.status, CommandStatus.failure);
        expect(command.data, isNull);
        expect(command.exception, error);
      },
    );

    test('clear resets command state', () async {
      final command = Command0<String>(() async => Result.ok('Success'));
      await command.execute();

      expect(command.status, CommandStatus.success);

      command.clear();

      expect(command.status, CommandStatus.initial);
      expect(command.data, isNull);
      expect(command.exception, isNull);
    });

    test('running getter returns true when command is running', () async {
      final completer = Completer<Result<String>>();
      final command = Command0<String>(() async => completer.future);

      command.execute();
      expect(command.running, isTrue);

      completer.complete(Result.ok('Done'));
      await Future.delayed(Duration.zero); // Allow state to update
      expect(command.running, isFalse);
    });

    test('completed getter returns true when command is successful', () async {
      final command = Command0<String>(() async => Result.ok('Success'));
      await command.execute();
      expect(command.completed, isTrue);
    });

    test('error getter returns true when command fails', () async {
      final command = Command0<String>(() async => Result.error(Exception()));
      await command.execute();
      expect(command.error, isTrue);
    });
  });

  group('Command1', () {
    test(
      'execute with argument sets status to running, then success',
      () async {
        final command = Command1<String, int>(
          (arg) async => Result.ok('Success $arg'),
        );

        expect(command.status, CommandStatus.initial);

        await command.execute(123);

        expect(command.status, CommandStatus.success);
        expect(command.data, 'Success 123');
        expect(command.exception, isNull);
      },
    );

    test(
      'execute with argument sets status to running, then failure',
      () async {
        final error = Exception('Failed');
        final command = Command1<String, int>(
          (arg) async => Result.error(error),
        );

        expect(command.status, CommandStatus.initial);

        await command.execute(123);

        expect(command.status, CommandStatus.failure);
        expect(command.data, isNull);
        expect(command.exception, error);
      },
    );
  });
}
