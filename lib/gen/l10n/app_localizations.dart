import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'TaskFlow'**
  String get appName;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Flow - Todo App'**
  String get appTitle;

  /// No description provided for @addNewTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get addNewTaskTitle;

  /// No description provided for @editTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTaskTitle;

  /// No description provided for @deleteTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTaskTitle;

  /// No description provided for @taskTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Task Title'**
  String get taskTitleLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionLabel;

  /// No description provided for @cancelButtonText.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButtonText;

  /// No description provided for @addTaskButtonText.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTaskButtonText;

  /// No description provided for @updateTaskButtonText.
  ///
  /// In en, this message translates to:
  /// **'Update Task'**
  String get updateTaskButtonText;

  /// No description provided for @deleteButtonText.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButtonText;

  /// No description provided for @activeTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Tasks'**
  String get activeTasksTitle;

  /// No description provided for @completedTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Completed Tasks'**
  String get completedTasksTitle;

  /// No description provided for @noTasksMessage.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet. Add one using the + button!'**
  String get noTasksMessage;

  /// No description provided for @pleaseEnterTitleError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a task title'**
  String get pleaseEnterTitleError;

  /// No description provided for @taskAddedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Task added successfully!'**
  String get taskAddedSuccessMessage;

  /// No description provided for @taskUpdatedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Task updated successfully!'**
  String get taskUpdatedSuccessMessage;

  /// No description provided for @deleteTaskConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{taskTitle}\"?'**
  String deleteTaskConfirmationMessage(String taskTitle);

  /// No description provided for @overdueByText.
  ///
  /// In en, this message translates to:
  /// **'Overdue by'**
  String get overdueByText;

  /// No description provided for @dueInText.
  ///
  /// In en, this message translates to:
  /// **'Due in'**
  String get dueInText;

  /// No description provided for @daysText.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get daysText;

  /// No description provided for @hoursText.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hoursText;

  /// No description provided for @minutesText.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutesText;

  /// No description provided for @nowText.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get nowText;

  /// No description provided for @deadlinePrefix.
  ///
  /// In en, this message translates to:
  /// **'Deadline: '**
  String get deadlinePrefix;

  /// No description provided for @timePrefix.
  ///
  /// In en, this message translates to:
  /// **'Time: '**
  String get timePrefix;

  /// No description provided for @taskDeletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Task \"{taskTitle}\" deleted'**
  String taskDeletedMessage(String taskTitle);

  /// No description provided for @taskServiceNotInitialized.
  ///
  /// In en, this message translates to:
  /// **'TaskService not initialized'**
  String get taskServiceNotInitialized;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// System theme option in settings
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get systemTheme;

  /// Light theme option in settings
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// Dark theme option in settings
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
