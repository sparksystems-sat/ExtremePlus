import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/app/app_router.dart';
import 'package:exam_practice_app/features/timer/timer_overlay.dart';
import 'package:exam_practice_app/services/local_notifications.dart';
import 'package:exam_practice_app/features/timer/services/study_timer_service.dart';
import 'package:exam_practice_app/utility/appTheme.dart';
import 'package:exam_practice_app/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  await StudyTimerService.instance.init();

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
      navigatorKey: TimerOverlay.key,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: BottomNavigation(),
    );
  }
}
