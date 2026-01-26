import 'package:exam_practice_app/features/exam_practice/models/exam_question.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final ExamQuestion question;
  final int questionNumber;
  final int? selectedAnswerIndex;
  final bool isInstantAnswerEnabled;
  final bool showExplanation;
  final Function(int) onSelectAnswer;
  final VoidCallback onToggleExplanation;

  const QuestionCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.selectedAnswerIndex,
    required this.isInstantAnswerEnabled,
    required this.showExplanation,
    required this.onSelectAnswer,
    required this.onToggleExplanation,
  });

  Color _getOptionBorderColor(int optionIndex) {
    if (selectedAnswerIndex == null) {
      return Colors.grey.shade300;
    }

    if (isInstantAnswerEnabled) {
      if (optionIndex == question.correctAnswerIndex) {
        return AppColors.correct_answer;
      }
      if (optionIndex == selectedAnswerIndex &&
          selectedAnswerIndex != question.correctAnswerIndex) {
        return AppColors.wrong_answer;
      }
      return Colors.grey.shade300;
    } else {
      if (optionIndex == selectedAnswerIndex) {
        return AppColors.button3Color;
      }
    }

    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q$questionNumber',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              question.question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              question.options.length,
              (index) => _buildOption(index),
            ),
            if (selectedAnswerIndex != null && isInstantAnswerEnabled) ...[
              const SizedBox(height: 12),
              GestureDetector(
                onTap: onToggleExplanation,
                child: Text(
                  showExplanation ? 'Hide Description' : 'Show Description',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
              if (showExplanation) ...[
                const SizedBox(height: 8),
                Text(question.explanation, style: TextStyle(fontSize: 14)),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index) {
    final option = question.options[index];
    final optionLabel = String.fromCharCode(65 + index);
    final isSelected = selectedAnswerIndex == index;
    final showCorrect = isInstantAnswerEnabled && selectedAnswerIndex != null;
    final isCorrect = showCorrect && index == question.correctAnswerIndex;
    final emphasizeBorder = isSelected || isCorrect;

    return GestureDetector(
      onTap: () => onSelectAnswer(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: _getOptionBorderColor(index),
            width: emphasizeBorder ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              '$optionLabel. ',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Expanded(child: Text(option, style: const TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }
}
