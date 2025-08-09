import 'dart:ui';
abstract class AppLanguageEvent {}
class ChangeLanguageEvent extends AppLanguageEvent {
  final Locale newLocale;
  ChangeLanguageEvent(this.newLocale);
}
