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
}
