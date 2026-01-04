import 'package:exam_practice_app/features/game/data/quiz_data.dart';
import 'package:exam_practice_app/features/game/models/quiz_model.dart';
import 'package:exam_practice_app/features/game/screens/quiz_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameSubjectsPage extends StatelessWidget {
  const GameSubjectsPage({super.key});

  String _subjectSvgAsset(String subjectName) {
    final normalized = subjectName.trim().toLowerCase().replaceAll(' ', '');
    return 'assets/svgs/subjects/$normalized.svg';
  }

  @override
  Widget build(BuildContext context) {
    final List<QuizSubject> subjects = QuizData.getQuizSubjects();
    final width = MediaQuery.of(context).size.width;

    double iconSize;
    double fontSize;
    double aspectRatio;

    if (width < 400) {
      iconSize = 20;
      fontSize = 14;
      aspectRatio = 0.9;
    } else if (width < 600) {
      iconSize = 40;
      fontSize = 18;
      aspectRatio = 1.0;
    } else if (width < 800) {
      iconSize = 60;
      fontSize = 22;
      aspectRatio = 1.4;
    } else {
      iconSize = 80;
      fontSize = 26;
      aspectRatio = 1.6;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Choose Bour Battle',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 0,
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
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];

                return _SubjectCard(
                  subjectName: subject.name,
                  svgAssetPath: _subjectSvgAsset(subject.name),
                  iconSize: iconSize,
                  fontSize: fontSize,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => GameQuizDetailPage(quizSubject: subject),
                      ),
                    );
                  },
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

class _SubjectCard extends StatelessWidget {
  final String subjectName;
  final String svgAssetPath;
  final double iconSize;
  final double fontSize;
  final VoidCallback onTap;

  const _SubjectCard({
    required this.subjectName,
    required this.svgAssetPath,
    required this.iconSize,
    required this.fontSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SvgPicture.asset(
                    svgAssetPath,
                    height: iconSize,
                    width: iconSize,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  subjectName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
