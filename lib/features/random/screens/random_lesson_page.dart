import 'dart:math';

import 'package:exam_practice_app/features/random/models/random_lesson.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RandomLessonPage extends StatefulWidget {
  const RandomLessonPage({super.key});

  @override
  State<RandomLessonPage> createState() => _RandomLessonPageState();
}

class _RandomLessonPageState extends State<RandomLessonPage> {
  final Random _rng = Random();
  int _index = 0;

  void _spin() {
    if (lessons.length <= 1) return;
    int next = _index;
    while (next == _index) {
      next = _rng.nextInt(lessons.length);
    }
    setState(() => _index = next);
  }

  @override
  Widget build(BuildContext context) {
    final RandomLesson lesson = lessons[_index];

    return Scaffold(
      backgroundColor: AppColors.main_background_color,
      appBar: AppBar(
        title: const Text(
          'Random Lesson',
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              _HeaderCard(lesson: lesson),
              const SizedBox(height: 16),
              SizedBox(height: 190, child: _BodyCard(text: lesson.body)),
              const Spacer(),
              _SpinButton(onTap: _spin),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.lesson});

  final RandomLesson lesson;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  lesson.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  lesson.subject,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset('assets/svgs/brain.svg', width: 24, height: 24),
        ],
      ),
    );
  }
}

class _BodyCard extends StatelessWidget {
  const _BodyCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Text(text, style: const TextStyle(fontSize: 15, height: 1.35)),
        ),
      ),
    );
  }
}

class _SpinButton extends StatelessWidget {
  const _SpinButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          width: 140,
          height: 140,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18),
                child: SvgPicture.asset(
                  'assets/svgs/spin.svg',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Spin the Brain!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
