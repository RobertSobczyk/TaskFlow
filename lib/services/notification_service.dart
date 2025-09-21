import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../core/logging/app_logger.dart';
import '../models/task.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Convert task ID to a safe 32-bit integer for notification ID
  static int _getNotificationId(String taskId) {
    // Use a simple hash that fits in 32-bit signed integer range
    int hash = taskId.hashCode;
    // Ensure it's within 32-bit signed integer range
    return hash & 0x7FFFFFFF;
  }

  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        AppLogger.info(
          'NotificationService: Notification tapped, Payload: ${notificationResponse.payload}',
        );
      },
    );

    // Request permissions immediately after initialization
    final hasPermissions = await _requestPermissions();
    if (hasPermissions) {
      AppLogger.info('NotificationService: Permissions granted');
    } else {
      AppLogger.warning(
        'NotificationService: Permissions denied or not available',
      );
    }
  }

  static Future<bool> _requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      // Request basic notification permissions
      final notificationPermission =
          await androidImplementation?.requestNotificationsPermission() ??
          false;

      // Request exact alarm permissions for scheduled notifications (Android 12+)
      final exactAlarmPermission =
          await androidImplementation?.requestExactAlarmsPermission() ?? true;

      AppLogger.debug(
        'NotificationService: Notification permission: $notificationPermission, Exact alarm permission: $exactAlarmPermission',
      );

      return notificationPermission && exactAlarmPermission;
    }
    return true;
  }

  /// Check current notification permissions status
  static Future<bool> arePermissionsGranted() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      final notificationPermission =
          await androidImplementation?.areNotificationsEnabled() ?? false;
      AppLogger.debug(
        'NotificationService: Current notification permission status: $notificationPermission',
      );
      return notificationPermission;
    }
    return true;
  }

  static Future<void> scheduleTaskReminder(
    Task task, {
    String notificationTitle = 'Task Reminder',
    String? notificationBody,
    String channelName = 'Task Reminders',
    String channelDescription = 'Notifications for task reminders',
  }) async {
    final hasPermissions = await _requestPermissions();
    if (!hasPermissions) {
      AppLogger.warning(
        'NotificationService: Permissions denied, cannot schedule notification',
      );
      return;
    }

    // Schedule reminder exactly at the deadline time
    final reminderDateTime = task.deadline;
    final now = DateTime.now();

    // Don't schedule if reminder time is in the past
    if (reminderDateTime.isBefore(now)) {
      AppLogger.warning(
        'NotificationService: Deadline time is in the past, skipping notification for task: ${task.title}',
      );
      return;
    }

    final notificationTime = tz.TZDateTime.from(reminderDateTime, tz.local);
    final body = notificationBody ?? 'Don\'t forget: ${task.title}';

    AppLogger.info(
      'NotificationService: Scheduling notification for ${task.title} at $notificationTime (in ${reminderDateTime.difference(now).inMinutes} minutes)',
    );

    try {
      await _notificationsPlugin.zonedSchedule(
        _getNotificationId(task.id), // Use safe 32-bit notification ID
        notificationTitle,
        body,
        notificationTime,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'task_reminders',
            channelName,
            channelDescription: channelDescription,
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        payload: task.id,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      AppLogger.info(
        'NotificationService: Successfully scheduled reminder for task: ${task.title} at $notificationTime',
      );
    } catch (e) {
      AppLogger.error(
        'NotificationService: Failed to schedule notification for ${task.title}: $e',
      );

      // Fallback: Schedule with inexact timing
      try {
        await _notificationsPlugin.zonedSchedule(
          _getNotificationId(task.id),
          notificationTitle,
          body,
          notificationTime,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'task_reminders',
              channelName,
              channelDescription: channelDescription,
              importance: Importance.high,
              priority: Priority.high,
            ),
          ),
          payload: task.id,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.inexact,
        );

        AppLogger.info(
          'NotificationService: Scheduled reminder with inexact timing for task: ${task.title} at $notificationTime',
        );
      } catch (fallbackError) {
        AppLogger.error(
          'NotificationService: Failed to schedule notification even with fallback: $fallbackError',
        );
      }
    }

    AppLogger.info(
      'NotificationService: Scheduled reminder for task: ${task.title} at $notificationTime',
    );
  }

  static Future<void> cancelTaskReminder(String taskId) async {
    await _notificationsPlugin.cancel(_getNotificationId(taskId));
    AppLogger.info('NotificationService: Cancelled reminder for task: $taskId');
  }

  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
    AppLogger.info('NotificationService: Cancelled all notifications');
  }
}
