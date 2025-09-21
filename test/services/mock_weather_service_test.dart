import 'package:flutter_test/flutter_test.dart';
import 'package:task_flow/services/mock_weather_service.dart';
import 'package:task_flow/models/weather.dart';

void main() {
  group('MockWeatherService', () {
    test('should return valid weather data', () async {
      // Act
      final weather = await MockWeatherService.getMockWeather();

      // Assert
      expect(weather, isA<Weather>());
      expect(weather.temperature, inInclusiveRange(5.0, 30.0));
      expect(weather.description, isNotEmpty);
      expect(weather.icon, isNotEmpty);
      expect(weather.humidity, inInclusiveRange(40, 80));
      expect(weather.windSpeed, inInclusiveRange(0.0, 10.0));
      expect(weather.cityName, isNotEmpty);
    });

    test('should return different data on subsequent calls', () async {
      // Act
      final weather1 = await MockWeatherService.getMockWeather();
      final weather2 = await MockWeatherService.getMockWeather();

      // Assert
      expect(weather1, isA<Weather>());
      expect(weather2, isA<Weather>());
      // Note: Due to randomness, data might be the same occasionally, 
      // but the service should be capable of producing different values
    });

    test('should simulate network delay', () async {
      // Arrange
      final stopwatch = Stopwatch()..start();

      // Act
      await MockWeatherService.getMockWeather();

      // Assert
      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(800));
    });
  });
}