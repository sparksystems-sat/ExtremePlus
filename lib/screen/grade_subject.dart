
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/widgets/big_text.dart';
import 'package:exam_practice_app/widgets/body_text.dart';
import 'package:exam_practice_app/widgets/grade_subject_container.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GradeSubjectPage extends StatefulWidget {
  final int grade;
  GradeSubjectPage({super.key, required this.grade});
  @override
  State<GradeSubjectPage> createState() => _GradeSubjectPageState();
}

class _GradeSubjectPageState extends State<GradeSubjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Divider(),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    big_text_page(
                          text_value: t(context).subject + " ${widget.grade}",
                        )
                        .animate(
                          // this delay only happens once at the very start
                          onPlay: (controller) => controller.repeat(), // loop
                        )
                        .fadeIn(duration: 600.ms)
                        .then(delay: 2000.ms) // baseline=800ms
                        .shimmer(),
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 10),
            ]),
          ),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisCount: 3,
              // mainAxisSpacing: 18.0,
              // crossAxisSpacing: 4.0,
              // childAspectRatio: 1,
              crossAxisCount: 3,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              int grade = index + 9;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: GradeSubjectContainer(
                      containerTitle: "${t(context).subject} $grade",
                      icon: FontAwesomeIcons.bookOpen,
                    ),
                  ),
                ),
              );
            },
            itemCount: 9,
          ),
        ],
      ),
    );
  }
}
