import 'dart:async';

import 'package:exam_practice_app/features/game/screens/game_subjects_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  bool _autoForward = true;
  Timer? _autoTimer;

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final targetIndex = _autoForward ? 1 : 0;
      _pageController
          .animateToPage(
            targetIndex,
            duration: const Duration(milliseconds: 420),
            curve: Curves.easeInOut,
          )
          .then((_) {
            if (!mounted) return;
            setState(() {
              _pageIndex = targetIndex;
              _autoForward = !_autoForward;
            });
          });
    });
  }

  void _openSubjects() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GameSubjectsPage()),
    );
  }

  Widget _buildCarousel() {
    final slides = <Widget>[
      Center(
        child: SvgPicture.asset(
          'assets/svgs/battle.svg',
          height: 230,
          fit: BoxFit.contain,
        ),
      ),
      Center(
        child: SvgPicture.asset(
          'assets/svgs/trophy.svg',
          height: 230,
          fit: BoxFit.contain,
        ),
      ),
    ];

    return Column(
      children: [
        SizedBox(
          height: 290,
          child: PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _pageIndex = value;
                _autoForward = value == 0;
              });
            },
            children: slides,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'KnowledgeBattle',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Engage in fun educational challenges!',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: 160,
          height: 44,
          child: OutlinedButton(
            onPressed: _openSubjects,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFFFF59D),
              foregroundColor: Colors.black,
              side: const BorderSide(color: Color(0xFFE8D95A)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text(
              'Initiate',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            slides.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: index == _pageIndex ? 22 : 16,
              decoration: BoxDecoration(
                color:
                    index == _pageIndex
                        ? Colors.grey.shade400
                        : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [const SizedBox(height: 10), _buildCarousel()],
          ),
        ),
      ),
    );
  }
}
