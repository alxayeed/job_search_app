import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import '../config/api_config.dart';
import '../error/error_interceptor.dart';
import '../services/get_storage_service.dart';
import 'interceptors/quota_interceptor.dart';

class DioService {
  DioService._();

  static final DioService _instance = DioService._();

  Dio? _dio;

  factory DioService() => _instance;

  Dio get dio {
    _dio ??= Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 30000),
      headers: {
        'X-RapidAPI-Key': ApiConfig.apiKey,
      },
    ));

    _dio!.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
      RetryInterceptor(
        dio: _dio!,
        logPrint: print,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
        retryEvaluator: (error, attempt) {
          int statusCode = error.response?.statusCode ?? 0;
          return error.type != DioExceptionType.badResponse || statusCode >= 500;
        },
      ),
      ErrorInterceptor(),
      QuotaInterceptor(storageService: GetStorageService()),
    ]);

    return _dio!;
  }
}
