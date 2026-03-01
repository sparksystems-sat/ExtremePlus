import 'package:dio/dio.dart';
import 'package:exam_practice_app/appApi/apis.dart';
import 'package:exam_practice_app/appApi/config.dart';

import 'package:exam_practice_app/model/exam_grade.dart';

class SubjectSelectionRepository {
  Future<List<ExamGradeModel>> getSubjectData() async {
    try {
      Response response = await ApiConfig.dio.post(
        EntranceExamEndpoint.getEntranceExams,
        null,
      );

      List rep_list = response.data['data'] as List;
      print("============== subject data ===============");
      print(rep_list.length);
      print("============== subject data ===============");
      return rep_list.map(((e) => ExamGradeModel.fromJson(e))).toList();
    } catch (e) {
      print("============== subject error ===============");
      print(e.toString());
      print("============== subject error ===============");
      return [];
    }
  }
}
