import 'package:exam_practice_app/features/game/models/quiz_model.dart';
import 'package:exam_practice_app/features/game/screens/next_level_page.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameQuizResultPage extends StatelessWidget {
  final QuizSubject quizSubject;
  final bool isCompleted;

  const GameQuizResultPage({
    super.key,
    required this.quizSubject,
    required this.isCompleted,
  });

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
              child:
                  isCompleted
                      ? _LevelCompleted(
                        onProceed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      NextLevelPage(quizSubject: quizSubject),
                            ),
                          );
                        },
                      )
                      : _LevelFailed(
                        onBuyGashas: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'coming soon.',
                                style: TextStyle(color: Colors.black),
                              ),
                              backgroundColor: AppColors.navSelectedBackground,
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

class _LevelCompleted extends StatelessWidget {
  final VoidCallback onProceed;

  const _LevelCompleted({required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9A4),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                SvgPicture.asset('assets/svgs/hero.svg', height: 120),
                const SizedBox(height: 14),
                const Text(
                  'Congratulations, Hero!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You've successfully conquered this level.\nPrepare for the next battle!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onProceed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button3Color,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Proceed to Gra Azmach'),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelFailed extends StatelessWidget {
  final VoidCallback onBuyGashas;

  const _LevelFailed({required this.onBuyGashas});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
        decoration: BoxDecoration(
          color: AppColors.button3Color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/svgs/shield_depleted.svg', height: 120),
            const SizedBox(height: 14),
            const Text(
              'Shield Depleted',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You've run out of gashas. Purchase more with\nyour amolie gems!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.35),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 170,
              height: 44,
              child: ElevatedButton(
                onPressed: onBuyGashas,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navSelectedBackground,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: const Text('Buy Gashas'),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Available Amolie:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 8),
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navSelectedBackground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
