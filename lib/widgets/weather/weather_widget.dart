import 'package:flutter/material.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/core/config/environment_config.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';
import 'package:task_flow/models/weather.dart';
import 'package:task_flow/services/weather_service.dart';
import 'package:task_flow/services/weather_localization_service.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Weather? _weather;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final weather = await WeatherService.getCurrentWeather();
      if (mounted) {
        setState(() {
          _weather = weather;
          _isLoading = false;
          if (weather == null) {
            _error = 'Unable to get weather data';
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildWeatherContent() {
    if (_isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: AppConstants.spacing_16,
            height: AppConstants.spacing_16,
            child: const CircularProgressIndicator(strokeWidth: AppConstants.strokeWidthSmall),
          ),
          const SizedBox(width: AppConstants.spacing_8),
          Text(
            AppLocalizations.of(context)!.weatherLoadingText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
    }

    if (_error != null || _weather == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: AppConstants.spacing_20,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(width: AppConstants.spacing_8),
          Text(
            AppLocalizations.of(context)!.weatherUnavailableText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(width: AppConstants.spacing_8),
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: AppConstants.spacing_20,
            ),
            onPressed: _loadWeather,
            tooltip: AppLocalizations.of(context)!.refreshWeatherTooltip,
          ),
        ],
      );
    }

    final weather = _weather!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weather.emoji,
          style: const TextStyle(fontSize: AppConstants.spacing_20),
        ),
        const SizedBox(width: AppConstants.spacing_8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              weather.temperatureString,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  WeatherLocalizationService.getLocalizedWeatherCondition(
                    AppLocalizations.of(context)!,
                    weather.description,
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color?.withValues(
                      alpha: AppConstants.alphaMedium,
                    ),
                  ),
                ),
                if (EnvironmentConfig.isDemoMode) ...[
                  const SizedBox(width: AppConstants.spacing_4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacing_4,
                      vertical: AppConstants.spacing_1,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(
                        alpha: AppConstants.alphaDisabled,
                      ),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                    ),
                    child: Text(
                      AppConstants.demoText,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: AppConstants.fontSize_9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        const SizedBox(width: AppConstants.spacing_8),
        IconButton(
          icon: Icon(
            Icons.refresh,
            size: AppConstants.spacing_16,
          ),
          onPressed: _loadWeather,
          tooltip: AppLocalizations.of(context)!.refreshWeatherTooltip,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacing_16,
        vertical: AppConstants.spacing_12,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(
          alpha: AppConstants.alphaLow,
        ),
        borderRadius: BorderRadius.circular(AppConstants.spacing_8),
      ),
      child: _buildWeatherContent(),
    );
  }
}