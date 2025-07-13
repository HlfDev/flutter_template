enum Environment {
  development,
  staging,
  production;

  static Environment get current {
    const String environment = String.fromEnvironment('ENVIRONMENT');
    
    switch (environment) {
      case 'development':
        return Environment.development;
      case 'staging':
        return Environment.staging;
      case 'production':
        return Environment.production;
      default:
        return Environment.development;
    }
  }

  bool get isDevelopment => this == Environment.development;
  bool get isStaging => this == Environment.staging;
  bool get isProduction => this == Environment.production;
}