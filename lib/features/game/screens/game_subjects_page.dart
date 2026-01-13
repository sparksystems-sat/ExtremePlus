import 'package:exam_practice_app/features/game/data/quiz_data.dart';
import 'package:exam_practice_app/features/game/models/quiz_model.dart';
import 'package:exam_practice_app/features/game/screens/quiz_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameSubjectsPage extends StatelessWidget {
  const GameSubjectsPage({super.key});

  static const double _cardWidth = 165;
  static const double _cardHeight = 100;
  static const double _cardAspectRatio = _cardWidth / _cardHeight;

  String _subjectSvgAsset(String subjectName) {
    final normalized = subjectName.trim().toLowerCase().replaceAll(' ', '');
    return 'assets/svgs/subjects/$normalized.svg';
  }

  @override
  Widget build(BuildContext context) {
    final List<QuizSubject> subjects = QuizData.getQuizSubjects();
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - (16 * 2);
    const spacing = 16.0;
    final crossAxisCount = ((availableWidth + spacing) / (_cardWidth + spacing))
        .floor()
        .clamp(2, 6);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Choose your Battle',
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
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 39.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: _cardAspectRatio,
              ),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];

                return _SubjectCard(
                  subjectName: subject.name,
                  svgAssetPath: _subjectSvgAsset(subject.name),
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
  final VoidCallback onTap;

  const _SubjectCard({
    required this.subjectName,
    required this.svgAssetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = (constraints.maxWidth / GameSubjectsPage._cardWidth)
              .clamp(0.0, 1.0);
          final cardWidth = GameSubjectsPage._cardWidth * scale;
          final cardHeight = GameSubjectsPage._cardHeight * scale;
          final iconSize = 32 * scale;
          final fontSize = 16 * scale;

          return Center(
            child: Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 14 * scale,
                vertical: 12 * scale,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    svgAssetPath,
                    height: iconSize,
                    width: iconSize,
                  ),
                  SizedBox(height: 10 * scale),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      subjectName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
