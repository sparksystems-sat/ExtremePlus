import 'package:dio/dio.dart';
import 'package:exam_practice_app/appApi/config.dart';

class Studentrepository {
  getStudentData() async {
    try {
      Response response = await ApiConfig.dio.get(
        "https://jsonplaceholder.typicode.com/users",
      );
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
