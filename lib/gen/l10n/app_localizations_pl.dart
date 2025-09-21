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
}
