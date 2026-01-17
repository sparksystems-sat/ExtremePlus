import 'package:exam_practice_app/utility/appColors.dart';
import 'package:flutter/material.dart';
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

    return Scaffold(
      backgroundColor: AppColors.main_background_color,
      appBar: AppBar(
        title: const Text(
          'Select Subject',
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
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.95,
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
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
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
