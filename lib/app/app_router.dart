import 'package:exam_practice_app/app/routes.dart';
import 'package:exam_practice_app/features/history/screens/history_page.dart';
import 'package:exam_practice_app/features/notes/screens/notes_list_page.dart';
import 'package:exam_practice_app/features/random/screens/random_lesson_page.dart';
import 'package:exam_practice_app/features/game/screens/game_page.dart';
import 'package:exam_practice_app/features/timer/screens/timer_page.dart';
import 'package:exam_practice_app/screen/short_notes/grade_selection_short_notes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.notes:
        return MaterialPageRoute(builder: (_) => const NotesListPage());
      case AppRoutes.game:
        return MaterialPageRoute(builder: (_) => const GamePage());
      case AppRoutes.timer:
        return MaterialPageRoute(builder: (_) => const TimerPage());
      case AppRoutes.shortNotes:
        return MaterialPageRoute(
          builder: (_) => const GradeSelectionPageShortNotes(),
        );
      case AppRoutes.random:
        return MaterialPageRoute(builder: (_) => const RandomLessonPage());
      case AppRoutes.history:
        return MaterialPageRoute(builder: (_) => const HistoryPage());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
