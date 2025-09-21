import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/core/logging/app_logger.dart';
import 'package:task_flow/models/task.dart';

import 'task_service.dart';

class TaskStats {
  final int totalTasks;
  final int completedTasks;
  final int activeTasks;
  final double completionRate;
  final int todayCompleted;
  final int weekCompleted;
  final int monthCompleted;
  final int currentStreak;
  final int longestStreak;
  final double averageTasksPerDay;
  final int overdueTasks;
  final List<Task> recentlyCompleted;
  final Map<String, int> completionByDay;

  const TaskStats({
    required this.totalTasks,
    required this.completedTasks,
    required this.activeTasks,
    required this.completionRate,
    required this.todayCompleted,
    required this.weekCompleted,
    required this.monthCompleted,
    required this.currentStreak,
    required this.longestStreak,
    required this.averageTasksPerDay,
    required this.overdueTasks,
    required this.recentlyCompleted,
    required this.completionByDay,
  });
}

class StatsService {
  static const int _recentlyCompletedLimit =
      AppConstants.recentlyCompletedLimit;
  static const int _daysForAverage = AppConstants.daysForAverage;

  static Future<TaskStats> calculateStats() async {
    try {
      AppLogger.info('StatsService: Starting statistics calculation');

      final activeTasksList = TaskService.getAllTasks();
      final completedTasksList = TaskService.getCompletedTasks();
      final allTasks = [...activeTasksList, ...completedTasksList];
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      final totalTasks = allTasks.length;
      final completedTasks = allTasks.where((task) => task.isDone).length;
      final activeTasks = totalTasks - completedTasks;
      final completionRate = totalTasks > 0
          ? (completedTasks / totalTasks) * AppConstants.percentageMultiplier
          : 0.0;

      final todayCompleted = _getTasksCompletedInPeriod(
        allTasks,
        today,
        today.add(Duration(days: 1)),
      );
      final weekStart = today.subtract(
        Duration(days: now.weekday - AppConstants.weekdayStartIndex),
      );
      final weekCompleted = _getTasksCompletedInPeriod(
        allTasks,
        weekStart,
        today.add(Duration(days: 1)),
      );
      final monthStart = DateTime(
        now.year,
        now.month,
        AppConstants.weekdayStartIndex,
      );
      final monthCompleted = _getTasksCompletedInPeriod(
        allTasks,
        monthStart,
        today.add(Duration(days: 1)),
      );

      final streaks = _calculateStreaks(allTasks, today);

      final averageTasksPerDay = _calculateAverageTasksPerDay(allTasks, today);

      final overdueTasks = _getOverdueTasks(allTasks, now);

      final recentlyCompleted = _getRecentlyCompletedTasks(allTasks);

      final completionByDay = _getCompletionByDayOfWeek(allTasks);

      final stats = TaskStats(
        totalTasks: totalTasks,
        completedTasks: completedTasks,
        activeTasks: activeTasks,
        completionRate: completionRate,
        todayCompleted: todayCompleted,
        weekCompleted: weekCompleted,
        monthCompleted: monthCompleted,
        currentStreak: streaks['current'] ?? 0,
        longestStreak: streaks['longest'] ?? 0,
        averageTasksPerDay: averageTasksPerDay,
        overdueTasks: overdueTasks,
        recentlyCompleted: recentlyCompleted,
        completionByDay: completionByDay,
      );

      AppLogger.info(
        'StatsService: Statistics calculated successfully - $completedTasks/$totalTasks tasks completed',
      );
      return stats;
    } catch (e) {
      AppLogger.error('StatsService: Error calculating statistics: $e');
      return TaskStats(
        totalTasks: 0,
        completedTasks: 0,
        activeTasks: 0,
        completionRate: 0.0,
        todayCompleted: 0,
        weekCompleted: 0,
        monthCompleted: 0,
        currentStreak: 0,
        longestStreak: 0,
        averageTasksPerDay: 0.0,
        overdueTasks: 0,
        recentlyCompleted: [],
        completionByDay: {},
      );
    }
  }

  static int _getTasksCompletedInPeriod(
    List<Task> tasks,
    DateTime start,
    DateTime end,
  ) {
    return tasks.where((task) {
      if (!task.isDone || task.completedAt == null) return false;
      final completedAt = task.completedAt!;
      return completedAt.isAfter(start) && completedAt.isBefore(end);
    }).length;
  }

