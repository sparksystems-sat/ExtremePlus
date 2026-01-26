import 'package:exam_practice_app/features/game/models/quiz_model.dart';
import 'package:exam_practice_app/features/game/screens/quiz_question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NextLevelPage extends StatelessWidget {
  final QuizSubject quizSubject;

  const NextLevelPage({super.key, required this.quizSubject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          quizSubject.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 22),
              child: _NextLevel(
                onStartLevel: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => GameQuizQuestionPage(quizSubject: quizSubject),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NextLevel extends StatelessWidget {
  final VoidCallback onStartLevel;

  const _NextLevel({required this.onStartLevel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9C4),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.black26, width: 1),
            ),
            child: Column(
              children: [
                Image.asset('assets/png/mountain.png', height: 130),
                const SizedBox(height: 14),
                const Text(
                  'Welcome to Gra Azmach',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Embark on the adventure of the Gra Azmach\nlevel. Are you ready?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: onStartLevel,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFF59D),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                  side: const BorderSide(color: Color(0xFFE6C200), width: 1),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: const Text('Start Level'),
            ),
          ),
        ],
      ),
    );
  }
}
