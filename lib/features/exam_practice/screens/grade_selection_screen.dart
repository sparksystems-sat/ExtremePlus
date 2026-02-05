import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
import '../data/exam_repository.dart';
import '../models/exam_grade.dart';
import 'subject_selection_screen.dart';

class GradeSelectionScreen extends StatelessWidget {
  const GradeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final grades = ExamRepository.getGrades();

    return Scaffold(
      backgroundColor: AppColors.main_background_color,
      appBar: AppBar(
        title: const Text(
          'Select Grade',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: grades.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final grade = grades[index];
            return _GradeCard(
              grade: grade,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SubjectSelectionScreen(
                          gradeId: grade.id,
                          gradeLabel: grade.label,
                        ),
                  ),
                );
              },
            );
          },
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
