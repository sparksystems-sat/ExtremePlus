import 'package:exam_practice_app/widgets/subject_card_widget.dart';
import 'package:flutter/material.dart';
import 'short_notes_page.dart';

class ShortNotesSubjectSelectionScreen extends StatelessWidget {
  const ShortNotesSubjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = ['Mathematics', 'Biology', 'Physics', 'Chemistry'];

    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - (16 * 2);
    const spacing = 16.0;
    final crossAxisCount = ((availableWidth + spacing) /
            (SubjectCardWidget.cardWidth + spacing))
        .floor()
        .clamp(2, 6);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Short Notes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        backgroundColor: const Color(0xFFEDEDED),
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 39.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: SubjectCardWidget.cardAspectRatio,
              ),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return SubjectCardWidget(
                  subjectName: subject,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ShortNotesPage(subjectTitle: subject),
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
