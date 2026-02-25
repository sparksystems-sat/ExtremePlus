import 'package:exam_practice_app/appApi/config.dart';

final student_api = 'courses';
final studentEndpoints = {
  'getCourses': '${ApiConfig.baseUrl}${student_api}/list',
  'getCourseDetails': '${ApiConfig.baseUrl}${student_api}/details',
  'enrollCourse': '${ApiConfig.baseUrl}${student_api}/enroll',
};
