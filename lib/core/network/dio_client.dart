import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import '../../features/job_search/presentation/screens/job_details_screen.dart';
import '../config/api_config.dart';
import '../error/error_interceptor.dart';
import '../services/get_storage_service.dart';
import 'interceptors/api_quota_interceptor.dart';

class DioClient {
  DioClient._();

  static final DioClient _instance = DioClient._();

  Dio? _dio;

  factory DioClient() => _instance;

  Dio get dio {
    _dio ??= Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ));

    _dio!.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['X-RapidAPI-Key'] = ApiConfig.currentKey;
          handler.next(options);
        },
      ),
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
      ApiQuotaInterceptor(storageService: sl<GetStorageService>()),
    ]);

    return _dio!;
  }
}
