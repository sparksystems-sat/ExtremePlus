import 'package:exam_practice_app/app_states/languge_block/lang_switch.dart';
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/main.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/big_text.dart';
import 'package:exam_practice_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App_Bar extends StatefulWidget {
  const App_Bar({super.key});

  @override
  State<App_Bar> createState() => _App_BarState();
}

class _App_BarState extends State<App_Bar> {
  String selectedLang = "";
  bool isdropdown = false;
  bool isdropdown1 = false;
  @override
  void initState() {
    super.initState();
    _updateLocale();
  }

  Future<void> _updateLocale() async {
    String languageCode = await getLocale();
    if (AMHARIC == languageCode) {
      selectedLang = "አማርኛ";
    } else if (ENGLISH == languageCode) {
      selectedLang = "English";
    }
    setState(() {
      setLocale(languageCode);
      _locale(languageCode);
    });
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

  Future<void> languageChage(BuildContext context, String langugeCode) async {
    Locale locale = await setLocale(langugeCode);
    MyApp.setLocale(context, locale);
  }

  @override
  Widget build(BuildContext context) {
    final language_switch = context.read<LanguagSwitch>();
    return SliverAppBar(
      // expandedHeight: 150.0,
      elevation: 1.0,
      floating: false,
      title: big_text_page(text_value: lang(context).appName),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(centerTitle: true),
      actions: [
        // The language switch button.
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
          child: IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.share,
              color: AppColors.icon_color,
              size: 20.0,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
          child: IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.gear,
              color: AppColors.icon_color,
              size: 20.0,
            ),
          ),
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children:
        //       Language.languageList().map((langKey) {
        //         return Column(
        //           children: [
        //             ListTile(
        //               onTap: () {
        //                 setState(() {
        //                   isdropdown = !isdropdown;
        //                   selectedLang = langKey.name;
        //                   languageChage(context, langKey.languageCode);
        //                 });
        //               },
        //               title: Text(langKey.name), // Get translated text
        //             ),
        //             const Divider(thickness: 0.3),
        //           ],
        //         );
        //       }).toList(),
        // ),
        GestureDetector(
          onTap: () {
            language_switch.switchLanguage();
            setState(() {
              languageChage(context, language_switch.state.languageCode);
            });
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 27.0, 8.0),
            child: samll_text_page(
              text_value: language_switch.state.languageCode,
            ),
          ),
        ),
      ],
    );
  }
}
