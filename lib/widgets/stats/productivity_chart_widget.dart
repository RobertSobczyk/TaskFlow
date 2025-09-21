import 'package:flutter/material.dart';
import 'package:task_flow/core/constants/app_constants.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';
import 'package:task_flow/services/stats_service.dart';

class ProductivityChartWidget extends StatefulWidget {
  final TaskStats stats;

  const ProductivityChartWidget({super.key, required this.stats});

  @override
  State<ProductivityChartWidget> createState() =>
      _ProductivityChartWidgetState();
}

class _ProductivityChartWidgetState extends State<ProductivityChartWidget> {
  List<int> weeklyTrend = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeeklyTrend();
  }

  Future<void> _loadWeeklyTrend() async {
    final trend = await StatsService.getWeeklyProductivityTrend();
    setState(() {
      weeklyTrend = trend;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.weeklyProductivity,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppConstants.spacing_16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacing_16),
            child: Column(
              children: [
                if (isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppConstants.spacing_20),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  _buildChart(context),
                const SizedBox(height: AppConstants.spacing_16),
                _buildDayLabels(context),
                const SizedBox(height: AppConstants.spacing_12),
                _buildWeeklySummary(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (weeklyTrend.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacing_20),
          child: Text(l10n.noDataAvailable),
        ),
      );
    }

    final maxValue = weeklyTrend.reduce((a, b) => a > b ? a : b);
    final chartHeight = AppConstants.chartHeight;

    return SizedBox(
      height: chartHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: weeklyTrend.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          final isToday = index == AppConstants.todayIndex;

          final barHeight = maxValue > 0
              ? (value / maxValue) *
                    (chartHeight - AppConstants.chartBarHeightOffset)
              : 0.0;

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (value > 0)
                  Text(
                    value.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isToday
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                const SizedBox(height: AppConstants.spacing_2),
                //
                Container(
                  width: AppConstants.chartBarWidth,
                  height: barHeight + AppConstants.chartBarMinHeight,
                  decoration: BoxDecoration(
                    color: isToday
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary.withValues(
                            alpha: AppConstants.alphaMedium,
                          ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppConstants.chartBorderRadius),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDayLabels(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final dayLabels = [
      l10n.monday,
      l10n.tuesday,
      l10n.wednesday,
      l10n.thursday,
      l10n.friday,
      l10n.saturday,
      l10n.sunday,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dayLabels.asMap().entries.map((entry) {
        final index = entry.key;
        final label = entry.value;
        final isToday = index == AppConstants.todayIndex;

        return Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            color: isToday
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).textTheme.bodySmall?.color?.withValues(
                    alpha: AppConstants.alphaMedium,
                  ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeeklySummary(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (weeklyTrend.isEmpty) return const SizedBox.shrink();

    final totalThisWeek = weeklyTrend.reduce((a, b) => a + b);
    final averagePerDay = totalThisWeek / AppConstants.daysInWeek;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing_12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                totalThisWeek.toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                l10n.thisWeek,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 30,
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
          Column(
            children: [
              Text(
                averagePerDay.toStringAsFixed(1),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                l10n.dailyAvg,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
