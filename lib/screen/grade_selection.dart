import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exam_practice_app/screen/exam_subjects.dart';

class GradeSelectionPage extends StatelessWidget {
  const GradeSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> grades = [
      {
        "label": "Grade 9",
        "icon": Icons.stairs,
        "color": Colors.green,
      },
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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final grade = grades[index];
            return GestureDetector(
              onTap: () {
                print("Selected ${grade['label']}");

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExamSubjectsPage()),
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
                    Icon(
                      grade['icon'],
                      size: 60,
                      color: grade['color'],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      grade['label'],
                      style: const TextStyle(
                        fontSize: 16,
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