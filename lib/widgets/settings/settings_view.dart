import 'package:flutter/material.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';

import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing_16),

        child: DropdownButton<ThemeMode>(
          value: controller.themeMode,

          onChanged: controller.updateThemeMode,
          items: [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text(l10n.systemTheme),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text(l10n.lightTheme),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text(l10n.darkTheme),
            ),
          ],
        ),
      ),
    );
  }
}
