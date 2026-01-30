import 'package:dio/dio.dart';

import '../../services/get_storage_service.dart';

class QuotaInterceptor extends Interceptor {
  final GetStorageService storageService;

  QuotaInterceptor({required this.storageService});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final headers = response.headers;

    if (headers['x-ratelimit-requests-limit'] != null &&
        headers['x-ratelimit-requests-remaining'] != null &&
        headers['x-ratelimit-requests-reset'] != null) {

      final limit = int.parse(headers['x-ratelimit-requests-limit']!.first);
      final remaining = int.parse(headers['x-ratelimit-requests-remaining']!.first);
      final resetSeconds = int.parse(headers['x-ratelimit-requests-reset']!.first);
      final resetTime = DateTime.now().add(Duration(seconds: resetSeconds));

      // Save to jobResultsBox
      final box = storageService.jobResultsBox;
      box.write('quota_limit', limit);
      box.write('quota_remaining', remaining);
      box.write('quota_reset_time', resetTime.toIso8601String());
    }

    handler.next(response); // continue with response
  }
}
