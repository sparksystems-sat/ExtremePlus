class CourseApi {
  static const String rr = 'https://api.example.com/courses';
}

final studentEndpoints = {
  'getCourses': '${CourseApi.rr}/list',
  'getCourseDetails': '${CourseApi.rr}/details',
  'enrollCourse': '${CourseApi.rr}/enroll',
};
