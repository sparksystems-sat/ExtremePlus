import 'package:exam_practice_app/model/quiz_model.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';

class QuizQuestionPage extends StatefulWidget {
  final QuizSubject quizSubject;
  final IconData icon;
  final Color color;

  const QuizQuestionPage({
    super.key,
    required this.quizSubject,
    required this.icon,
    required this.color,
  });

  @override
  State<QuizQuestionPage> createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool hasAnswered = false;

  void selectAnswer(int index) {
    if (hasAnswered) return;

    setState(() {
      selectedAnswerIndex = index;
      hasAnswered = true;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < widget.quizSubject.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        hasAnswered = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  Color getOptionColor(int index) {
    if (!hasAnswered) {
      return Colors.white;
    }

    if (index ==
        widget.quizSubject.questions[currentQuestionIndex].correctAnswerIndex) {
      return AppColors.correct_answer.withOpacity(0.1);
    }

    if (index == selectedAnswerIndex &&
        index !=
            widget
                .quizSubject
                .questions[currentQuestionIndex]
                .correctAnswerIndex) {
      return AppColors.wrong_answer.withOpacity(0.1);
    }

    return Colors.white;
  }

  Color getOptionBorderColor(int index) {
    if (!hasAnswered) {
      return Colors.grey.shade300;
    }

    if (index ==
        widget.quizSubject.questions[currentQuestionIndex].correctAnswerIndex) {
      return AppColors.correct_answer;
    }

    if (index == selectedAnswerIndex &&
        index !=
            widget
                .quizSubject
                .questions[currentQuestionIndex]
                .correctAnswerIndex) {
      return AppColors.wrong_answer;
    }

    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quizSubject.questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'The Battel of ${widget.quizSubject.name}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset(
                    'assets/icons/medal.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Bitwoded',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/icons/stone.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/icons/sword.png',
                        width: 30,
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              'assets/icons/gasha.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Question
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
          // Options
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: () => selectAnswer(index),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: getOptionColor(index),
                        border: Border.all(
                          color: getOptionBorderColor(index),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
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
              color:
                  selectedAnswerIndex == question.correctAnswerIndex
                      ? AppColors.correct_answer.withOpacity(0.1)
                      : AppColors.wrong_answer.withOpacity(0.1),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  selectedAnswerIndex == question.correctAnswerIndex
                      ? Image.asset(
                        'assets/icons/correct.png',
                        width: 48,
                        height: 48,
                      )
                      : Image.asset(
                        'assets/icons/wrong.png',
                        width: 48,
                        height: 48,
                      ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedAnswerIndex == question.correctAnswerIndex
                                ? AppColors.correct_answer
                                : AppColors.wrong_answer,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        currentQuestionIndex <
                                widget.quizSubject.questions.length - 1
                            ? 'Continue'
                            : 'Go Back',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
