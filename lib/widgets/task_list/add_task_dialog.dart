import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../gen/l10n/app_localizations.dart';
import '../../models/task.dart';
import '../../services/task_service.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(
    AppConstants.defaultTaskDeadlineOffset,
  );
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.addNewTaskTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.taskTitleLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppConstants.spacing_16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.descriptionLabel,
                border: const OutlineInputBorder(),
              ),
              maxLines: AppConstants.maxDescriptionLines,
            ),
            const SizedBox(height: AppConstants.spacing_16),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                '${l10n.deadlinePrefix}${_formatDate(_selectedDate)}',
              ),
              onTap: _selectDate,
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text('${l10n.timePrefix}${_selectedTime.format(context)}'),
              onTap: _selectTime,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancelButtonText),
        ),
        ElevatedButton(
          onPressed: _saveTask,
          child: Text(l10n.addTaskButtonText),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(AppConstants.dateRangeExtension),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  void _saveTask() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseEnterTitleError),
        ),
      );
      return;
    }

    final deadline = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final task = Task.create(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      deadline: deadline,
    );

    final l10n = AppLocalizations.of(context)!;
    await TaskService.addTask(
      task,
      notificationTitle: l10n.notificationTitle,
      notificationBody: l10n.notificationBody(task.title),
      notificationChannelName: l10n.notificationChannelName,
      notificationChannelDescription: l10n.notificationChannelDescription,
    );

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.taskAddedSuccessMessage),
        ),
      );
    }
  }
}
