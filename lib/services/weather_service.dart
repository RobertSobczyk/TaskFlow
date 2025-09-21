import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/core/config/environment_config.dart';
import 'package:task_flow/core/logging/app_logger.dart';
import 'package:task_flow/models/weather.dart';
import 'package:task_flow/services/mock_weather_service.dart';

class WeatherService {

  static Future<Weather?> getCurrentWeather() async {
    try {
      AppLogger.info('WeatherService: Getting current weather');
      
      final apiKey = EnvironmentConfig.weatherApiKey;
      final isDemo = EnvironmentConfig.isDemoMode;
      AppLogger.debug('WeatherService: API Key: ${apiKey.substring(0, AppConstants.apiKeyPreviewLength)}..., isDemoMode: $isDemo');
      
      if (isDemo) {
        AppLogger.info('WeatherService: Using mock weather data (demo API key detected)');
        return await MockWeatherService.getMockWeather();
      }
      
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AppLogger.warning('WeatherService: Location permission denied, using mock data');
          return await MockWeatherService.getMockWeather();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        AppLogger.warning('WeatherService: Location permission permanently denied, using mock data');
        return await MockWeatherService.getMockWeather();
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, // Low accuracy is fine for weather
      );

      AppLogger.debug('WeatherService: Got position - lat: ${position.latitude}, lon: ${position.longitude}');

      final url = '${EnvironmentConfig.weatherApiBaseUrl}?lat=${position.latitude}&lon=${position.longitude}&appid=${EnvironmentConfig.weatherApiKey}&units=metric';
      AppLogger.debug('WeatherService: Calling API: ${EnvironmentConfig.weatherApiBaseUrl}?lat=${position.latitude}&lon=${position.longitude}&appid=***&units=metric');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      ).timeout(AppConstants.weatherTimeout);

      if (response.statusCode == AppConstants.httpStatusOk) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final weather = Weather.fromJson(data);
        
        AppLogger.info('WeatherService: Weather data retrieved successfully - ${weather.description}');
        return weather;
      } else {
        AppLogger.warning('WeatherService: API error - Status: ${response.statusCode}, falling back to mock data');
        return await MockWeatherService.getMockWeather();
      }
    } catch (e) {
      AppLogger.warning('WeatherService: Error getting weather - $e, using mock data');
      return await MockWeatherService.getMockWeather();
    }
  }

  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  static Future<LocationPermission> checkLocationPermission() async {
    return await Geolocator.checkPermission();
  }
}