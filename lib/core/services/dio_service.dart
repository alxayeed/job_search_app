import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import '../config/api_config.dart';

class DioService {
  // Private constructor
  DioService._();

  // Singleton instance
  static final DioService _instance = DioService._();

  // Factory constructor to return the singleton instance
  factory DioService() => _instance;

  Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 30000),
      headers: {
        'X-RapidAPI-Key': ApiConfig.apiKey,
      },
    ));

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
      RetryInterceptor(
        dio: dio,
        logPrint: print,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ),
    ]);

    return dio;
  }
}
