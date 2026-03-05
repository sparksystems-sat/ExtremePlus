import 'package:dio/dio.dart';
import 'package:exam_practice_app/appApi/apis.dart';
import 'package:exam_practice_app/appApi/config.dart';

import 'package:exam_practice_app/model/exam_grade.dart';

class SubjectSelectionRepository {
  Future<List<ExamGradeModel>> getSubjectData() async {
    try {
      Response response = await ApiConfig.dio.post(
        EntranceExamEndpoint.get_entrance_exams,
        null,
      );
      List rep_list = response.data['data'] as List;
      return rep_list.map(((e) => ExamGradeModel.fromJson(e))).toList();
    } catch (e) {
      print("============== subject Seelction error ===============");
      print(e.toString());
      print("============== subject Selection error ===============");
      return [];
    }
  }
}
