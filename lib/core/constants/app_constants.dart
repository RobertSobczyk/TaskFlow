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

  // App Information
  static const String appName = 'TaskFlow';
  static const String appTitle = 'Task Flow - Todo App';

  // Database box names
  static const String taskBoxName = 'tasks';
  static const String completedTaskBoxName = 'completed_tasks';

  // UI Text Constants
  static const String addNewTaskTitle = 'Add New Task';
  static const String editTaskTitle = 'Edit Task';
  static const String deleteTaskTitle = 'Delete Task';
  static const String taskTitleLabel = 'Task Title';
  static const String descriptionLabel = 'Description (optional)';
  static const String cancelButtonText = 'Cancel';
  static const String addTaskButtonText = 'Add Task';
  static const String updateTaskButtonText = 'Update Task';
  static const String deleteButtonText = 'Delete';
  static const String activeTasksTitle = 'Active Tasks';
  static const String completedTasksTitle = 'Completed Tasks';
  static const String noTasksMessage =
      'No tasks yet. Add one using the + button!';
  static const String pleasEnterTitleError = 'Please enter a task title';
  static const String taskAddedSuccessMessage = 'Task added successfully!';
  static const String taskUpdatedSuccessMessage = 'Task updated successfully!';
  static const String deleteTaskConfirmationMessage =
      'Are you sure you want to delete';
  static const String overdueByText = 'Overdue by';
  static const String dueInText = 'Due in';
  static const String daysText = 'days';
  static const String hoursText = 'hours';
  static const String minutesText = 'minutes';
  static const String nowText = 'now';
  static const String deadlinePrefix = 'Deadline: ';
  static const String timePrefix = 'Time: ';

  // Exception messages
  static const String taskServiceNotInitialized = 'TaskService not initialized';
}
