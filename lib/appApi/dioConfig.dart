import 'package:dio/dio.dart';
import 'package:exam_practice_app/appApi/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioConfig {
  final Dio _dio;
  DioConfig()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl, // Replace with your API base URL
          connectTimeout: const Duration(seconds: 60 * 1000),
          receiveTimeout: const Duration(seconds: 60 * 1000),
          receiveDataWhenStatusError: true,
          contentType: Headers.jsonContentType, // This is application/json
          responseType: ResponseType.json,
          // headers: {
          //   'Accept': 'application/json',
          //   'Content-Type': 'multipart/form-data',
          // },
        ),
      ) {
    // _setupInterceptors();
  }
  Dio get dio => _dio;
  Future<void> _setupInterceptors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers['Authorization'] =
              "Bearer ${prefs.getString("loginInfo")}";
          return handler.next(options);
        },
        onResponse: (response, handler) {
          prefs.setInt("currentPage", 0);
          if (response.statusCode == 401) {}

          return handler.next(response); // Continue with the response
        },
        onError: (DioException error, handler) async {
          await _retryRequest(error, handler);
        },
      ),
    );
  }

  Future<void> _retryRequest(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    const int maxRetries = 3; // Maximum number of retries
    int retryCount = 0;

    while (retryCount < maxRetries) {
      retryCount++;
      // print('Retrying request... Attempt: $retryCount');
      // Create a new request based on the original request
      final options = error.response?.requestOptions;
      if (options != null) {
        try {
          final response = await _dio.fetch(options);
          return handler.resolve(
            response,
          ); // If successful, resolve the response
        } catch (e) {
          // If it fails again, continue to retry
          print('Retry Failed: $e');
        }
      }
    }
    // If all retries failed, call the error handler
    return handler.next(error);
  }

  void _handleError(DioException error) {
    String errorMessage;
    switch (error.type) {
      case DioExceptionType.cancel:
        errorMessage = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        errorMessage =
            "Received invalid status code: ${error.response?.statusCode}";
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Send timeout in connection with API server";
        break;
      default:
        errorMessage = "Unexpected error occurred";
        break;
    }
    print('Error: $errorMessage');
  }
}

class ApiService {
  final Dio _dio;
  ApiService(Dio dio) : _dio = dio;
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, dynamic body) async {
    return await _dio.post(path, data: body);
  }

  // Future<Response> postOptions(String path, dynamic data) async {
  //   return await _dio.post(
  //     path,
  //     data: data,
  //     options: Options(headers: {'Content-Type': 'application/json'}),
  //   );
  // }

  Future<Response> createAccountOptions(String path, dynamic data) async {
    return await _dio.post(
      path,
      data: data,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  Future<Response> postWithParameters(
    String path,
    dynamic data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
  }

  Future<Response> put(String path, dynamic data) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.delete(path, queryParameters: queryParameters);
  }
}
