import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task_flow/core/logging/app_logger.dart';

class EnvironmentConfig {
  static bool _isLoaded = false;

  /// Load environment variables from .env file
  static Future<void> load() async {
    if (_isLoaded) return;

    try {
      // Try to load .env file
      await dotenv.load(fileName: ".env");
      AppLogger.info('EnvironmentConfig: Successfully loaded .env file');
    } catch (e) {
      AppLogger.warning('EnvironmentConfig: Could not load .env file - $e');
      AppLogger.info('EnvironmentConfig: Will use platform environment variables or defaults');
    }

    _isLoaded = true;
  }

  static String get(String key, {String? defaultValue}) {
    // First try platform environment variables (for production builds)
    final platformValue = Platform.environment[key];
    if (platformValue != null && platformValue.isNotEmpty) {
      return platformValue;
    }

    // Then try .env file (for development)
    final dotenvValue = dotenv.env[key];
    if (dotenvValue != null && dotenvValue.isNotEmpty) {
      return dotenvValue;
    }

    return defaultValue ?? '';
  }

  static String get weatherApiKey {
    final envKey = get('WEATHER_API_KEY');
    
    if (envKey.isEmpty) {
      AppLogger.error('EnvironmentConfig: WEATHER_API_KEY not found in environment or .env file!');
      AppLogger.info('EnvironmentConfig: Please create .env file with WEATHER_API_KEY=your_key_here');
      return 'demo_key'; // Fallback to demo mode if no key provided
    }

    if (envKey == 'demo_key') {
      AppLogger.info('EnvironmentConfig: Using demo mode - demo_key detected');
      return 'demo_key';
    }

    AppLogger.debug('EnvironmentConfig: Using API key from environment (${envKey.length} chars)');
    return envKey;
  }

  static String get weatherApiBaseUrl {
    return get(
      'WEATHER_API_BASE_URL',
      defaultValue: 'https://api.openweathermap.org/data/2.5/weather',
    );
  }

  static bool get isDemoMode => weatherApiKey == 'demo_key';
}
