import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam_practice_app/bloc/home/home_bloc.dart';
import 'package:exam_practice_app/bloc/home/home_event.dart';
import 'package:exam_practice_app/bloc/home/home_state.dart';
import 'package:exam_practice_app/features/exam_practice/screens/subject_selection_screen.dart';
import 'package:exam_practice_app/features/home/widgets/learning_card.dart';
import 'package:exam_practice_app/features/home/widgets/gamification_card.dart';
import 'package:exam_practice_app/features/short_notes/screens/subject_selection_screen.dart';
import 'package:exam_practice_app/repos/home_repo.dart';
import 'package:exam_practice_app/screen/grade_subject.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/subject_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _activeIndex = 0;

  final List<String> _carouselImages = const [
    'assets/png/carausel.png',
    'assets/png/carausel.png',
    'assets/png/carausel.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.main_background_color,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarousel(),
                  const SizedBox(height: 20),
                  _buildQuickActions(context),
                  const SizedBox(height: 24),
                  _buildStudySection(),
                  const SizedBox(height: 16),
                  _buildGradeGrid(context),
                  const SizedBox(height: 24),
                  _buildLearning(),
                  const SizedBox(height: 24),
                  _buildStatsSection(),
                  const SizedBox(height: 24),
                  _buildGamificationSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _carouselImages.length,
          carouselController: _carouselController,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  _carouselImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 2.2,
            onPageChanged: (index, reason) {
              setState(() => _activeIndex = index);
            },
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: _activeIndex,
          count: _carouselImages.length,
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: const Color(0xFF5B9FED),
            dotColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SubjectCardWidget(
            subjectName: 'Exam',
            svgAssetPath: 'assets/svgs/trophy.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SubjectSelectionScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SubjectCardWidget(
            subjectName: 'Short Note',
            svgAssetPath: 'assets/svgs/shortnote.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ShortNotesSubjectSelectionScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStudySection() {
    return const Text(
      'Study',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  Widget _buildGradeGrid(BuildContext context) {
    const grades = [
      {'label': 'Grade 9', 'grade': 9, 'svg': 'assets/svgs/grade/grade_9.svg'},
      {
        'label': 'Grade 10',
        'grade': 10,
        'svg': 'assets/svgs/grade/grade_10.svg',
      },
      {
        'label': 'Grade 11',
        'grade': 11,
        'svg': 'assets/svgs/grade/grade_11.svg',
      },
      {
        'label': 'Grade 12',
        'grade': 12,
        'svg': 'assets/svgs/grade/grade_12.svg',
      },
    ];

    return BlocProvider(
      create:
          (context) =>
              HomeBloc(RepositoryProvider.of<HomeRepository>(context))
                ..add(HomeInitialEvent()),
      child:  BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.4,
            ),
            itemCount: grades.length,
            itemBuilder: (context, index) {
              final grade = grades[index];
              return SubjectCardWidget(
                subjectName: grade['label'] as String,
                svgAssetPath: grade['svg'] as String,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) =>
                              GradeSubjectPage(grade: (grade['grade'] as int)),
                    ),
                  );
                },
              );
            },
          );




          
        },
      ),
    );
  }

  Widget _buildLearning() {
    return LearningCard(
      title: 'Continue Learning',
      subtitle: 'Keep Going',
      progress: 0.65,
      onContinue: () {},
    );
  }

  Widget _buildStatsSection() {
    return Row(
      children: [
        Expanded(
          child: SubjectCardWidget(
            subjectName: '85%',
            leading: const Text(
              'Accuracy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SubjectCardWidget(
            subjectName: 'Weakest',
            leading: const Text(
              'Physics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildGamificationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gamification Highlights',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GamificationCard(
                icon: 'assets/svgs/shield.svg',
                label: 'Gashas',
                value: '2',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GamificationCard(
                icon: 'assets/svgs/medal.svg',
                label: 'Bitwoded',
                value: '',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GamificationCard(
                icon: 'assets/svgs/gem.svg',
                label: 'Amolie',
                value: '22',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
