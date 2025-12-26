class QuizQuestion {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class QuizSubject {
  final int id;
  final String name;
  final String description;
  final List<QuizQuestion> questions;

  QuizSubject({
    required this.id,
    required this.name,
    required this.description,
    required this.questions,
  });
}
