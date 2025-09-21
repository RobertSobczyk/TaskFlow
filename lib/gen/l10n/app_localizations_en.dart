// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'TaskFlow';

  @override
  String get appTitle => 'Task Flow - Todo App';

  @override
  String get addNewTaskTitle => 'Add New Task';

  @override
  String get editTaskTitle => 'Edit Task';

  @override
  String get deleteTaskTitle => 'Delete Task';

  @override
  String get taskTitleLabel => 'Task Title';

  @override
  String get descriptionLabel => 'Description (optional)';

  @override
  String get cancelButtonText => 'Cancel';

  @override
  String get addTaskButtonText => 'Add Task';

  @override
  String get updateTaskButtonText => 'Update Task';

  @override
  String get deleteButtonText => 'Delete';

  @override
  String get activeTasksTitle => 'Active Tasks';

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get completedTasksTitle => 'Completed Tasks';

  @override
  String get noTasksMessage => 'No tasks yet. Add one using the + button!';

  @override
  String get pleaseEnterTitleError => 'Please enter a task title';

  @override
  String get taskAddedSuccessMessage => 'Task added successfully!';

  @override
  String get taskUpdatedSuccessMessage => 'Task updated successfully!';

  @override
  String deleteTaskConfirmationMessage(String taskTitle) {
    return 'Are you sure you want to delete \"$taskTitle\"?';
  }

  @override
  String get overdueByText => 'Overdue by';

  @override
  String get dueInText => 'Due in';

  @override
  String get daysText => 'days';

  @override
  String get hoursText => 'hours';

  @override
  String get minutesText => 'minutes';

  @override
  String get nowText => 'now';

  @override
  String get deadlinePrefix => 'Deadline: ';

  @override
  String get timePrefix => 'Time: ';

  @override
  String taskDeletedMessage(String taskTitle) {
    return 'Task \"$taskTitle\" deleted';
  }

  @override
  String get taskServiceNotInitialized => 'TaskService not initialized';

  @override
  String get settings => 'Settings';

  @override
  String get systemTheme => 'System Theme';

  @override
  String get lightTheme => 'Light Theme';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get notificationTitle => 'Task Reminder';

  @override
  String notificationBody(String taskTitle) {
    return 'Don\'t forget: $taskTitle';
  }

  @override
  String get notificationChannelName => 'Task Reminders';

  @override
  String get notificationChannelDescription =>
      'Reminders for upcoming task deadlines';

  @override
  String get statistics => 'Statistics';

  @override
  String get refreshStatistics => 'Refresh statistics';

  @override
  String get calculatingStatistics => 'Calculating statistics...';

  @override
  String errorLoadingStatistics(String error) {
    return 'Error loading statistics: $error';
  }

  @override
  String get retry => 'Retry';

  @override
  String get noStatisticsAvailable => 'No statistics available';

  @override
  String get overview => 'Overview';

  @override
  String get totalTasks => 'Total Tasks';

  @override
  String get completed => 'Completed';

  @override
  String get active => 'Active';

  @override
  String get overdue => 'Overdue';

  @override
  String get completionRate => 'Completion Rate';

  @override
  String get productivityStreaks => 'Productivity Streaks';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String get longestStreak => 'Longest Streak';

  @override
  String get dayText => 'day';

  @override
  String get averagePerDay => 'Average per Day';

  @override
  String get tasksText => 'tasks';

  @override
  String get last30Days => 'Last 30 days';

  @override
  String get good => 'Good';

  @override
  String get low => 'Low';

  @override
  String get weeklyProductivity => 'Weekly Productivity';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get monday => 'Mon';

  @override
  String get tuesday => 'Tue';

  @override
  String get wednesday => 'Wed';

  @override
  String get thursday => 'Thu';

  @override
  String get friday => 'Fri';

  @override
  String get saturday => 'Sat';

  @override
  String get sunday => 'Sun';

  @override
  String get thisWeek => 'This Week';

  @override
  String get dailyAvg => 'Daily Avg';

  @override
  String get recentlyCompleted => 'Recently Completed';

  @override
  String get noCompletedTasksYet => 'No completed tasks yet';

  @override
  String get startCompletingTasks => 'Start completing tasks to see them here';

  @override
  String showingXOfYTasks(int showing, int total) {
    return 'Showing $showing of $total completed tasks';
  }

  @override
  String get justNow => 'Just now';

  @override
  String get oneMinuteAgo => '1 minute ago';

  @override
  String minutesAgo(int minutes) {
    return '$minutes minutes ago';
  }

  @override
  String get oneHourAgo => '1 hour ago';

  @override
  String hoursAgo(int hours) {
    return '$hours hours ago';
  }

  @override
  String get oneDayAgo => '1 day ago';

  @override
  String daysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get weatherLoadingText => 'Loading weather...';

  @override
  String get weatherUnavailableText => 'Weather unavailable';

  @override
  String get refreshWeatherTooltip => 'Refresh weather';

  @override
  String get mondayFull => 'Monday';

  @override
  String get tuesdayFull => 'Tuesday';

  @override
  String get wednesdayFull => 'Wednesday';

  @override
  String get thursdayFull => 'Thursday';

  @override
  String get fridayFull => 'Friday';

  @override
  String get saturdayFull => 'Saturday';

  @override
  String get sundayFull => 'Sunday';

  @override
  String get weatherConditionClear => 'Clear Sky';

  @override
  String get weatherConditionClouds => 'Cloudy';

  @override
  String get weatherConditionRain => 'Rain';

  @override
  String get weatherConditionDrizzle => 'Drizzle';

  @override
  String get weatherConditionThunderstorm => 'Thunderstorm';

  @override
  String get weatherConditionSnow => 'Snow';

  @override
  String get weatherConditionMist => 'Mist';

  @override
  String get weatherConditionSmoke => 'Smoke';

  @override
  String get weatherConditionHaze => 'Haze';

  @override
  String get weatherConditionDust => 'Dust';

  @override
  String get weatherConditionFog => 'Fog';

  @override
  String get weatherConditionSand => 'Sand';

  @override
  String get weatherConditionAsh => 'Ash';

  @override
  String get weatherConditionSquall => 'Squall';

  @override
  String get weatherConditionTornado => 'Tornado';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Humidity';

  @override
  String get windSpeed => 'Wind Speed';

  @override
  String get feelsLike => 'Feels Like';

  @override
  String get visibility => 'Visibility';

  @override
  String get pressure => 'Pressure';

  @override
  String get uvIndex => 'UV Index';
}
