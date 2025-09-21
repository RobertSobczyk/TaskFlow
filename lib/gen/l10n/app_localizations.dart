import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'TaskFlow'**
  String get appName;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Flow - Todo App'**
  String get appTitle;

  /// No description provided for @addNewTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get addNewTaskTitle;

  /// No description provided for @editTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTaskTitle;

  /// No description provided for @deleteTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTaskTitle;

  /// No description provided for @taskTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Task Title'**
  String get taskTitleLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionLabel;

  /// No description provided for @cancelButtonText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonText;

  /// No description provided for @addTaskButtonText.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTaskButtonText;

  /// No description provided for @updateTaskButtonText.
  ///
  /// In en, this message translates to:
  /// **'Update Task'**
  String get updateTaskButtonText;

  /// No description provided for @deleteButtonText.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButtonText;

  /// No description provided for @activeTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Tasks'**
  String get activeTasksTitle;

  /// No description provided for @tasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasksTitle;

  /// No description provided for @completedTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed Tasks'**
  String get completedTasksTitle;

  /// No description provided for @noTasksMessage.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet. Add one using the + button!'**
  String get noTasksMessage;

  /// No description provided for @pleaseEnterTitleError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a task title'**
  String get pleaseEnterTitleError;

  /// No description provided for @taskAddedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Task added successfully!'**
  String get taskAddedSuccessMessage;

  /// No description provided for @taskUpdatedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Task updated successfully!'**
  String get taskUpdatedSuccessMessage;

  /// No description provided for @deleteTaskConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{taskTitle}\"?'**
  String deleteTaskConfirmationMessage(String taskTitle);

  /// No description provided for @overdueByText.
  ///
  /// In en, this message translates to:
  /// **'Overdue by'**
  String get overdueByText;

  /// No description provided for @dueInText.
  ///
  /// In en, this message translates to:
  /// **'Due in'**
  String get dueInText;

  /// No description provided for @daysText.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get daysText;

  /// No description provided for @hoursText.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hoursText;

  /// No description provided for @minutesText.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutesText;

  /// No description provided for @nowText.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get nowText;

  /// No description provided for @deadlinePrefix.
  ///
  /// In en, this message translates to:
  /// **'Deadline: '**
  String get deadlinePrefix;

  /// No description provided for @timePrefix.
  ///
  /// In en, this message translates to:
  /// **'Time: '**
  String get timePrefix;

  /// No description provided for @taskDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Task \"{taskTitle}\" deleted'**
  String taskDeletedMessage(String taskTitle);

  /// No description provided for @taskServiceNotInitialized.
  ///
  /// In en, this message translates to:
  /// **'TaskService not initialized'**
  String get taskServiceNotInitialized;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Reminder'**
  String get notificationTitle;

  /// No description provided for @notificationBody.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget: {taskTitle}'**
  String notificationBody(String taskTitle);

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'Task Reminders'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Reminders for upcoming task deadlines'**
  String get notificationChannelDescription;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @refreshStatistics.
  ///
  /// In en, this message translates to:
  /// **'Refresh statistics'**
  String get refreshStatistics;

  /// No description provided for @calculatingStatistics.
  ///
  /// In en, this message translates to:
  /// **'Calculating statistics...'**
  String get calculatingStatistics;

  /// No description provided for @errorLoadingStatistics.
  ///
  /// In en, this message translates to:
  /// **'Error loading statistics: {error}'**
  String errorLoadingStatistics(String error);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noStatisticsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No statistics available'**
  String get noStatisticsAvailable;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @totalTasks.
  ///
  /// In en, this message translates to:
  /// **'Total Tasks'**
  String get totalTasks;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get overdue;

  /// No description provided for @completionRate.
  ///
  /// In en, this message translates to:
  /// **'Completion Rate'**
  String get completionRate;

  /// No description provided for @productivityStreaks.
  ///
  /// In en, this message translates to:
  /// **'Productivity Streaks'**
  String get productivityStreaks;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// No description provided for @longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get longestStreak;

  /// No description provided for @dayText.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get dayText;

  /// No description provided for @averagePerDay.
  ///
  /// In en, this message translates to:
  /// **'Average per Day'**
  String get averagePerDay;

  /// No description provided for @tasksText.
  ///
  /// In en, this message translates to:
  /// **'tasks'**
  String get tasksText;

  /// No description provided for @last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get last30Days;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @weeklyProductivity.
  ///
  /// In en, this message translates to:
  /// **'Weekly Productivity'**
  String get weeklyProductivity;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunday;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// No description provided for @dailyAvg.
  ///
  /// In en, this message translates to:
  /// **'Daily Avg'**
  String get dailyAvg;

  /// No description provided for @recentlyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Recently Completed'**
  String get recentlyCompleted;

  /// No description provided for @noCompletedTasksYet.
  ///
  /// In en, this message translates to:
  /// **'No completed tasks yet'**
  String get noCompletedTasksYet;

  /// No description provided for @startCompletingTasks.
  ///
  /// In en, this message translates to:
  /// **'Start completing tasks to see them here'**
  String get startCompletingTasks;

  /// No description provided for @showingXOfYTasks.
  ///
  /// In en, this message translates to:
  /// **'Showing {showing} of {total} completed tasks'**
  String showingXOfYTasks(int showing, int total);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @oneMinuteAgo.
  ///
  /// In en, this message translates to:
  /// **'1 minute ago'**
  String get oneMinuteAgo;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutesAgo(int minutes);

  /// No description provided for @oneHourAgo.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get oneHourAgo;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String hoursAgo(int hours);

  /// No description provided for @oneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get oneDayAgo;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(int days);

  /// No description provided for @weatherLoadingText.
  ///
  /// In en, this message translates to:
  /// **'Loading weather...'**
  String get weatherLoadingText;

  /// No description provided for @weatherUnavailableText.
  ///
  /// In en, this message translates to:
  /// **'Weather unavailable'**
  String get weatherUnavailableText;

  /// No description provided for @refreshWeatherTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh weather'**
  String get refreshWeatherTooltip;

  /// No description provided for @mondayFull.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get mondayFull;

  /// No description provided for @tuesdayFull.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesdayFull;

  /// No description provided for @wednesdayFull.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesdayFull;

  /// No description provided for @thursdayFull.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursdayFull;

  /// No description provided for @fridayFull.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get fridayFull;

  /// No description provided for @saturdayFull.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturdayFull;

  /// No description provided for @sundayFull.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sundayFull;

  /// No description provided for @weatherConditionClear.
  ///
  /// In en, this message translates to:
  /// **'Clear Sky'**
  String get weatherConditionClear;

  /// No description provided for @weatherConditionClouds.
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get weatherConditionClouds;

  /// No description provided for @weatherConditionRain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get weatherConditionRain;

  /// No description provided for @weatherConditionDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Drizzle'**
  String get weatherConditionDrizzle;

  /// No description provided for @weatherConditionThunderstorm.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm'**
  String get weatherConditionThunderstorm;

  /// No description provided for @weatherConditionSnow.
  ///
  /// In en, this message translates to:
  /// **'Snow'**
  String get weatherConditionSnow;

  /// No description provided for @weatherConditionMist.
  ///
  /// In en, this message translates to:
  /// **'Mist'**
  String get weatherConditionMist;

  /// No description provided for @weatherConditionSmoke.
  ///
  /// In en, this message translates to:
  /// **'Smoke'**
  String get weatherConditionSmoke;

  /// No description provided for @weatherConditionHaze.
  ///
  /// In en, this message translates to:
  /// **'Haze'**
  String get weatherConditionHaze;

  /// No description provided for @weatherConditionDust.
  ///
  /// In en, this message translates to:
  /// **'Dust'**
  String get weatherConditionDust;

  /// No description provided for @weatherConditionFog.
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get weatherConditionFog;

  /// No description provided for @weatherConditionSand.
  ///
  /// In en, this message translates to:
  /// **'Sand'**
  String get weatherConditionSand;

  /// No description provided for @weatherConditionAsh.
  ///
  /// In en, this message translates to:
  /// **'Ash'**
  String get weatherConditionAsh;

  /// No description provided for @weatherConditionSquall.
  ///
  /// In en, this message translates to:
  /// **'Squall'**
  String get weatherConditionSquall;

  /// No description provided for @weatherConditionTornado.
  ///
  /// In en, this message translates to:
  /// **'Tornado'**
  String get weatherConditionTornado;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'Wind Speed'**
  String get windSpeed;

  /// No description provided for @feelsLike.
  ///
  /// In en, this message translates to:
  /// **'Feels Like'**
  String get feelsLike;

  /// No description provided for @visibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// No description provided for @pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @uvIndex.
  ///
  /// In en, this message translates to:
  /// **'UV Index'**
  String get uvIndex;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
