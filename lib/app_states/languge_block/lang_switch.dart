import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagSwitch extends Cubit<Locale> {
  LanguagSwitch() : super(const Locale('EN'));
  void switchLanguage() {
    if (state.languageCode == 'EN') {
      emit(const Locale('AM', 'ET'));
    } else {
      emit(const Locale('EN', 'US'));
    }
  }
}
