import 'dart:ui';

import 'package:exam_practice_app/app_states/languge_block/language_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLanguageState {
  final Locale locale;

  // This ensures the locale is never null
  const AppLanguageState(this.locale);
}

// Your AppLanguageBloc's initial state
class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  AppLanguageBloc()
    : super(
        const AppLanguageState(Locale('en')),
      ); // Ensure initial locale is not null

  // ...
}
