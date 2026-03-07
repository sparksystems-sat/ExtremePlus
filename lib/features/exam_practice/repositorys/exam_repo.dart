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

  Future submitExamSingleAnswer(
    String subjectId,
    Map<String, dynamic> answers,
  ) async {
    try {
      Response response = await ApiConfig.dio.post(
        SubmitExamAnswerEndpoint.submit_entrance_exam_single_answer,
        answers,
      );
      debugPrint("============== exam submit answer response ===============");
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
      debugPrint("============== exam submit answer response ===============");
    } catch (e) {
      debugPrint("============== exam submit answer ===============");
      debugPrint(answers.toString());
      debugPrint(e.toString());
      debugPrint("============== exam submit answer ===============");
    }
  }

  Future submitExamBulkAnswer(
    String subjectId,
    Map<String, dynamic> answers,
  ) async {
    try {
      Response response = await ApiConfig.dio.post(
        SubmitExamAnswerEndpoint.bulk_submit_answers,
        answers,
      );
      debugPrint("============== exam submit answer response ===============");
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
      debugPrint("============== exam submit answer response ===============");
    } catch (e) {
      debugPrint("============== exam submit answer ===============");
      debugPrint(answers.toString());
      debugPrint(e.toString());
      debugPrint("============== exam submit answer ===============");
    }
  }

  Future clearAnswer(String subjectId) async {
    try {
      Response response = await ApiConfig.dio.post(
        SubmitExamAnswerEndpoint.clear_answers + subjectId,
        null,
      );
      debugPrint("============== exam submit answer response ===============");
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
      debugPrint("============== exam submit answer response ===============");
    } catch (e) {
      debugPrint("============== exam submit answer ===============");

      debugPrint(e.toString());
      debugPrint("============== exam submit answer ===============");
    }
  }
}
