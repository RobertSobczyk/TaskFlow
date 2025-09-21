import 'package:flutter/material.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';
import 'package:task_flow/services/stats_service.dart';

class StreakWidget extends StatelessWidget {
  final TaskStats stats;

  const StreakWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.productivityStreaks,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppConstants.spacing_16),
        Row(
          children: [
            Expanded(
              child: _buildStreakCard(
                context: context,
                title: l10n.currentStreak,
                value: stats.currentStreak,
                subtitle: stats.currentStreak == AppConstants.singleDayDifference
                    ? l10n.dayText
                    : l10n.daysText,
                icon: Icons.local_fire_department,
                color: stats.currentStreak > AppConstants.minValue ? Colors.orange : Colors.grey,
              ),
            ),
            const SizedBox(width: AppConstants.spacing_12),
            Expanded(
              child: _buildStreakCard(
                context: context,
                title: l10n.longestStreak,
                value: stats.longestStreak,
                subtitle: stats.longestStreak == AppConstants.singleDayDifference
                    ? l10n.dayText
                    : l10n.daysText,
                icon: Icons.emoji_events,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacing_16),
        _buildAverageCard(context),
      ],
    );
  }

  Widget _buildStreakCard({
    required BuildContext context,
    required String title,
    required int value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing_16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppConstants.statsLargeIconSize, color: color),
            const SizedBox(height: AppConstants.spacing_8),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: AppConstants.spacing_4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color.withValues(alpha: AppConstants.alphaHigh),
              ),
            ),
            const SizedBox(height: AppConstants.spacing_8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAverageCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing_16),
        child: Row(
          children: [
            Icon(
              Icons.trending_up,
              size: AppConstants.statsLargeIconSize,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: AppConstants.spacing_16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.averagePerDay,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacing_4),
                  Text(
                    '${stats.averageTasksPerDay.toStringAsFixed(1)} ${l10n.tasksText}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacing_2),
                  Text(
                    'Last ${AppConstants.daysForAverage} days',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color
                          ?.withValues(alpha: AppConstants.alphaMedium),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacing_12,
                vertical: AppConstants.spacing_6,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withValues(
                  alpha: AppConstants.alphaDisabled,
                ),
                borderRadius: BorderRadius.circular(AppConstants.spacing_12),
              ),
              child: Text(
                stats.averageTasksPerDay >= AppConstants.singleDayDifference ? l10n.good : l10n.low,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.fontSize_12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
