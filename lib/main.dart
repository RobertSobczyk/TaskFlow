import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:task_flow/core/logging/app_logger.dart';
import 'gen/l10n/app_localizations.dart';
import 'models/task.dart';
import 'services/task_service.dart';
import 'services/notification_service.dart';
import 'widgets/settings/settings_controller.dart';
import 'widgets/settings/settings_service.dart';
import 'widgets/settings/settings_view.dart';
import 'widgets/task_list/task_list_view.dart';
import 'widgets/task_list/add_task_dialog.dart';
import 'widgets/stats/stats_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.info('TaskFlow app starting...');

  tz.initializeTimeZones();
  AppLogger.info('Timezone initialized');

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  AppLogger.info('Settings loaded');

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await TaskService.init();

  await NotificationService.init();

  AppLogger.info('TaskFlow app initialization complete');
  runApp(MyApp(settingsController: settingsController));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', ''), Locale('pl', '')],

          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case MyHomePage.routeName:
                  default:
                    return const MyHomePage();
                }
              },
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const routeName = '/';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<TaskListViewState> _taskListKey = GlobalKey();
  int _selectedIndex = 0;

  void _showAddTaskDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const AddTaskDialog(),
    );
    _taskListKey.currentState?.refreshTasks();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _pages => [
    TaskListView(key: _taskListKey),
    const StatsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_selectedIndex == 0 ? l10n.appTitle : l10n.statistics),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.task_alt),
            label: l10n.activeTasksTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics),
            label: l10n.statistics,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0 
          ? FloatingActionButton(
              onPressed: () => _showAddTaskDialog(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
