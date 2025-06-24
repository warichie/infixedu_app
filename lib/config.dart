// ignore_for_file: constant_identifier_names

import 'package:infixedu/config/app_config.dart';

/// app development state
class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  static const String LOCAL = 'local';
}

/// config data class
class ConfigEnvironments {
  ///you need to change from--->
  static const String currentEnvironments = Environments.DEV;
  static const int paginationLimit = 10;

  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.LOCAL,
      'url': 'http://192.168.68.114:3000/',
    },
    {
      'env': Environments.DEV,
      'url': '${AppConfig.domainName}/',
    },
    {
      'env': Environments.QAS,
      'url': 'http://44.195.23.244/',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'AppConstants.baseUrl',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == currentEnvironments,
      orElse: () => _availableEnvironments[1],
    );
  }

  static String getBaseUrl() {
    return _availableEnvironments.firstWhere(
          (d) => d['env'] == currentEnvironments,
          orElse: () => _availableEnvironments[1],
        )['url'] ??
        '';
  }
}
