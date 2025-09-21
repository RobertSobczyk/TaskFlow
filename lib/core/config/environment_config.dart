import 'dart:io';
import 'package:task_flow/core/logging/app_logger.dart';

class EnvironmentConfig {
  static final Map<String, String> _env = {};
  static bool _isLoaded = false;

  /// Load environment variables from .env file
  static Future<void> load() async {
    if (_isLoaded) return;

    try {
      // Load from environment variables or use defaults
      // This works on mobile devices with build-time env vars or runtime platform environment
      AppLogger.info('EnvironmentConfig: Loading from environment variables');
    } catch (e) {
      AppLogger.error('EnvironmentConfig: Error loading .env file - $e');
    }
    
    _isLoaded = true;
  }

  static String get(String key, {String? defaultValue}) {
    final envValue = Platform.environment[key];
    if (envValue != null && envValue.isNotEmpty) {
      return envValue;
    }

    final fileValue = _env[key];
    if (fileValue != null && fileValue.isNotEmpty) {
      return fileValue;
    }

    return defaultValue ?? '';
  }

  static String get weatherApiKey {
    // For production/recruitment: use the real API key directly
    // Demo mode only when explicitly set to 'demo_key'
    const realApiKey = 'ac60e7f62c0307f893b2297c977c2383'; // Your real OpenWeatherMap API key
    
    final envKey = get('WEATHER_API_KEY', defaultValue: realApiKey);
    AppLogger.debug('EnvironmentConfig: API key source: ${envKey == realApiKey ? "built-in" : "environment"} (${envKey.length} chars)');
    
    if (envKey == 'demo_key') {
      AppLogger.info('EnvironmentConfig: Using demo mode - demo_key detected');
      return 'demo_key';
    }
    
    AppLogger.info('EnvironmentConfig: Using real API key for weather data');
    return envKey;
  }

  static String get weatherApiBaseUrl {
    return get('WEATHER_API_BASE_URL', 
        defaultValue: 'https://api.openweathermap.org/data/2.5/weather');
  }

  static bool get isDemoMode => weatherApiKey == 'demo_key';
}