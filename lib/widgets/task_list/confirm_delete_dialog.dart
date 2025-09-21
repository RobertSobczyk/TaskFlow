import 'package:flutter/material.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String taskTitle;

  const ConfirmDeleteDialog({super.key, required this.taskTitle});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.deleteTaskTitle),
      content: Text(l10n.deleteTaskConfirmationMessage(taskTitle)),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.cancelButtonText),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          child: Text(l10n.deleteButtonText),
        ),
      ],
    );
  }
}
