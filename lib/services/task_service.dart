import 'package:hive/hive.dart';
import '../core/constants/app_constants.dart';
import '../models/task.dart';

class TaskService {
  static const String _taskBoxName = AppConstants.taskBoxName;
  static const String _completedTaskBoxName = AppConstants.completedTaskBoxName;
  
  static Box<Task>? _taskBox;
  static Box<Task>? _completedTaskBox;

  static Future<void> init() async {
    _taskBox = await Hive.openBox<Task>(_taskBoxName);
    _completedTaskBox = await Hive.openBox<Task>(_completedTaskBoxName);
  }

  static Box<Task> get taskBox {
    if (_taskBox == null) throw Exception('TaskService not initialized');
    return _taskBox!;
  }

  static Box<Task> get completedTaskBox {
    if (_completedTaskBox == null) throw Exception('TaskService not initialized');
    return _completedTaskBox!;
  }

  static List<Task> getAllTasks() {
    return taskBox.values.toList()
      ..sort((a, b) => a.deadline.compareTo(b.deadline));
  }

  static List<Task> getCompletedTasks() {
    return completedTaskBox.values.toList()
      ..sort((a, b) => (b.completedAt ?? DateTime.now()).compareTo(a.completedAt ?? DateTime.now()));
  }

  static Future<void> addTask(Task task) async {
    await taskBox.put(task.id, task);
  }

  static Future<void> updateTask(Task task) async {
    if (task.isDone) {
      await taskBox.delete(task.id);
      await completedTaskBox.put(task.id, task);
    } else {
      await completedTaskBox.delete(task.id);
      await taskBox.put(task.id, task);
    }
  }

  static Future<void> deleteTask(String taskId) async {
    await taskBox.delete(taskId);
    await completedTaskBox.delete(taskId);
  }

  static Future<void> markAsCompleted(String taskId) async {
    final task = taskBox.get(taskId);
    if (task != null) {
      final completedTask = task.markAsCompleted();
      await updateTask(completedTask);
    }
  }

  static Future<void> markAsNotCompleted(String taskId) async {
    final task = completedTaskBox.get(taskId);
    if (task != null) {
      final activeTask = task.markAsNotCompleted();
      await updateTask(activeTask);
    }
  }
}