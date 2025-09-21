class AppConstants {
  AppConstants._();

  // Animation durations
  static const Duration refreshInterval = Duration(seconds: 5);

  // Spacing constants
  static const double spacing_2 = 2.0;
  static const double spacing_4 = 4.0;
  static const double spacing_6 = 6.0;
  static const double spacing_8 = 8.0;
  static const double spacing_12 = 12.0;
  static const double spacing_16 = 16.0;
  static const double spacing_20 = 20.0;
  static const double spacing_24 = 24.0;
  static const double spacing_32 = 32.0;
  static const double spacing_64 = 64.0;

  // Text overflow and max lines
  static const int maxDescriptionLines = 3;
  static const int maxTaskTitleLines = 2;
  static const int maxTaskSingleLine = 1;
  static const double dividerHeight = 1.0;
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

  // Stats UI constants
  static const int statsGridColumns = 2;
  static const double statsGridAspectRatio = 1.8;
  static const double statsIconSize = 24.0;
  static const double statsLargeIconSize = 32.0;
  static const double statsExtraLargeIconSize = 48.0;
  static const double completionRateCircleSize = 60.0;
  static const double completionRateStrokeWidth = 6.0;
  static const double chartHeight = 100.0;
  static const double chartBarWidth = 20.0;
  static const double chartBarHeightOffset = 30.0;
  static const double chartBarMinHeight = 4.0;
  static const double chartBorderRadius = 4.0;
  
  // Stats calculation constants
  static const int recentlyCompletedLimit = 5;
  static const int daysForAverage = 30;
  static const int daysInWeek = 7;
  static const int weekdayStartIndex = 1; // Monday
  static const int todayIndex = 6; // Last day in weekly array
  static const double percentageMultiplier = 100.0;
  
  // Alpha values
  static const double alphaDisabled = 0.2;
  static const double alphaSecondary = 0.5;
  static const double alphaMedium = 0.7;
  static const double alphaHigh = 0.8;


  // Database box names
  static const String taskBoxName = 'tasks';
  static const String completedTaskBoxName = 'completed_tasks';

  // Exception messages
  static const String taskServiceNotInitialized = 'TaskService not initialized';
}
