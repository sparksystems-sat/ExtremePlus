import 'package:exam_practice_app/model/quiz_model.dart';
import 'package:exam_practice_app/screen/quiz/quiz_detail_page.dart';
import 'package:exam_practice_app/utility/quiz_data.dart';
import 'package:exam_practice_app/widgets/subject_card_general.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubjectBattlePage extends StatefulWidget {
  const SubjectBattlePage({super.key});
  @override
  State<SubjectBattlePage> createState() => _SubjectBattlePageState();
}

class _SubjectBattlePageState extends State<SubjectBattlePage> {
  final List<QuizSubject> quizSubjects = QuizData.getQuizSubjects();

  final List<Map<String, dynamic>> subjectDisplay = [
    {"icon": FontAwesomeIcons.flask, "color": Colors.purple},
    {"icon": Icons.calculate, "color": Colors.orange},
    {"icon": Icons.biotech, "color": Colors.green},
    {"icon": FontAwesomeIcons.bolt, "color": Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose Your Battle',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: aspectRatio,
              ),
              itemCount: quizSubjects.length,
              itemBuilder: (context, index) {
                final subject = quizSubjects[index];
                final display = subjectDisplay[index % subjectDisplay.length];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuizDetailPage(
                              quizSubject: subject,
                              icon: display["icon"] as IconData,
                              color: display["color"] as Color,
                            ),
                      ),
                    );
                  },
                  child: SubjectCardGeneral(
                    subjectName: subject.name,
                    icon: display["icon"] as IconData,
                    iconColor: display["color"] as Color,
                    iconSize: iconSize,
                    fontSize: fontSize,
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }
}
