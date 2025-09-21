class AppConstants {
  AppConstants._();

  static const Duration refreshInterval = Duration(seconds: 5);
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
  static const int maxDescriptionLines = 3;
  static const int maxTaskTitleLines = 2;
  static const int maxTaskSingleLine = 1;
  static const double dividerHeight = 1.0;
  static const double fontSize_9 = 9.0;
  static const double fontSize_10 = 10.0;
  static const double fontSize_12 = 12.0;
  static const double fontSize_16 = 16.0;
  static const double fontSize_20 = 20.0;
  static const Duration defaultTaskDeadlineOffset = Duration(days: 1);
  static const Duration dateRangeExtension = Duration(days: 365);
  static const int greyColorIndex = 600;
  static const int orangeColorIndex = 600;
  static const int statsGridColumns = 2;
  static const double statsGridAspectRatio = 1.8;
  static const double statsIconSize = 24.0;
  static const double statsLargeIconSize = 32.0;
  static const double statsExtraLargeIconSize = 48.0;
  static const double statsHugeIconSize = 64.0;
  static const double completionRateCircleSize = 60.0;
  static const double completionRateStrokeWidth = 6.0;
  static const double chartHeight = 100.0;
  static const double chartBarWidth = 20.0;
  static const double chartBarHeightOffset = 30.0;
  static const double chartBarMinHeight = 4.0;
  static const double chartBorderRadius = 4.0;
  static const double chartLegendHeight = 30.0;
  static const int recentlyCompletedLimit = 5;
  static const int daysForAverage = 30;
  static const int daysInWeek = 7;
  static const int weekdayStartIndex = 1; // Monday
  static const int todayIndex = 6; // Last day in weekly array
  static const double percentageMultiplier = 100.0;
  static const double alphaDisabled = 0.2;
  static const double alphaLow = 0.5;
  static const double alphaMedium = 0.7;
  static const double alphaHigh = 0.8;
  static const double borderRadiusSmall = 2.0;
  static const double borderRadiusMedium = 8.0;
  static const double strokeWidthSmall = 2.0;

  // Navigation constants
  static const int tabTasks = 0;
  static const int tabStats = 1;

  // Notification constants
  static const int hexMask = 0x7FFFFFFF; // Safe 32-bit mask

  // Logger constants
  static const int loggerMethodCount = 2;
  static const int loggerErrorMethodCount = 8;
  static const int loggerLineLength = 120;

  // Mock service constants
  static const Duration mockServiceDelay = Duration(milliseconds: 800);
  static const int temperatureMin = 5;
  static const int temperatureRange = 25; // 5-30°C
  static const int humidityMin = 40;
  static const int humidityRange = 40; // 40-80%
  static const double windSpeedMax = 10.0; // 0-10 m/s

  // Time comparison constants
  static const int singleDayDifference = 1;
  static const int singleHour = 1;
  static const int singleMinute = 1;
  static const int minValue = 0;
  static const int initialStreak = 1;

  // UI spacing constants
  static const double spacing_1 = 1.0;

  // Border width constants
  static const double borderWidth_1 = 1.0;

  static const int httpStatusOk = 200;
  static const int apiKeyPreviewLength = 8;
  static const int datePadLength = 2;

  // Database box names
  static const String taskBoxName = 'tasks';
  static const String completedTaskBoxName = 'completed_tasks';

  // Weather API constants
  static const Duration weatherTimeout = Duration(seconds: 30);
  static const Duration locationTimeout = Duration(seconds: 15);

  // String constants
  static const String demoText = 'DEMO';
  static const String streakCurrentKey = 'current';
  static const String streakLongestKey = 'longest';

  // Day keys for localization
  static const List<String> dayKeys = [
    'mondayFull',
    'tuesdayFull',
    'wednesdayFull',
    'thursdayFull',
    'fridayFull',
    'saturdayFull',
    'sundayFull',
  ];

  static const String taskServiceNotInitialized = 'TaskService not initialized';
}
