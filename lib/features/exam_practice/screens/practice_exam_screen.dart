import 'package:exam_practice_app/bloc/exam/exam_bloc.dart';
import 'package:exam_practice_app/bloc/exam/exam_event.dart';
import 'package:exam_practice_app/bloc/exam/exam_state.dart';
import 'package:exam_practice_app/features/exam_practice/screens/exam_result_screen.dart';
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/model/question_model.dart';
import 'package:exam_practice_app/repos/exam_repo.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:exam_practice_app/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late List<QuestionModel> selected_questions = [];
  final Map<String, int> selectedAnswers = {};
  final Map<String, bool> showExplanation = {};
  final ScrollController scrollController = ScrollController();

  bool isInstantAnswerEnabled = false;
  bool showSubmitButton = false;
  int answeredCount = 0;
  int question_index = 0;

  @override
  void initState() {
    super.initState();

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

  void _selectAnswer(
    QuestionModel question,
    String questionId,
    int optionIndex,
  ) {
    selected_questions.add(question);

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
    for (var question_data in selected_questions) {
      if (selectedAnswers[question_data.id] ==
          question_data.options.indexWhere(
            (opt) => opt.exam_question_id == question_data.id && opt.is_correct,
          )) {
        correctCount++;
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => ExamResultScreen(
            correctCount: correctCount,
            totalQuestions: selected_questions.length,
            subjectName: widget.subjectName,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ExamRepository(),
      child: BlocProvider(
        create:
            (context) => ExamBloc(
              RepositoryProvider.of<ExamRepository>(context),
              widget.subjectId,
            )..add(ExamInitialEvent()),

        child: Scaffold(
          backgroundColor: AppColors.main_background_color,
          appBar: AppBar(
            title: medium_text_page(
              textValue: widget.subjectName + t(context).practice_exam,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            backgroundColor: AppColors.appbar_color,
            elevation: 0,
          ),
          body: BlocBuilder<ExamBloc, ExamState>(
            builder: (context, state) {
              if (state is ExamInitialState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExamSuccessState) {
                List<QuestionModel> questions = state.ExamModel;
                return Scaffold(
                  body: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      int totalQuestions = questions.length;
                      if (index == 0) {
                        return _buildHeader(totalQuestions);
                      }

                      final question = questions[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: QuestionCard(
                          question: question,
                          questionNumber: index,
                          selectedAnswerIndex: selectedAnswers[question.id],
                          isInstantAnswerEnabled: isInstantAnswerEnabled,
                          showExplanation:
                              showExplanation[question.id] ?? false,
                          onSelectAnswer:
                              (optionIndex) => _selectAnswer(
                                question,
                                question.id,
                                optionIndex,
                              ),
                          onToggleExplanation:
                              () => _toggleExplanation(question.id.toString()),
                        ),
                      );
                    },
                  ),
                  floatingActionButton:
                      (showSubmitButton && selectedAnswers.isNotEmpty)
                          ? FloatingActionButton.extended(
                            onPressed: () {


                              context.read<ExamBloc>().add(
                                ExamSubmitAnswerEvent(selectedAnswers));
                            },
                            backgroundColor: AppColors.button3Color,
                            label: const Text('Submit'),
                          )
                          : null,
                );
              } else {
                return const Center(child: Text('Failed to load questions'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int totalQuestions) {
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
              'Question $answeredCount / $totalQuestions',
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
