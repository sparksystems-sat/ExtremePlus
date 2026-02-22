import 'package:exam_practice_app/appApi/dioConfig.dart';

class ApiConfig {
  static String baseUrl = "http://sparksystems.com/";
  final DioConfig dioConfig = DioConfig();
  static ApiService dio = ApiService(DioConfig().dio);
}
