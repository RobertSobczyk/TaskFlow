// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appName => 'TaskFlow';

  @override
  String get appTitle => 'Task Flow - Aplikacja Todo';

  @override
  String get addNewTaskTitle => 'Dodaj Nowe Zadanie';

  @override
  String get editTaskTitle => 'Edytuj Zadanie';

  @override
  String get deleteTaskTitle => 'Usuń Zadanie';

  @override
  String get taskTitleLabel => 'Tytuł Zadania';

  @override
  String get descriptionLabel => 'Opis (opcjonalny)';

  @override
  String get cancelButtonText => 'Anuluj';

  @override
  String get addTaskButtonText => 'Dodaj Zadanie';

  @override
  String get updateTaskButtonText => 'Aktualizuj Zadanie';

  @override
  String get deleteButtonText => 'Usuń';

  @override
  String get activeTasksTitle => 'Aktywne Zadania';

  @override
  String get completedTasksTitle => 'Ukończone Zadania';

  @override
  String get noTasksMessage => 'Brak zadań. Dodaj jedno używając przycisku +!';

  @override
  String get pleaseEnterTitleError => 'Proszę podać tytuł zadania';

  @override
  String get taskAddedSuccessMessage => 'Zadanie dodane pomyślnie!';

  @override
  String get taskUpdatedSuccessMessage => 'Zadanie zaktualizowane pomyślnie!';

  @override
  String deleteTaskConfirmationMessage(String taskTitle) {
    return 'Czy na pewno chcesz usunąć \"$taskTitle\"?';
  }

  @override
  String get overdueByText => 'Spóźnione o';

  @override
  String get dueInText => 'Za';

  @override
  String get daysText => 'dni';

  @override
  String get hoursText => 'godzin';

  @override
  String get minutesText => 'minut';

  @override
  String get nowText => 'teraz';

  @override
  String get deadlinePrefix => 'Termin: ';

  @override
  String get timePrefix => 'Czas: ';

  @override
  String taskDeletedMessage(String taskTitle) {
    return 'Zadanie \"$taskTitle\" zostało usunięte';
  }

  @override
  String get taskServiceNotInitialized =>
      'TaskService nie został zainicjalizowany';

  @override
  String get settings => 'Ustawienia';

  @override
  String get systemTheme => 'Motyw Systemowy';

  @override
  String get lightTheme => 'Motyw Jasny';

  @override
  String get darkTheme => 'Motyw Ciemny';

  @override
  String get notificationTitle => 'Przypomnienie o Zadaniu';

  @override
  String notificationBody(String taskTitle) {
    return 'Nie zapomnij: $taskTitle';
  }

  @override
  String get notificationChannelName => 'Przypomnienia o Zadaniach';

  @override
  String get notificationChannelDescription =>
      'Przypomnienia o zbliżających się terminach zadań';

  @override
  String get statistics => 'Statystyki';

  @override
  String get refreshStatistics => 'Odśwież statystyki';

  @override
  String get calculatingStatistics => 'Obliczanie statystyk...';

  @override
  String errorLoadingStatistics(String error) {
    return 'Błąd podczas ładowania statystyk: $error';
  }

  @override
  String get retry => 'Spróbuj ponownie';

  @override
  String get noStatisticsAvailable => 'Brak dostępnych statystyk';

  @override
  String get overview => 'Przegląd';

  @override
  String get totalTasks => 'Wszystkich Zadań';

  @override
  String get completed => 'Ukończone';

  @override
  String get active => 'Aktywne';

  @override
  String get overdue => 'Spóźnione';

  @override
  String get completionRate => 'Wskaźnik Ukończenia';

  @override
  String get productivityStreaks => 'Serie Produktywności';

  @override
  String get currentStreak => 'Obecna Seria';

  @override
  String get longestStreak => 'Najdłuższa Seria';

  @override
  String get dayText => 'dzień';

  @override
  String get averagePerDay => 'Średnio dziennie';

  @override
  String get tasksText => 'zadań';

  @override
  String get last30Days => 'Ostatnie 30 dni';

  @override
  String get good => 'Dobra';

  @override
  String get low => 'Niska';

  @override
  String get weeklyProductivity => 'Produktywność Tygodniowa';

  @override
  String get noDataAvailable => 'Brak dostępnych danych';

  @override
  String get monday => 'Pon';

  @override
  String get tuesday => 'Wt';

  @override
  String get wednesday => 'Śr';

  @override
  String get thursday => 'Czw';

  @override
  String get friday => 'Pt';

  @override
  String get saturday => 'Sob';

  @override
  String get sunday => 'Nd';

  @override
  String get thisWeek => 'Ten Tydzień';

  @override
  String get dailyAvg => 'Średnia Dzienna';

  @override
  String get recentlyCompleted => 'Ostatnio Ukończone';

  @override
  String get noCompletedTasksYet => 'Brak ukończonych zadań';

  @override
  String get startCompletingTasks =>
      'Zacznij ukończać zadania, aby je tutaj zobaczyć';

  @override
  String showingXOfYTasks(int showing, int total) {
    return 'Wyświetlane $showing z $total ukończonych zadań';
  }

  @override
  String get justNow => 'Przed chwilą';

  @override
  String get oneMinuteAgo => '1 minutę temu';

  @override
  String minutesAgo(int minutes) {
    return '$minutes minut temu';
  }

  @override
  String get oneHourAgo => '1 godzinę temu';

  @override
  String hoursAgo(int hours) {
    return '$hours godzin temu';
  }

  @override
  String get oneDayAgo => '1 dzień temu';

  @override
  String daysAgo(int days) {
    return '$days dni temu';
  }
}
