class AppConstants {
  AppConstants._();

  // Animation durations
  static const Duration refreshInterval = Duration(seconds: 5);

  // Spacing constants
  static const double spacing_4 = 4.0;
  static const double spacing_8 = 8.0;
  static const double spacing_16 = 16.0;
  static const double spacing_24 = 24.0;
  static const double spacing_32 = 32.0;
  static const double spacing_64 = 64.0;

  // Text overflow and max lines
  static const int maxDescriptionLines = 3;
  // Font sizes
  static const double fontSize_10 = 10.0;
  static const double fontSize_12 = 12.0;
  static const double fontSize_16 = 16.0;
  static const double fontSize_20 = 20.0;

  // Task related constants
  static const Duration defaultTaskDeadlineOffset = Duration(days: 1);
  static const Duration dateRangeExtension = Duration(days: 365);

  // Colors indices for grey palette
  static const int greyColorIndex = 600;

  // Database box names
  static const String taskBoxName = 'tasks';
  static const String completedTaskBoxName = 'completed_tasks';
}
