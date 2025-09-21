import 'package:flutter/material.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';
import 'package:task_flow/models/task.dart';
import 'package:task_flow/services/stats_service.dart';

class RecentTasksWidget extends StatelessWidget {
  final TaskStats stats;

  const RecentTasksWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.recentlyCompleted,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppConstants.spacing_16),
        Card(
          child: Column(
            children: [
              if (stats.recentlyCompleted.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(AppConstants.spacing_24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox,
                        size: AppConstants.statsExtraLargeIconSize,
                        color: Theme.of(context).colorScheme.outline.withValues(
                          alpha: AppConstants.alphaSecondary,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing_12),
                      Text(
                        l10n.noCompletedTasksYet,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color
                              ?.withValues(alpha: AppConstants.alphaMedium),
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacing_4),
                      Text(
                        l10n.startCompletingTasks,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color
                              ?.withValues(alpha: AppConstants.alphaSecondary),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stats.recentlyCompleted.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: AppConstants.dividerHeight),
                  itemBuilder: (context, index) {
                    final task = stats.recentlyCompleted[index];
                    return _buildTaskListItem(context, task);
                  },
                ),
            ],
          ),
        ),
        if (stats.completedTasks > stats.recentlyCompleted.length)
          Padding(
            padding: const EdgeInsets.only(top: AppConstants.spacing_8),
            child: Center(
              child: Text(
                l10n.showingXOfYTasks(
                  stats.recentlyCompleted.length,
                  stats.completedTasks,
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color
                      ?.withValues(alpha: AppConstants.alphaMedium),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTaskListItem(BuildContext context, Task task) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacing_16,
        vertical: AppConstants.spacing_4,
      ),
      leading: Container(
        width: AppConstants.statsIconSize,
        height: AppConstants.statsIconSize,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(AppConstants.spacing_12),
        ),
        child: const Icon(
          Icons.check,
          size: AppConstants.spacing_16,
          color: Colors.white,
        ),
      ),
      title: Text(
        task.title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        maxLines: AppConstants.maxTaskSingleLine,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.description?.isNotEmpty == true)
            Padding(
              padding: const EdgeInsets.only(top: AppConstants.spacing_4),
              child: Text(
                task.description!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).textTheme.bodySmall?.color
                      ?.withValues(alpha: AppConstants.alphaMedium),
                ),
                maxLines: AppConstants.maxTaskTitleLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (task.completedAt != null)
            Padding(
              padding: const EdgeInsets.only(top: AppConstants.spacing_4),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: AppConstants.spacing_12,
                    color: Theme.of(context).textTheme.bodySmall?.color
                        ?.withValues(alpha: AppConstants.alphaSecondary),
                  ),
                  const SizedBox(width: AppConstants.spacing_4),
                  Text(
                    _formatCompletedTime(task.completedAt!, context),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color
                          ?.withValues(alpha: AppConstants.alphaSecondary),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      trailing: task.deadline.isBefore(task.completedAt ?? DateTime.now())
          ? Icon(
              Icons.schedule,
              size: AppConstants.spacing_16,
              color: Colors.orange[600],
            )
          : null,
    );
  }

  String _formatCompletedTime(DateTime completedAt, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(completedAt);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return l10n.oneDayAgo;
      }
      return l10n.daysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return l10n.oneHourAgo;
      }
      return l10n.hoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return l10n.oneMinuteAgo;
      }
      return l10n.minutesAgo(difference.inMinutes);
    } else {
      return l10n.justNow;
    }
  }
}
