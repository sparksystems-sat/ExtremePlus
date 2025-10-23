import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/widgets/body_text.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';
import 'package:exam_practice_app/widgets/subject_card.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverList(
          //   delegate: SliverChildListDelegate([
          //     Center(
          //       child: medium_text_page(text_value: t(context).bottom_home),
          //     ),
          //   ]),
          // ),
          // SliverGrid.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 8.0,
          //     crossAxisSpacing: 8.0,
          //     childAspectRatio: 1.0,
          //   ),
          //   itemCount: 10,
          //   itemBuilder: (context, index) {
          //     return SubjectCard(
          //       subjectName: "Mathematics",
          //       progress: 40,
          //       icon: Icons.calculate,
          //       iconColor: Colors.orange,
          //     );
          //   },
          // ),

         SliverGrid.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 8.0,
    crossAxisSpacing: 8.0,
    childAspectRatio: 0.8,
  ),
  itemCount: 4, // 👈 4 subjects
  itemBuilder: (context, index) {
    // Sample subject data
    final subjects = [
      {
        "name": "Mathematics",
        "progress": 40,
        "icon": Icons.calculate,
        "color": Colors.orange,
      },
      {
        "name": "Biology",
        "progress": 60,
        "icon": Icons.biotech, // DNA / microscope-like icon
        "color": Colors.green,
      },
      {
        "name": "Physics",
        "progress": 30,
        "icon": FontAwesomeIcons.bolt,
        "color": Colors.blue,
      },
      {
        "name": "Chemistry",
        "progress": 50,
        "icon": FontAwesomeIcons.flask,
        "color": Colors.purple,
      },
    ];

    final subject = subjects[index];

    return SizedBox(
  width: 140,
  height: 160,
  child: SubjectCardExam(
    subjectName: subject["name"] as String,
    progress: subject["progress"] as int,
    icon: subject["icon"] as IconData,
    iconColor: subject["color"] as Color,
  ),
);

  },
),


        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:exam_practice_app/widgets/subject_card.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SubjectCard(
//           subjectName: "Mathematics",
//           progress: 40,
//           icon: Icons.calculate,     // Calculator icon
//           iconColor: Colors.orange,  // Icon + progress bar color
//         ),
//       ),
//     );
//   }
// }

