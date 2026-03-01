import 'package:exam_practice_app/bloc/grade/grade_state.dart';
import 'package:exam_practice_app/bloc/subject/subject_selection_bloc.dart';
import 'package:exam_practice_app/bloc/subject/subject_selection_event.dart';
import 'package:exam_practice_app/bloc/subject/subject_selection_state.dart';
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/model/exam_grade.dart';
import 'package:exam_practice_app/repos/subject_repo.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/loading_indicator.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'practice_exam_screen.dart';

class SubjectSelectionScreen extends StatelessWidget {
  const SubjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SubjectSelectionRepository(),
      child: BlocProvider(
        create:
            (context) => SubjectctSelectionBloc(
              RepositoryProvider.of<SubjectSelectionRepository>(context),
            )..add(SubjectctSelectionInitialEvent()),

        child: Scaffold(
          backgroundColor: AppColors.main_background_color,

          appBar: AppBar(
            title: medium_text_page(textValue: t(context).select_subject),
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
          body: BlocBuilder<SubjectctSelectionBloc, SubjectctSelectionState>(
            builder: (context, state) {
              if (state is SubjectctSelectionInitialState) {
                return LoadingIndicator();
              } else if (state is SubjectctSelectionSuccessState) {
                List<ExamGradeModel> subject_model =
                    state.SubjectctSelectionModel;
                return CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate([SizedBox(height: 40)]),
                    ),
                    SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (context, index) {
                        final grade = subject_model[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => PracticeExamScreen(
                                      subjectId: subject_model[index].id,
                                      subjectName:
                                          subject_model[index].subject_title,
                                    ),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(grade.icon, size: 60, color: grade.color),
                                const SizedBox(height: 12),
                                Text(
                                  grade.subject_title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: subject_model.length,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([SizedBox(height: 30)]),
                    ),
                  ],
                );
              } else if (state is GradeErrorState) {
                return const Center(child: Text("Failed to load grades"));
              } else {
                return LoadingIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
