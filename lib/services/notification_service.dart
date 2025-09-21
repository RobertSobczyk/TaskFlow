import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
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
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        debugPrint(
          'NotificationService: Notification tapped, Payload: ${notificationResponse.payload}',
        );
      },
    );
  }

  static Future<bool> _requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      return await androidImplementation?.requestNotificationsPermission() ??
          false;
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
      debugPrint(
        'NotificationService: Permissions denied, cannot schedule notification',
      );
      return;
    }

    // Schedule reminder 10 minutes before the deadline
    final reminderDateTime = task.deadline.subtract(const Duration(minutes: 10));
    final notificationTime = tz.TZDateTime.from(reminderDateTime, tz.local);

    final body = notificationBody ?? 'Don\'t forget: ${task.title}';

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

      debugPrint(
        'NotificationService: Successfully scheduled reminder for task: ${task.title} at $notificationTime',
      );
    } catch (e) {
      debugPrint(
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

        debugPrint(
          'NotificationService: Scheduled reminder with inexact timing for task: ${task.title} at $notificationTime',
        );
      } catch (fallbackError) {
        debugPrint(
          'NotificationService: Failed to schedule notification even with fallback: $fallbackError',
        );
      }
    }

    debugPrint(
      'NotificationService: Scheduled reminder for task: ${task.title} at $notificationTime',
    );
  }

  static Future<void> cancelTaskReminder(String taskId) async {
    await _notificationsPlugin.cancel(_getNotificationId(taskId));
    debugPrint('NotificationService: Cancelled reminder for task: $taskId');
  }

  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
    debugPrint('NotificationService: Cancelled all notifications');
  }
}