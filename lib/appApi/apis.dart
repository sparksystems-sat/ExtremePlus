import 'package:exam_practice_app/appApi/config.dart';

final student_api = 'Students';
final subject_api = 'Subjects';
final grade_api = 'Grades';
final chapter_api = 'Chapters';
final entranc_exam_api = 'EntranceExamSubjectss';

class StudentEndpoint {
  static final String getCourses = '${ApiConfig.baseUrl}${student_api}/get_all';
  static final String getCourseDetails =
      '${ApiConfig.baseUrl}${student_api}/details';
  static final String enrollCourse =
      '${ApiConfig.baseUrl}${student_api}/enroll';
}

class SubjectEndpoint {
  static final String getSubjects =
      '${ApiConfig.baseUrl}${subject_api}/get_all';
  static final String getSubjectDetails =
      '${ApiConfig.baseUrl}${subject_api}/details';
}

class GradeEndpoint {
  static final String getGrades = '${ApiConfig.baseUrl}${grade_api}/get_all';
  static final String getGradeDetails =
      '${ApiConfig.baseUrl}${grade_api}/details';
}

class ChapterEndpoint {
  static final String getChapters =
      '${ApiConfig.baseUrl}${chapter_api}/get_all';
  static final String getChapterDetails =
      '${ApiConfig.baseUrl}${chapter_api}/details';
}

class EntranceExamEndpoint {
  static final String getEntranceExams =
      '${ApiConfig.baseUrl}${entranc_exam_api}/get_all';
  static final String get_by_id =
      '${ApiConfig.baseUrl}${entranc_exam_api}/get_by_id';
}
