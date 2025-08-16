// locale_event.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
abstract class LocaleEvent {}
class LocaleChanged extends LocaleEvent {
  final Locale locale;
  LocaleChanged(this.locale);
}
class LocaleState {
  final Locale locale;
  LocaleState(this.locale);
}
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState(const Locale('EN'))) {
    on<LocaleChanged>((event, emit) {
      emit(LocaleState(event.locale));
    });
  }
}
