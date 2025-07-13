import 'package:core/core.dart';

class AppConfig {
  const AppConfig._({
    required this.appName,
    required this.bundleId,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.environment,
  });

  final String appName;
  final String bundleId;
  final String apiBaseUrl;
  final bool enableLogging;
  final Environment environment;

  static const AppConfig _development = AppConfig._(
    appName: 'Flutter Template Dev',
    bundleId: 'com.hlfdev.flutter_template.dev',
    apiBaseUrl: 'http://10.0.2.2:8080',
    enableLogging: true,
    environment: Environment.development,
  );

  static const AppConfig _staging = AppConfig._(
    appName: 'Flutter Template Staging',
    bundleId: 'com.hlfdev.flutter_template.staging',
    apiBaseUrl: 'http://10.0.2.2:8080',
    enableLogging: true,
    environment: Environment.staging,
  );

  static const AppConfig _production = AppConfig._(
    appName: 'Flutter Template',
    bundleId: 'com.hlfdev.flutter_template',
    apiBaseUrl: 'http://10.0.2.2:8080',
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
