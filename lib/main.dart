import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.info('TaskFlow app starting...');

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

  void _showAddTaskDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const AddTaskDialog(),
    );
    _taskListKey.currentState?.refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: TaskListView(key: _taskListKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
