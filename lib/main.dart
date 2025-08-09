import 'package:exam_practice_app/app_states/languge_block/language_state.dart';
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/widgets/app_bar.dart';
import 'package:exam_practice_app/widgets/body_samll_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final local_lang = AppLocalizations.of(context);
    return BlocProvider<AppLanguageBloc>(
      create: (context) => AppLanguageBloc(), // Initial language is English
      child: BlocBuilder<AppLanguageBloc, AppLanguageState>(
        builder: (context, state) {
          return MaterialApp(
            // locale: state.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MyHomePage(title: local_lang!.appName),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          App_Bar(),
          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return ListTile(
                title: body_samll_text_page(text_value: 'Item #$index'),
              );
            }, childCount: 100),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
