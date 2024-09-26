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
        failure = _handleBadResponse(err, apiMessage);
        break;
      case DioExceptionType.cancel:
        failure = RequestCancelledFailure('Request was cancelled: $apiMessage');
        break;
      case DioExceptionType.unknown:
      default:
        failure = UnknownFailure('An unknown error occurred: ${err.message}');
        break;
    }

    // Reject the error with the mapped failure
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: DioExceptionType.badResponse,
      error: failure,
    ));
  }

  // Helper function to handle specific status codes
  Failure _handleBadResponse(DioException err, String apiMessage) {
    final int? statusCode = err.response?.statusCode;

    if (statusCode == 400) {
      return InputFailure('Bad request: $apiMessage');
    } else if (statusCode == 403) {
      return RateLimitExceededFailure('RateLimitExceeded: $apiMessage');
    } else if (statusCode == 404) {
      return NotFoundFailure('Resource not found: $apiMessage');
    } else if (statusCode == 500) {
      return ServerFailure('Server error: $apiMessage');
    } else if (statusCode == 429) {
      return RateLimitExceededFailure('Too many requests: $apiMessage');
    } else if (statusCode == 401 || statusCode == 403) {
      return ServerFailure('Unauthorized/Forbidden access: $apiMessage');
    } else {
      return ServerFailure(
        'Received invalid status code: $statusCode - $apiMessage',
      );
    }
  }
}
