import 'package:core/core.dart';

class AppConfig {
  const AppConfig._({
    required this.appName,
    required this.bundleId,
    required this.enableLogging,
    required this.environment,
  });

  final String appName;
  final String bundleId;
  final bool enableLogging;
  final Environment environment;

  static const AppConfig _development = AppConfig._(
    appName: 'Flutter Template Dev',
    bundleId: 'com.hlfdev.flutter_template.dev',
    enableLogging: true,
    environment: Environment.development,
  );

  static const AppConfig _staging = AppConfig._(
    appName: 'Flutter Template Staging',
    bundleId: 'com.hlfdev.flutter_template.staging',
    enableLogging: true,
    environment: Environment.staging,
  );

  static const AppConfig _production = AppConfig._(
    appName: 'Flutter Template',
    bundleId: 'com.hlfdev.flutter_template',
    enableLogging: false,
    environment: Environment.production,
  );

  static AppConfig get current {
    switch (Environment.current) {
      case Environment.development:
        return _development;
      case Environment.staging:
        return _staging;
      case Environment.production:
        return _production;
    }
  }
}
