import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

enum CommandStatus { initial, running, success, failure }

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

abstract class Command<T> extends ChangeNotifier {
  Command() : _status = CommandStatus.initial;

  CommandStatus _status;
  CommandStatus get status => _status;

  bool get running => status == CommandStatus.running;
  bool get completed => status == CommandStatus.success;
  bool get error => status == CommandStatus.failure;

  Result<T>? _result;
  Result<T>? get result => _result;

  T? get data => _result is Ok<T> ? (_result as Ok<T>).value : null;

  Exception? get exception =>
      _result is Error<T> ? (_result as Error<T>).error : null;

  void clear() {
    _result = null;
    _status = CommandStatus.initial;
    AppLogger.debug('COMMAND', 'Command cleared: $runtimeType');
    notifyListeners();
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (_status == CommandStatus.running) return;

    _status = CommandStatus.running;
    _result = null;
    AppLogger.debug('COMMAND', 'Command running: $runtimeType');
    notifyListeners();

    final resp = await action();
    _result = resp;
    _status = resp is Ok<T> ? CommandStatus.success : CommandStatus.failure;
    AppLogger.debug(
      'COMMAND',
      'Command finished with status: $_status for $runtimeType'
          '\nData: ${result?.value}',
    );
    notifyListeners();
  }
}

final class Command0<T> extends Command<T> {
  Command0(this._action);
  final CommandAction0<T> _action;
  Future<void> execute() => _execute(_action);
}

final class Command1<T, A> extends Command<T> {
  Command1(this._action);
  final CommandAction1<T, A> _action;
  Future<void> execute(A arg) => _execute(() => _action(arg));
}
