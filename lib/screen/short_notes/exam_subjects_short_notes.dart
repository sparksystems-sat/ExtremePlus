import 'package:exam_practice_app/screen/short_notes/short_note.dart';
import 'package:exam_practice_app/widgets/subject_card_general.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exam_practice_app/widgets/subject_card.dart';
import 'package:exam_practice_app/l10n/language_constants.dart';

import 'package:exam_practice_app/screen/exam_page.dart';

class ExamSubjectsPageShortNotes extends StatefulWidget {
  const ExamSubjectsPageShortNotes({Key? key}) : super(key: key);

  @override
  State<ExamSubjectsPageShortNotes> createState() => _ExamSubjectsPageState();
}

class _ExamSubjectsPageState extends State<ExamSubjectsPageShortNotes> {
  @override
  Widget build(BuildContext context) {
    // Make sure these keys exist in your .arb files
    final screenWidth = MediaQuery.of(context).size.width;

    double iconSize;
    double fontSize;
    double aspectRatio;

    if (screenWidth < 400) {
      iconSize = 20;
      fontSize = 14;
      aspectRatio = 0.9;
    } else if (screenWidth < 600) {
      iconSize = 40;
      fontSize = 18;
      aspectRatio = 1.0;
    } else if (screenWidth < 800) {
      iconSize = 60;
      fontSize = 22;
      aspectRatio = 1.4;
    } else {
      iconSize = 80;
      fontSize = 26;
      aspectRatio = 1.6;
    }

    final List<Map<String, dynamic>> subjects = [
      {
        "name": t(context).mathematics,
        "progress": 40,
        "icon": Icons.calculate,
        "color": Colors.orange,
      },
      {
        "name": t(context).biology,
        "progress": 60,
        "icon": Icons.biotech,
        "color": Colors.green,
      },
      {
        "name": t(context).physics,
        "progress": 30,
        "icon": FontAwesomeIcons.bolt,
        "color": Colors.blue,
      },
      {
        "name": t(context).chemistry,
        "progress": 50,
        "icon": FontAwesomeIcons.flask,
        "color": Colors.purple,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Subject',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              // const Divider(),
              const SizedBox(height: 5),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(12.0, 0, 8, 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       big_text_page(text_value: t(context).exam_title)
              //           .animate(onPlay: (controller) => controller.repeat())
              //           .fadeIn(duration: 600.ms)
              //           .then(delay: 2000.ms)
              //           .shimmer(),
              //     ],
              //   ),
              // ),
              // const Divider(),
              const SizedBox(height: 20),
            ]),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: aspectRatio,
              ),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShortNotesPage()),
                    );
                  },
                  child: SubjectCardGeneral(
                    subjectName: subject["name"] as String,
                    icon: subject["icon"] as IconData,
                    iconColor: subject["color"] as Color,
                    iconSize: iconSize,
                    fontSize: fontSize,
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([const SizedBox(height: 30)]),
          ),
        ],
      ),
    );
  }
}
