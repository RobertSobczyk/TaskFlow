import 'package:hive/hive.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/core/logging/app_logger.dart';

import '../models/task.dart';
import 'notification_service.dart';

class TaskService {
  static const String _taskBoxName = AppConstants.taskBoxName;
  static const String _completedTaskBoxName = AppConstants.completedTaskBoxName;

  static Box<Task>? _taskBox;
  static Box<Task>? _completedTaskBox;

  static Future<void> init() async {
    AppLogger.info('TaskService: Initializing');
    _taskBox = await Hive.openBox<Task>(_taskBoxName);
    _completedTaskBox = await Hive.openBox<Task>(_completedTaskBoxName);
    AppLogger.info('TaskService: Hive boxes opened successfully');
  }

  static Box<Task> get taskBox {
    if (_taskBox == null) throw Exception('TaskService not initialized');
    return _taskBox!;
  }

  static Box<Task> get completedTaskBox {
    if (_completedTaskBox == null) {
      throw Exception('TaskService not initialized');
    }
    return _completedTaskBox!;
  }

  static List<Task> getAllTasks() {
    return taskBox.values.toList()
      ..sort((a, b) => a.deadline.compareTo(b.deadline));
  }

  static List<Task> getCompletedTasks() {
    return completedTaskBox.values.toList()..sort(
      (a, b) => (b.completedAt ?? DateTime.now()).compareTo(
        a.completedAt ?? DateTime.now(),
      ),
    );
  }

  static Future<void> addTask(
    Task task, {
    String? notificationTitle,
    String? notificationBody,
    String? notificationChannelName,
    String? notificationChannelDescription,
  }) async {
    AppLogger.info('TaskService: Adding task: ${task.title}');
    await taskBox.put(task.id, task);

    if (!task.isDone) {
      await NotificationService.scheduleTaskReminder(
        task,
        notificationTitle: notificationTitle ?? 'Task Reminder',
        notificationBody: notificationBody,
        channelName: notificationChannelName ?? 'Task Reminders',
        channelDescription: notificationChannelDescription ?? 'Notifications for task reminders',
      );
    }
    AppLogger.info('TaskService: Task added successfully');
  }

  static Future<void> updateTask(
    Task task, {
    String? notificationTitle,
    String? notificationBody,
    String? notificationChannelName,
    String? notificationChannelDescription,
  }) async {
    AppLogger.info('Updating task: ${task.title}, isDone: ${task.isDone}');

    if (task.isDone) {
      await taskBox.delete(task.id);
      await completedTaskBox.put(task.id, task);

      await NotificationService.cancelTaskReminder(task.id);
    } else {
      await completedTaskBox.delete(task.id);
      await taskBox.put(task.id, task);
      await NotificationService.scheduleTaskReminder(
        task,
        notificationTitle: notificationTitle ?? 'Task Reminder',
        notificationBody: notificationBody,
        channelName: notificationChannelName ?? 'Task Reminders',
        channelDescription: notificationChannelDescription ?? 'Notifications for task reminders',
      );
    }
    AppLogger.info('Task updated successfully');
  }

  static Future<void> deleteTask(String taskId) async {
    AppLogger.info('Deleting task ID: $taskId');
    await taskBox.delete(taskId);
    await completedTaskBox.delete(taskId);
    // Cancel notification when task is deleted
    await NotificationService.cancelTaskReminder(taskId);
    AppLogger.info('Task deleted successfully');
  }

  static Future<void> markAsCompleted(
    String taskId, {
    String? notificationTitle,
    String? notificationBody,
    String? notificationChannelName,
    String? notificationChannelDescription,
  }) async {
    final task = taskBox.get(taskId);
    if (task != null) {
      final completedTask = task.markAsCompleted();
      await updateTask(
        completedTask,
        notificationTitle: notificationTitle,
        notificationBody: notificationBody,
        notificationChannelName: notificationChannelName,
        notificationChannelDescription: notificationChannelDescription,
      );
    }
  }

  static Future<void> markAsNotCompleted(
    String taskId, {
    String? notificationTitle,
    String? notificationBody,
    String? notificationChannelName,
    String? notificationChannelDescription,
  }) async {
    final task = completedTaskBox.get(taskId);
    if (task != null) {
      final activeTask = task.markAsNotCompleted();
      await updateTask(
        activeTask,
        notificationTitle: notificationTitle,
        notificationBody: notificationBody,
        notificationChannelName: notificationChannelName,
        notificationChannelDescription: notificationChannelDescription,
      );
    }
  }
}
