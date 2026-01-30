import 'package:dio/dio.dart';
import '../../services/get_storage_service.dart';
import '../../config/api_config.dart';

class ApiQuotaInterceptor extends Interceptor {
  final GetStorageService storageService;

  ApiQuotaInterceptor({required this.storageService});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final headers = response.headers;
    final currentKey = ApiConfig.currentKey;

    if (headers['x-ratelimit-requests-limit'] != null &&
        headers['x-ratelimit-requests-remaining'] != null &&
        headers['x-ratelimit-requests-reset'] != null) {

      final limit = int.parse(headers['x-ratelimit-requests-limit']!.first);
      final remaining = int.parse(headers['x-ratelimit-requests-remaining']!.first);
      final resetSeconds = int.parse(headers['x-ratelimit-requests-reset']!.first);
      final now = DateTime.now();

      final box = storageService.jobResultsBox;
      box.write('${currentKey}_quota_limit', limit);
      box.write('${currentKey}_quota_remaining', remaining);
      box.write('${currentKey}_quota_reset_seconds', resetSeconds);
      box.write('${currentKey}_quota_last_checked', now.toIso8601String());
    }

    handler.next(response);
  }
}
