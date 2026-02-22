import 'package:dio/dio.dart';
import 'package:exam_practice_app/appApi/config.dart';
import 'package:exam_practice_app/moc_data/exam_repo.dart';
import 'package:exam_practice_app/model/exam_grade.dart';

class SubjectSelectionRepository {
  Future<List<ExamGradeModel>> getSubjectData() async {
    try {
      Response response = await ApiConfig.dio.get(
        "https://jsonplaceholder.typicode.com/users",
      );

      // return (response.data as List<dynamic>)
      //         .map((e) => GradeModel.fromJson(e))
      //         .toList() ??
      //     [];

      return exam_list.map(((e) => ExamGradeModel.fromJson(e))).toList();
    } catch (e) {
      return [];
    }
  }
}
