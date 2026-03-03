import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:exam_practice_app/appApi/config.dart';
import 'package:exam_practice_app/model/question_model.dart';
import 'package:flutter/foundation.dart';

class MoreRepository {
  Future<List<QuestionModel>> getMoreData(String subjectId) async {
    try {
      var formData = {
        "includes": ["questions.options"],
      };

      Response response = await ApiConfig.dio.post("", jsonEncode(formData));
      List dataList = response.data['data']['questions'] as List;
      return dataList.map((e) => QuestionModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("============== More error ===============");
      debugPrint(e.toString());
      debugPrint("============== More error ===============");
      return [];
    }
  }

  Future<List<QuestionModel>> submitMoreAnswer(String subjectId) async {
    try {
      var formData = {
        "includes": ["questions.options"],
      };

      Response response = await ApiConfig.dio.post("", jsonEncode(formData));
      List dataList = response.data['data']['questions'] as List;
      return dataList.map((e) => QuestionModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("============== More error ===============");
      debugPrint(e.toString());
      debugPrint("============== More error ===============");
      return [];
    }
  }
}
