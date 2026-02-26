import 'package:exam_practice_app/bloc/grade/grade_bloc.dart';
import 'package:exam_practice_app/bloc/grade/grade_event.dart';
import 'package:exam_practice_app/bloc/grade/grade_state.dart';
import 'package:exam_practice_app/model/home_page_layout.dart';
import 'package:exam_practice_app/repos/grade_repo.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/exam_grade.dart';
import 'subject_selection_screen.dart';

class GradeSelectionScreen extends StatelessWidget {
  const GradeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => GradeRepository(),
      child: BlocProvider(
        create:
            (context) =>
                GradeBloc(RepositoryProvider.of<GradeRepository>(context))
                  ..add(GradeInitialEvent()),

        child: Scaffold(
          backgroundColor: AppColors.main_background_color,

          appBar: AppBar(
            title: const Text(
              'Select Grade',
              style: TextStyle(
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
          body: BlocBuilder<GradeBloc, GradeState>(
            builder: (context, state) {
              if (state is GradeInitialState) {
                return LoadingIndicator();
              } else if (state is GradeSuccessState) {
                List<GradeModel> gradeModel = state.gradeModel;
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
                        final grade = gradeModel[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubjectSelectionScreen(),
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
                                  grade.label,
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
                      itemCount: gradeModel.length,
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

class _GradeCard extends StatelessWidget {
  final ExamGrade grade;
  final VoidCallback onTap;

  const _GradeCard({required this.grade, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(grade.icon, size: 60, color: grade.color),
            const SizedBox(height: 12),
            Text(
              grade.label,
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
  }
}
