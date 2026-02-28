import 'package:dio/dio.dart';
import 'package:exam_practice_app/appApi/apis.dart';
import 'package:exam_practice_app/appApi/config.dart';
import 'package:exam_practice_app/moc_data/exam_repo.dart';
import 'package:exam_practice_app/model/exam_grade.dart';

class SubjectSelectionRepository {
  Future<List<ExamGradeModel>> getSubjectData() async {
    try {
      Response response = await ApiConfig.dio.get(SubjectEndpoint.getSubjects);
      print("============== subject data ===============");
      print(response.data);
      print("============== subject data ===============");
 

      return exam_list.map(((e) => ExamGradeModel.fromJson(e))).toList();
    } catch (e) {
      print("============== subject error ===============");
      print(e.toString());
      print("============== subject error ===============");
      return [];
    }
  }
}
