import 'package:flutter/material.dart';
import 'package:task_flow/gen/l10n/app_localizations.dart';
import 'package:task_flow/services/stats_service.dart';

import 'stats_overview_widget.dart';
import 'productivity_chart_widget.dart';
import 'streak_widget.dart';
import 'recent_tasks_widget.dart';

class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  TaskStats? _stats;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final stats = await StatsService.calculateStats();

      setState(() {
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading statistics: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.calculatingStatistics),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _loadStats, child: Text(l10n.retry)),
          ],
        ),
      );
    }

    if (_stats == null) {
      return Center(child: Text(l10n.noStatisticsAvailable));
    }

    return RefreshIndicator(
      onRefresh: _loadStats,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatsOverviewWidget(stats: _stats!),
            const SizedBox(height: 24),

            StreakWidget(stats: _stats!),
            const SizedBox(height: 24),

            ProductivityChartWidget(stats: _stats!),
            const SizedBox(height: 24),

            RecentTasksWidget(stats: _stats!),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
