import 'package:flutter/material.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';
import 'package:task_flow/services/stats_service.dart';

class StatsOverviewWidget extends StatelessWidget {
  final TaskStats stats;

  const StatsOverviewWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.overview,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppConstants.spacing_16),
        GridView.count(
          crossAxisCount: AppConstants.statsGridColumns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: AppConstants.statsGridAspectRatio,
          mainAxisSpacing: AppConstants.spacing_12,
          crossAxisSpacing: AppConstants.spacing_12,
          children: [
            _buildStatCard(
              context: context,
              title: l10n.totalTasks,
              value: stats.totalTasks.toString(),
              icon: Icons.task_alt,
              color: Colors.blue,
            ),
            _buildStatCard(
              context: context,
              title: l10n.completed,
              value: stats.completedTasks.toString(),
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            _buildStatCard(
              context: context,
              title: l10n.active,
              value: stats.activeTasks.toString(),
              icon: Icons.pending_actions,
              color: Colors.orange,
            ),
            _buildStatCard(
              context: context,
              title: l10n.overdue,
              value: stats.overdueTasks.toString(),
              icon: Icons.warning,
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacing_16),
        _buildCompletionRateCard(context),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing_12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppConstants.statsIconSize, color: color),
            const SizedBox(height: AppConstants.spacing_6),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: AppConstants.spacing_2),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color
                      ?.withValues(alpha: AppConstants.alphaMedium),
                ),
                maxLines: AppConstants.maxTaskTitleLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionRateCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacing_16),
        child: Row(
          children: [
            Icon(
              Icons.pie_chart,
              size: AppConstants.statsLargeIconSize,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: AppConstants.spacing_16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.completionRate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacing_4),
                  Text(
                    '${stats.completionRate.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppConstants.completionRateCircleSize,
              height: AppConstants.completionRateCircleSize,
              child: CircularProgressIndicator(
                value: stats.completionRate / AppConstants.percentageMultiplier,
                strokeWidth: AppConstants.completionRateStrokeWidth,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: AppConstants.alphaDisabled),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
