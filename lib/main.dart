
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/utility/appTheme.dart';
import 'package:exam_practice_app/widgets/bottom_navigation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:exam_practice_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    // MultiProvider(
    // //   providers: [
    // //     // BlocProvider<LanguagSwitch>(create: (context) => LanguagSwitch()),
    // //     // BlocProvider(create: (context) => LocaleBloc()),
    // //   ],
    //   child: const MyApp(),
    // ),
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State createState() => MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    MyAppState? state = context.findAncestorStateOfType<MyAppState>();
    state?.setLocale(newLocale);
  }
}
class MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocale().then((locale) {
      setLocale(Locale(locale));
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themData,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: BottomNavigation(),
    );
  }
}
