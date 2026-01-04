import 'package:exam_practice_app/features/game/models/quiz_model.dart';
import 'package:exam_practice_app/features/game/screens/quiz_result_page.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameQuizQuestionPage extends StatefulWidget {
  final QuizSubject quizSubject;

  const GameQuizQuestionPage({super.key, required this.quizSubject});

  @override
  State<GameQuizQuestionPage> createState() => _GameQuizQuestionPageState();
}

class _GameQuizQuestionPageState extends State<GameQuizQuestionPage> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool hasAnswered = false;
  int _correctCount = 0;

  void selectAnswer(int index) {
    if (hasAnswered) return;

    final isCorrect =
        index ==
        widget.quizSubject.questions[currentQuestionIndex].correctAnswerIndex;

    setState(() {
      selectedAnswerIndex = index;
      hasAnswered = true;
      if (isCorrect) _correctCount++;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < widget.quizSubject.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        hasAnswered = false;
      });
      return;
    }

    final total = widget.quizSubject.questions.length;
    final averageMark = total / 2.0;
    final isCompleted = _correctCount > averageMark;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (_) => GameQuizResultPage(
              quizSubject: widget.quizSubject,
              isCompleted: isCompleted,
            ),
      ),
    );
  }

  bool get _isCorrect {
    if (!hasAnswered || selectedAnswerIndex == null) return false;
    return selectedAnswerIndex ==
        widget.quizSubject.questions[currentQuestionIndex].correctAnswerIndex;
  }

  int get _correctIndex =>
      widget.quizSubject.questions[currentQuestionIndex].correctAnswerIndex;

  Color getOptionColor(int index) => Colors.white;

  @override
  Widget build(BuildContext context) {
    final question = widget.quizSubject.questions[currentQuestionIndex];
    final feedbackBg =
        _isCorrect
            ? AppColors.correct_answer.withOpacity(0.20)
            : AppColors.wrong_answer.withOpacity(0.14);
    final feedbackAccent =
        _isCorrect ? AppColors.correct_answer : AppColors.wrong_answer;
    final buttonShadowColor = feedbackAccent.withOpacity(0.45);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.quizSubject.name,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/diamond.svg',
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '30',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/sword.svg',
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(height: 10),
                        SvgPicture.asset(
                          'assets/svgs/book_menu.svg',
                          width: 22,
                          height: 22,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/shield.svg',
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '5',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                question.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedAnswerIndex == index;
                  final isCorrectChoice =
                      hasAnswered && isSelected && index == _correctIndex;
                  final isWrongChoice =
                      hasAnswered && isSelected && index != _correctIndex;
                  final borderColor =
                      isCorrectChoice
                          ? AppColors.correct_answer
                          : isWrongChoice
                          ? AppColors.wrong_answer
                          : Colors.grey.shade300;
                  final borderWidth =
                      (isCorrectChoice || isWrongChoice) ? 2.5 : 1.5;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GestureDetector(
                      onTap: () => selectAnswer(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: getOptionColor(index),
                          border: Border.all(
                            color: borderColor,
                            width: borderWidth,
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                question.options[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (hasAnswered)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 22),
                decoration: BoxDecoration(
                  color: feedbackBg,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    _isCorrect
                        ? SvgPicture.asset(
                          'assets/svgs/correct.svg',
                          height: 40,
                          width: 40,
                          color: feedbackAccent,
                        )
                        : SvgPicture.asset(
                          'assets/svgs/wrong.svg',
                          height: 40,
                          width: 40,
                          color: feedbackAccent,
                        ),

                    const SizedBox(height: 14),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: buttonShadowColor,
                            blurRadius: 0,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: feedbackAccent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: const Text('Continue'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
