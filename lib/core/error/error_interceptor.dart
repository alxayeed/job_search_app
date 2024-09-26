import 'package:dio/dio.dart';
import 'failure.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Failure failure;

    String apiMessage = err.response?.data['message'] ?? 'An error occurred';

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        failure = TimeoutFailure('Connection timed out: $apiMessage');
        break;
      case DioExceptionType.sendTimeout:
        failure = TimeoutFailure('Request send timed out: $apiMessage');
        break;
      case DioExceptionType.receiveTimeout:
        failure = TimeoutFailure('Response timed out: $apiMessage');
        break;
      case DioExceptionType.badResponse:
        // Handle different response statuses
        if (err.response?.statusCode == 400) {
          failure = NotFoundFailure('ERROR: $apiMessage');
        } else if (err.response?.statusCode == 404) {
          failure = NotFoundFailure('Resource not found: $apiMessage');
        } else if (err.response?.statusCode == 500) {
          failure = ServerFailure('Server error: $apiMessage');
        } else if (err.response?.statusCode == 429) {
          failure = RateLimitExceededFailure('Too many requests: $apiMessage');
        } else {
          failure = ServerFailure(
              'Received invalid status code: ${err.response?.statusCode} - $apiMessage');
        }
        break;
      case DioExceptionType.cancel:
        failure = RequestCancelledFailure('Request was cancelled: $apiMessage');
        break;
      case DioExceptionType.unknown:
      default:
        failure = UnknownFailure('An unknown error occurred: ${err.message}');
        break;
    }

    handler.reject(DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: DioExceptionType.badResponse,
      error: failure,
    ));
  }
}
