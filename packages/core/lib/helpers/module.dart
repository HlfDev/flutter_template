import 'package:core/core.dart';

abstract class Module {
  void registerDependencies({
    required GetIt getIt,
    required AppConfig appConfig,
  });

  List<GoRoute> get routes;
}