  static Map<String, int> _calculateStreaks(List<Task> tasks, DateTime today) {
    final completedTasks = tasks
        .where((task) => task.isDone && task.completedAt != null)
        .toList();

    if (completedTasks.isEmpty) {
      return {'current': 0, 'longest': 0};
    }

    final Map<String, List<Task>> tasksByDate = {};
    for (final task in completedTasks) {
      final date = task.completedAt!;
      final dateKey =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      tasksByDate.putIfAbsent(dateKey, () => []).add(task);
    }

    final completionDates = tasksByDate.keys.map((dateStr) {
      final parts = dateStr.split('-');
      return DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    }).toList()..sort();

    if (completionDates.isEmpty) {
      return {'current': 0, 'longest': 0};
    }

    int currentStreak = 0;
    int longestStreak = 0;
    int tempStreak = 1;

    final todayKey =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    if (tasksByDate.containsKey(todayKey)) {
      currentStreak = 1;
      DateTime checkDate = today.subtract(Duration(days: 1));

      while (true) {
        final checkKey =
            '${checkDate.year}-${checkDate.month.toString().padLeft(2, '0')}-${checkDate.day.toString().padLeft(2, '0')}';
        if (tasksByDate.containsKey(checkKey)) {
          currentStreak++;
          checkDate = checkDate.subtract(Duration(days: 1));
        } else {
          break;
        }
      }
    }

    for (int i = 1; i < completionDates.length; i++) {
      final prevDate = completionDates[i - 1];
      final currentDate = completionDates[i];

      if (currentDate.difference(prevDate).inDays == 1) {
        tempStreak++;
      } else {
        longestStreak = tempStreak > longestStreak ? tempStreak : longestStreak;
        tempStreak = 1;
      }
    }
    longestStreak = tempStreak > longestStreak ? tempStreak : longestStreak;

    return {'current': currentStreak, 'longest': longestStreak};
  }

  static double _calculateAverageTasksPerDay(List<Task> tasks, DateTime today) {
    final startDate = today.subtract(Duration(days: _daysForAverage));
    final completedInPeriod = _getTasksCompletedInPeriod(
      tasks,
      startDate,
      today.add(Duration(days: 1)),
    );
    return completedInPeriod / _daysForAverage;
  }

  static int _getOverdueTasks(List<Task> tasks, DateTime now) {
    return tasks.where((task) {
      return !task.isDone && task.deadline.isBefore(now);
    }).length;
  }

  static List<Task> _getRecentlyCompletedTasks(List<Task> tasks) {
    final completed = tasks
        .where((task) => task.isDone && task.completedAt != null)
        .toList();

    completed.sort((a, b) => b.completedAt!.compareTo(a.completedAt!));

    return completed.take(_recentlyCompletedLimit).toList();
  }

  static Map<String, int> _getCompletionByDayOfWeek(List<Task> tasks) {
    final dayNames = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final Map<String, int> completionByDay = {
      for (String day in dayNames) day: 0,
    };

    final completedTasks = tasks.where(
      (task) => task.isDone && task.completedAt != null,
    );

    for (final task in completedTasks) {
      final dayOfWeek = task.completedAt!.weekday - 1;
      final dayName = dayNames[dayOfWeek];
      completionByDay[dayName] = (completionByDay[dayName] ?? 0) + 1;
    }

    return completionByDay;
  }

  static Future<List<int>> getWeeklyProductivityTrend() async {
    try {
      final activeTasksList = TaskService.getAllTasks();
      final completedTasksList = TaskService.getCompletedTasks();
      final allTasks = [...activeTasksList, ...completedTasksList];
      final now = DateTime.now();
      final trend = <int>[];

      for (int i = 6; i >= 0; i--) {
        final date = DateTime(
          now.year,
          now.month,
          now.day,
        ).subtract(Duration(days: i));
        final nextDate = date.add(Duration(days: 1));
        final completedCount = _getTasksCompletedInPeriod(
          allTasks,
          date,
          nextDate,
        );
        trend.add(completedCount);
      }

      AppLogger.debug('StatsService: Weekly trend calculated: $trend');
      return trend;
    } catch (e) {
      AppLogger.error('StatsService: Error calculating weekly trend: $e');
      return List.filled(7, 0);
    }
  }

  static String getMostProductiveDay(Map<String, int> completionByDay) {
    if (completionByDay.isEmpty) return 'N/A';

    String mostProductiveDay = completionByDay.keys.first;
    int maxCompletions = completionByDay.values.first;

    for (final entry in completionByDay.entries) {
      if (entry.value > maxCompletions) {
        maxCompletions = entry.value;
        mostProductiveDay = entry.key;
      }
    }

    return mostProductiveDay;
  }

  static Future<double> getCompletionRateForPeriod(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final activeTasksList = TaskService.getAllTasks();
      final completedTasksList = TaskService.getCompletedTasks();
      final allTasks = [...activeTasksList, ...completedTasksList];

      final tasksInPeriod = allTasks.where((task) {
        return task.createdAt.isAfter(start) && task.createdAt.isBefore(end);
      }).toList();

      if (tasksInPeriod.isEmpty) return 0.0;

      final completedInPeriod = tasksInPeriod
          .where((task) => task.isDone)
          .length;
      return (completedInPeriod / tasksInPeriod.length) * 100;
    } catch (e) {
      AppLogger.error(
        'StatsService: Error calculating completion rate for period: $e',
      );
      return 0.0;
    }
  }
}
