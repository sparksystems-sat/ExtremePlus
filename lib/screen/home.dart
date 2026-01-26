import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/screen/grade_subject.dart';
import 'package:exam_practice_app/features/short_notes/screens/subject_selection_screen.dart';
import 'package:exam_practice_app/features/exam_practice/screens/subject_selection_screen.dart';
import 'package:exam_practice_app/widgets/big_text.dart';
import 'package:exam_practice_app/widgets/grade_subject_container.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:exam_practice_app/screen/exam_subjects.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  int activeIndex = 0;
  final List<Map<String, dynamic>> grades = [
    {"label": "Grade 9", "icon": Icons.stairs, "color": Colors.green},
    {"label": "Grade 10", "icon": Icons.lightbulb, "color": Colors.yellow[700]},
    {
      "label": "Grade 11",
      "icon": Icons.local_fire_department,
      "color": Colors.red,
    },
    {
      "label": "Grade 12",
      "icon": FontAwesomeIcons.bullseye,
      // "icon": FontAwesomeIcons.key,
      "color": Colors.blue,
    },
  ];

  final List<String> images = [
    'https://via.placeholder.com/600/FF5733/FFFFFF?text=Slide+1',
    'https://via.placeholder.com/600/33FF57/FFFFFF?text=Slide+2',
    'https://via.placeholder.com/600/5733FF/FFFFFF?text=Slide+3',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20),
              Column(
                children: [
                  Center(
                    child: CarouselSlider.builder(
                      itemCount: 15,
                      carouselController: buttonCarouselController,
                      itemBuilder:
                          (
                            BuildContext context,
                            int itemIndex,
                            int pageViewIndex,
                          ) => Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                width: 2,
                                color: Colors.blueGrey,
                              ),
                              color: Colors.grey[400],
                            ),
                            child: Image.network(
                              // height: 100,
                              width: MediaQuery.of(context).size.width * 0.8,
                              fit: BoxFit.cover,
                              'https://img.freepik.com/free-vector/gradient-education-background_23-2149436371.jpg?w=2000',
                            ),
                          ),

                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        enlargeFactor: 0.6,
                        aspectRatio: 3.0,
                        onPageChanged:
                            (index, reason) =>
                                setState(() => activeIndex = index),
                        initialPage: 0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  AnimatedSmoothIndicator(
                    activeIndex: activeIndex,

                    count: images.length,
                  ),
                ],
              ),

              SizedBox(height: 10),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20),
              Center(
                child: medium_text_page(textValue: t(context).bottom_home),
              ),
              SizedBox(height: 20),
            ]),
          ),

          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              // Inside the SliverGrid.builder in HomePage's build method

              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SubjectSelectionScreen(),
                        ),
                      );
                    },
                    child: GradeSubjectContainer(
                      containerTitle: "${t(context).exam} ",
                      icon: FontAwesomeIcons.circleQuestion,
                    ),
                  ),
                );
              } else if (index == 1) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const ShortNotesSubjectSelectionScreen(),
                        ),
                      );
                    },
                    child: GradeSubjectContainer(
                      containerTitle: "${t(context).short_note} ",
                      icon: FontAwesomeIcons.bookOpenReader,
                    ),
                  ),
                );
              }
              return null;
            },
            itemCount: 2,
          ),

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
                    big_text_page(text_value: t(context).course)
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
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final grade = grades[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GradeSubjectPage(grade: index + 1),
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
                      Icon(grade['icon'], size: 60, color: grade['color']),
                      const SizedBox(height: 12),
                      Text(
                        grade['label'],
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
            itemCount: grades.length,
          ),
          SliverList(delegate: SliverChildListDelegate([SizedBox(height: 30)])),
        ],
      ),
    );
  }
}
