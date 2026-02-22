import 'package:exam_practice_app/bloc/subject/subject_selection_bloc.dart';
import 'package:exam_practice_app/bloc/subject/subject_selection_event.dart';
import 'package:exam_practice_app/bloc/subject/subject_selection_state.dart';
import 'package:exam_practice_app/repos/subject_repo.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/exam_repository.dart';
import '../models/exam_subject.dart';
import 'practice_exam_screen.dart';

class SubjectSelectionScreen extends StatelessWidget {
  final String gradeId;
  final String gradeLabel;

  const SubjectSelectionScreen({
    super.key,
    required this.gradeId,
    required this.gradeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final subjects = ExamRepository.getSubjects();
    return RepositoryProvider(
      create: (context) => SubjectSelectionRepository(),
      child: BlocProvider(
        create:
            (context) => SubjectctSelectionBloc(
              RepositoryProvider.of<SubjectSelectionRepository>(context),
            )..add(SubjectctSelectionInitialEvent()),

        child: BlocBuilder<SubjectctSelectionBloc, SubjectctSelectionState>(
          builder: (context, state) {
            if (state is SubjectctSelectionInitialState) {
              return Scaffold(body: Center(child: LoadingIndicator()));
            }
            if (state is SubjectctSelectionSuccessState) {
              return Scaffold(
                backgroundColor: AppColors.main_background_color,
                appBar: AppBar(
                  title: Text(
                    'Select Subject - $gradeLabel',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
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
                body: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return _SubjectCard(
                      subject: subject,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => PracticeExamScreen(
                                  subjectId: subject.id,
                                  subjectName: subject.name,
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            } else if (state is SubjectctSelectionErrorState) {
              return const Center(child: Text("Failed to load grades"));
            } else {
              return Scaffold(body: Center(child: LoadingIndicator()));
            }
          },
        ),
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final ExamSubject subject;
  final VoidCallback onTap;

  const _SubjectCard({required this.subject, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(top: 12, bottom: 6),
                decoration: BoxDecoration(
                  color: subject.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(subject.icon, color: subject.color, size: 28),
              ),
              Text(
                subject.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${subject.progress}% mastered',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: subject.progress / 100,
                  backgroundColor: Colors.grey[300],
                  color: subject.color,
                  minHeight: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
