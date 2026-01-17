import 'package:exam_practice_app/widgets/question_card.dart';
import 'package:flutter/material.dart';
import '../data/exam_repository.dart';
import '../models/exam_question.dart';
import 'exam_result_screen.dart';
import 'package:exam_practice_app/utility/appColors.dart';

class PracticeExamScreen extends StatefulWidget {
  final String subjectId;
  final String subjectName;

  const PracticeExamScreen({
    super.key,
    required this.subjectId,
    required this.subjectName,
  });

  @override
  State<PracticeExamScreen> createState() => _PracticeExamScreenState();
}

class _PracticeExamScreenState extends State<PracticeExamScreen> {
  late List<ExamQuestion> questions;
  final Map<String, int> selectedAnswers = {};
  final Map<String, bool> showExplanation = {};
  final ScrollController scrollController = ScrollController();

  bool isInstantAnswerEnabled = false;
  bool showSubmitButton = false;
  int answeredCount = 0;

  @override
  void initState() {
    super.initState();
    questions = ExamRepository.getQuestionsBySubject(widget.subjectId);

    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.offset > 50 && !showSubmitButton) {
      setState(() {
        showSubmitButton = true;
      });
    } else if (scrollController.offset <= 50 && showSubmitButton) {
      setState(() {
        showSubmitButton = false;
      });
    }
  }

  void _selectAnswer(String questionId, int optionIndex) {
    final wasAlreadyAnswered = selectedAnswers.containsKey(questionId);
    setState(() {
      selectedAnswers[questionId] = optionIndex;
      if (!wasAlreadyAnswered) {
        answeredCount++;
      }
    });
  }

  void _toggleExplanation(String questionId) {
    setState(() {
      showExplanation[questionId] = !(showExplanation[questionId] ?? false);
    });
  }

  void _toggleInstantAnswer(bool value) {
    setState(() {
      isInstantAnswerEnabled = value;
      if (!value) {
        showExplanation.clear();
      }
    });
  }

  void _submitAnswers() {
    setState(() {
      isInstantAnswerEnabled = true;
    });

    int correctCount = 0;
    for (var question in questions) {
      if (selectedAnswers[question.id] == question.correctAnswerIndex) {
        correctCount++;
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => ExamResultScreen(
            correctCount: correctCount,
            totalQuestions: questions.length,
            subjectName: widget.subjectName,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main_background_color,
      appBar: AppBar(
        title: const Text(
          'Practice Exam',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: AppColors.appbar_color,
        elevation: 0,
      ),
      body: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.zero,
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          }

          final question = questions[index - 1];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: QuestionCard(
              question: question,
              questionNumber: index,
              selectedAnswerIndex: selectedAnswers[question.id],
              isInstantAnswerEnabled: isInstantAnswerEnabled,
              showExplanation: showExplanation[question.id] ?? false,
              onSelectAnswer:
                  (optionIndex) => _selectAnswer(question.id, optionIndex),
              onToggleExplanation: () => _toggleExplanation(question.id),
            ),
          );
        },
      ),

      floatingActionButton:
          (showSubmitButton && selectedAnswers.isNotEmpty)
              ? FloatingActionButton.extended(
                onPressed: _submitAnswers,
                backgroundColor: AppColors.button3Color,
                label: const Text('Submit'),
              )
              : null,
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Question $answeredCount / ${questions.length}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Instant Answer',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Transform.scale(
                scale: 0.95,
                child: Switch(
                  value: isInstantAnswerEnabled,
                  activeColor: AppColors.button3Color,
                  onChanged: _toggleInstantAnswer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
