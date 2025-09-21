import 'package:task_flow/gen/l10n/app_localizations.dart';

class WeatherLocalizationService {
  /// Maps weather condition codes from OpenWeatherMap API to localization keys
  static String getLocalizedWeatherCondition(
    AppLocalizations l10n, 
    String condition,
  ) {
    final conditionLower = condition.toLowerCase();
    
    if (conditionLower.contains('clear')) {
      return l10n.weatherConditionClear;
    } else if (conditionLower.contains('cloud')) {
      return l10n.weatherConditionClouds;
    } else if (conditionLower.contains('rain')) {
      return l10n.weatherConditionRain;
    } else if (conditionLower.contains('drizzle')) {
      return l10n.weatherConditionDrizzle;
    } else if (conditionLower.contains('thunderstorm') || conditionLower.contains('storm')) {
      return l10n.weatherConditionThunderstorm;
    } else if (conditionLower.contains('snow')) {
      return l10n.weatherConditionSnow;
    } else if (conditionLower.contains('mist')) {
      return l10n.weatherConditionMist;
    } else if (conditionLower.contains('smoke')) {
      return l10n.weatherConditionSmoke;
    } else if (conditionLower.contains('haze')) {
      return l10n.weatherConditionHaze;
    } else if (conditionLower.contains('dust')) {
      return l10n.weatherConditionDust;
    } else if (conditionLower.contains('fog')) {
      return l10n.weatherConditionFog;
    } else if (conditionLower.contains('sand')) {
      return l10n.weatherConditionSand;
    } else if (conditionLower.contains('ash')) {
      return l10n.weatherConditionAsh;
    } else if (conditionLower.contains('squall')) {
      return l10n.weatherConditionSquall;
    } else if (conditionLower.contains('tornado')) {
      return l10n.weatherConditionTornado;
    }
    
    // Return original description if no match found
    return condition;
  }

  /// Get localized day name from day key
  static String getLocalizedDayName(
    AppLocalizations l10n, 
    String dayKey,
  ) {
    switch (dayKey) {
      case 'mondayFull':
        return l10n.mondayFull;
      case 'tuesdayFull':
        return l10n.tuesdayFull;
      case 'wednesdayFull':
        return l10n.wednesdayFull;
      case 'thursdayFull':
        return l10n.thursdayFull;
      case 'fridayFull':
        return l10n.fridayFull;
      case 'saturdayFull':
        return l10n.saturdayFull;
      case 'sundayFull':
        return l10n.sundayFull;
      default:
        return dayKey; // Fallback to key if not found
    }
  }
}