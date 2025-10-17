import 'package:exam_practice_app/model/subject_model.dart';
import 'package:exam_practice_app/widgets/big_text.dart';
import 'package:exam_practice_app/widgets/body_text.dart';
import 'package:exam_practice_app/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class LearningPage extends StatefulWidget {
  final int subject_id;
  const LearningPage({super.key, required this.subject_id});
  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  List<SubjectModel> chapterName = [
    SubjectModel(
      id: 1,
      subject_name: "Chapter 1",
      subject_note:
          "The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time",
    ),
    SubjectModel(
      id: 2,
      subject_name: "Chapter 2",
      subject_note:
          "The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time",
    ),
    SubjectModel(
      id: 3,
      subject_name: "Chapter 3",
      subject_note:
          "The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time",
    ),
    SubjectModel(
      id: 4,
      subject_name: "Chapter 4",
      subject_note:
          "The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time",
    ),
    SubjectModel(
      id: 5,
      subject_name: "Chapter 5",
      subject_note:
          "The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study timehe Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time The Grade 12 Biology Summary Module is a comprehensive yet streamlined resource designed to empower students to excel in their studies and exams. This module offers a powerful combination of clarity, depth, and convenience, ensuring students can make the most of their study time",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    // DefaultTabController manages the TabBar and TabBarView linkage.
    return DefaultTabController(
      length: chapterName.length,
      child: Scaffold(
        // 5. TabBarView (Content) placed in the body
        body: CustomScrollView(
          slivers: [
            MainAppbar(
              title: 'Learning Page',
              tabs: chapterName.map((e) => e.subject_name).toList(),
            ),
            SliverFillRemaining(
              child: TabBarView(
                // Map the data list to a list of content widgets
                children:
                    chapterName.map((subject) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          // Use a Card for a better visual container
                          elevation: 0,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                big_text_page(text_value: 'Summary Note:'),
                                const Divider(height: 20, thickness: 1),
                                // The main content/note
                                body_text_page(
                                  text_value: subject.subject_note,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
