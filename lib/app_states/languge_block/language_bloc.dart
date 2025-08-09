import 'package:exam_practice_app/app_states/languge_block/language_event.dart';
import 'package:exam_practice_app/app_states/languge_block/language_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  AppLanguageBloc(Locale initialLocale)
    : super(AppLanguageState(initialLocale));

  @override
  Stream<AppLanguageState> app_mapEventToState(AppLanguageEvent event) async* {
    if (event is ChangeLanguageEvent) {
      yield AppLanguageState(event.newLocale);
    }
  }
}
