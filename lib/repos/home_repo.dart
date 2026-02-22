import 'package:dio/dio.dart';
import 'package:exam_practice_app/appApi/config.dart';
import 'package:exam_practice_app/moc_data/grade_list.dart';
import 'package:exam_practice_app/model/home_page_layout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeRepository {
  Future<List<GradeModel>> getHomeData() async {
    try {
      Response response = await ApiConfig.dio.get(
        "https://jsonplaceholder.typicode.com/users",
      );

      return grade_list.map(((e) => GradeModel.fromJson(e))).toList();
    } catch (e) {
      return [];
    }
  }
}
