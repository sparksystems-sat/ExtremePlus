
import 'package:exam_practice_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String AMHARIC = 'am';


class Language {
  static final all = [
    const Locale('en', ""),
    const Locale('am', ""),

  ];
  final int id;
  final String flag;
  final String name;
  final String languageCode;
  final String countryCode;
  Language(this.id, this.flag, this.name, this.languageCode, this.countryCode);
  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇪🇹", "አማርኛ", "am", "et"),
      Language(2, "🇺🇸", "English", "en", "us"),
    ];
  }
}
Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<String> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LAGUAGE_CODE) ?? ENGLISH;
  return languageCode;
}
Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case AMHARIC:
      return const Locale(AMHARIC, "");
    default:
      return const Locale(ENGLISH, '');
  }
}
AppLocalizations lang(BuildContext context) {

  return AppLocalizations.of(context)!;
}
