// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Exam Practice App';

  @override
  String get welcomeMessage => 'Welcome to the Exam Practice App!';

  @override
  String get startExam => 'Start Exam';

  @override
  String get viewResults => 'View Results';

  @override
  String get settings => 'Settings';

  @override
  String get exit => 'Exit';

  @override
  String get examInstructions => 'Please read the instructions carefully before starting the exam.';

  @override
  String get submitExam => 'Submit Exam';

  @override
  String get examSubmitted => 'Your exam has been submitted successfully!';
}
