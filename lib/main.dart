import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/utility/appTheme.dart';
import 'package:exam_practice_app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
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
  const MyApp({super.key});
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
