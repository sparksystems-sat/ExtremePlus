import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:exam_practice_app/appApi/apis.dart';
import 'package:exam_practice_app/appApi/config.dart';
import 'package:exam_practice_app/model/question_model.dart';
import 'package:flutter/foundation.dart';

class ExamRepository {
  Future<List<QuestionModel>> getExamData(String subjectId) async {
    try {
      var formData = {
        "includes": ["questions.options"],
      };
      Response response = await ApiConfig.dio.post(
        "${EntranceExamEndpoint.get_by_id}/$subjectId",
        jsonEncode(formData),
      );
      List dataList = response.data['data']['questions'] as List;
      return dataList.map((e) => QuestionModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("============== exam error ===============");
      debugPrint(e.toString());
      debugPrint("============== exam error ===============");
      return [];
    }
  }

  Future<List<QuestionModel>> submitExamAnswer(String subjectId) async {
    try {
      var formData = {
        "includes": ["questions.options"],
      };
      Response response = await ApiConfig.dio.post(
        "${EntranceExamEndpoint.get_by_id}/$subjectId",
        jsonEncode(formData),
      );
      List dataList = response.data['data']['questions'] as List;
      return dataList.map((e) => QuestionModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("============== exam error ===============");
      debugPrint(e.toString());
      debugPrint("============== exam error ===============");
      return [];
    }
  }
}
