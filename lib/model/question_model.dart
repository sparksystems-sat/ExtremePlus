class QuestionModel {
  final String id;
  final String question;
  final String explanation;
  final List<OptionsModel> options;
  final int year;
  final String entranceexamsubjects_id;
  final String text;
  QuestionModel({
    required this.id,
    required this.question,
    required this.explanation,
    required this.options,
    required this.year,

    required this.entranceexamsubjects_id,
    required this.text,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] == null ? "" : json['id'] as String,
      question: json['question'] == null ? "" : json['question'] as String,
      explanation:
          json['explanation'] == null ? "" : json['explanation'] as String,
      options:
          json['options'] == null
              ? []
              : (json['options'] as List)
                  .map((e) => OptionsModel.fromJson(e))
                  .toList(),
      year: json['year'] == null ? 0 : json['year'] as int,
      entranceexamsubjects_id:
          json['entranceexamsubjects_id'] == null
              ? ""
              : json['entranceexamsubjects_id'] as String,
      text: json['text'] == null ? "" : json['text'] as String,
    );
  }
}

class OptionsModel {
  final String id;
  final String option_label;
  final String option_text;
  final bool is_correct;
  final String exam_question_id;

  OptionsModel({
    required this.id,
    required this.option_label,
    required this.option_text,
    required this.is_correct,
    required this.exam_question_id,
  });

  factory OptionsModel.fromJson(Map<String, dynamic> json) {
    return OptionsModel(
      id: json['id'] == null ? "" : json['id'] as String,
      option_label:
          json['option_label'] == null ? "" : json['option_label'] as String,
      option_text:
          json['option_text'] == null ? "" : json['option_text'] as String,
      is_correct:
          json['is_correct'] == null ? false : json['is_correct'] as bool,
      exam_question_id:
          json['exam_question_id'] == null
              ? ""
              : json['exam_question_id'] as String,
    );
  }
}
