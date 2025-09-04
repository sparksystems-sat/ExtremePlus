import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/main.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    // final language_switch = context.read<LanguagSwitch>();
    return SliverAppBar(
      // expandedHeight: 150.0,
      elevation: 1.0,
      floating: false,
      title: big_text_page(text_value: t(context).appName),
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

        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 27.0, 8.0),
            child: PopupMenuButton<String>(
              child: Row(
                children: [
                  selectedLang.isNotEmpty
                      ? Text(
                        selectedLang,
                        style: TextStyle(
                          color: AppColors.icon_color,
                          fontSize: 16.0,
                        ),
                      )
                      : Icon(Icons.language, color: AppColors.icon_color),
                ],
              ),
              onSelected: (String value) {
                if (value == "አማርኛ") {
                  setState(() {
                    selectedLang = "አማ";
                  });
                  languageChage(context, AMHARIC);
                } else if (value == "English") {
                  setState(() {
                    selectedLang = "Eng";
                  });
                  languageChage(context, ENGLISH);
                }
              },
              itemBuilder: (BuildContext context) {
                return Language.languageList().map((Language language) {
                  return PopupMenuItem<String>(
                    value: language.name,
                    child: Row(
                      children: [
                        Text(language.flag),
                        const SizedBox(width: 10.0),
                        Text(language.name),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }
}
