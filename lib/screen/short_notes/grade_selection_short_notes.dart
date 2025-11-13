import 'package:exam_practice_app/screen/short_notes/exam_subjects_short_notes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exam_practice_app/screen/exam_subjects.dart';

class GradeSelectionPageShortNotes extends StatelessWidget {
  const GradeSelectionPageShortNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double iconSize;
    double fontSize;
    double aspectRatio;

    if (screenWidth < 400) {
      iconSize = 50;
      fontSize = 14;
      aspectRatio = 0.9;
    } else if (screenWidth < 600) {
      iconSize = 70;
      fontSize = 18;
      aspectRatio = 1.0;
    } else if (screenWidth < 800) {
      iconSize = 90;
      fontSize = 22;
      aspectRatio = 1.4;
    } else {
      iconSize = 110;
      fontSize = 26;
      aspectRatio = 1.8;
    }

    final List<Map<String, dynamic>> grades = [
      {"label": "Grade 9", "icon": Icons.stairs, "color": Colors.green},
      {
        "label": "Grade 10",
        "icon": Icons.lightbulb,
        "color": Colors.yellow[700],
      },
      {
        "label": "Grade 11",
        "icon": Icons.local_fire_department,
        "color": Colors.red,
      },
      {
        "label": "Grade 12",
        "icon": FontAwesomeIcons.bullseye,
        // "icon": FontAwesomeIcons.key,
        "color": Colors.blue,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Grade',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: grades.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            final grade = grades[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamSubjectsPageShortNotes(),
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(grade['icon'], size: iconSize, color: grade['color']),
                    const SizedBox(height: 12),
                    Text(
                      grade['label'],
                      style: TextStyle(
                        fontSize: fontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
