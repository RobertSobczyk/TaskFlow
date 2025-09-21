import 'dart:math';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/core/logging/app_logger.dart';
import 'package:task_flow/models/weather.dart';

class MockWeatherService {
  static const List<String> _cities = [
    'Warsaw',
    'Kraków', 
    'Gdansk',
    'Wrocław',
    'Poznań',
  ];

  static const List<String> _descriptions = [
    'clear sky',
    'few clouds',
    'scattered clouds',
    'broken clouds', 
    'light rain',
    'moderate rain',
    'overcast clouds',
    'partly cloudy',
  ];

  static const List<String> _icons = [
    '01d', // clear sky
    '02d', // few clouds
    '03d', // scattered clouds
    '04d', // broken clouds
    '09d', // shower rain
    '10d', // rain
    '11d', // thunderstorm
    '13d', // snow
  ];

  static Future<Weather> getMockWeather() async {
    AppLogger.info('MockWeatherService: Generating mock weather data');
    
    // Simulate network delay
    await Future.delayed(AppConstants.mockServiceDelay);
    
    final random = Random();
    
    // Generate realistic Polish weather data
    final temperature = AppConstants.temperatureMin + random.nextInt(AppConstants.temperatureRange).toDouble();
    final description = _descriptions[random.nextInt(_descriptions.length)];
    final icon = _icons[random.nextInt(_icons.length)];
    final humidity = AppConstants.humidityMin + random.nextInt(AppConstants.humidityRange);
    final windSpeed = random.nextDouble() * AppConstants.windSpeedMax;
    final cityName = _cities[random.nextInt(_cities.length)];

    final weather = Weather(
      temperature: temperature,
      description: description,
      icon: icon,
      humidity: humidity,
      windSpeed: windSpeed,
      cityName: cityName,
    );

    AppLogger.info('MockWeatherService: Generated weather - $weather');
    return weather;
  }
}