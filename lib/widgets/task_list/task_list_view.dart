import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/core/logging/app_logger.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/services/task_service.dart';

import 'edit_task_dialog.dart';
import 'confirm_delete_dialog.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => TaskListViewState();
}

class TaskListViewState extends State<TaskListView> {
  List<Task> tasks = [];
  List<Task> completedTasks = [];
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _startRefreshTimer();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _loadTasks() {
    AppLogger.debug('Loading tasks');
    setState(() {
      tasks = TaskService.getAllTasks();
      completedTasks = TaskService.getCompletedTasks();
    });
    AppLogger.info('Tasks loaded: ${tasks.length} active, ${completedTasks.length} completed');
  }

  void refreshTasks() {
    _loadTasks();
  }

  void _startRefreshTimer() {
    _refreshTimer = Timer.periodic(AppConstants.refreshInterval, (timer) {
      if (mounted) {
        setState(() {
          // Refresh UI to update "Due in X hours/minutes" without reloading data
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return RefreshIndicator(
      onRefresh: () async {
        _loadTasks();
      },
      child: ListView(
        padding: const EdgeInsets.all(AppConstants.spacing_16),
        children: [
          if (tasks.isNotEmpty) ...[
            Text(
              l10n.activeTasksTitle,
              style: const TextStyle(
                fontSize: AppConstants.fontSize_20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacing_8),
            ...tasks.map(
              (task) => TaskTile(
                task: task,
                onChanged: (bool? value) => _toggleTask(task),
                onEdit: () => _editTask(task),
                onDelete: () => _deleteTask(task),
              ),
            ),
            const SizedBox(height: AppConstants.spacing_24),
          ],
          if (completedTasks.isNotEmpty) ...[
            Text(
              l10n.completedTasksTitle,
              style: const TextStyle(
                fontSize: AppConstants.fontSize_20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacing_8),
            ...completedTasks.map(
              (task) => TaskTile(
                task: task,
                onChanged: (bool? value) => _toggleTask(task),
                onEdit: () => _editTask(task),
                onDelete: () => _deleteTask(task),
              ),
            ),
          ],
          if (tasks.isEmpty && completedTasks.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacing_32),
                child: Text(
                  l10n.noTasksMessage,
                  style: const TextStyle(
                    fontSize: AppConstants.fontSize_16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _toggleTask(Task task) async {
    AppLogger.debug('Toggling task: ${task.title} -> ${!task.isDone}');
    final l10n = AppLocalizations.of(context)!;
    if (task.isDone) {
      await TaskService.markAsNotCompleted(
        task.id,
        notificationTitle: l10n.notificationTitle,
        notificationBody: l10n.notificationBody(task.title),
        notificationChannelName: l10n.notificationChannelName,
        notificationChannelDescription: l10n.notificationChannelDescription,
      );
    } else {
      await TaskService.markAsCompleted(
        task.id,
        notificationTitle: l10n.notificationTitle,
        notificationBody: l10n.notificationBody(task.title),
        notificationChannelName: l10n.notificationChannelName,
        notificationChannelDescription: l10n.notificationChannelDescription,
      );
    }
    _loadTasks();
  }

  void _editTask(Task task) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => EditTaskDialog(task: task),
    );

    if (result == true) {
      _loadTasks();
    }
  }

  void _deleteTask(Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDeleteDialog(taskTitle: task.title),
    );

    if (confirmed == true) {
      await TaskService.deleteTask(task.id);
      _loadTasks();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.taskDeletedMessage(task.title),
            ),
          ),
        );
      }
    }
  }
}

class TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const TaskTile({
    super.key,
    required this.task,
    this.onChanged,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isOverdue = !task.isDone && task.deadline.isBefore(DateTime.now());
    final timeUntilDeadline = task.deadline.difference(DateTime.now());

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacing_8),
      child: ListTile(
        leading: Checkbox(value: task.isDone, onChanged: onChanged),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
            color: task.isDone ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null) Text(task.description!),
            Text(
              _formatDeadline(
                context,
                task.deadline,
                isOverdue,
                timeUntilDeadline,
              ),
              style: TextStyle(
                color: isOverdue
                    ? Colors.red
                    : Colors.grey[AppConstants.greyColorIndex],
                fontWeight: isOverdue ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }

  String _formatDeadline(
    BuildContext context,
    DateTime deadline,
    bool isOverdue,
    Duration timeUntil,
  ) {
    if (isOverdue) {
      return '${AppLocalizations.of(context)!.overdueByText} ${_formatDuration(context, timeUntil.abs())}';
    } else {
      return '${AppLocalizations.of(context)!.dueInText} ${_formatDuration(context, timeUntil)}';
    }
  }

  String _formatDuration(BuildContext context, Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} ${AppLocalizations.of(context)!.daysText}';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} ${AppLocalizations.of(context)!.hoursText}';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} ${AppLocalizations.of(context)!.minutesText}';
    } else {
      return AppLocalizations.of(context)!.nowText;
    }
  }
}
