import 'package:exam_practice_app/appApi/dioConfig.dart';

class ApiConfig {
  static String baseUrl = "https://extreme-be.onrender.com/";
  final DioConfig dioConfig = DioConfig();
  static ApiService dio = ApiService(DioConfig().dio);
}
