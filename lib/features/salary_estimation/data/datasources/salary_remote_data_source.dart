import 'package:dio/dio.dart';
import 'package:job_search_app/core/config/api_config.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/get_storage_service.dart';

abstract class SalaryEstimationDatasource {
  Future<Map<String, dynamic>> getSalaryEstimation({
    required String jobTitle,
    required String location,
    String radius,
  });
}

class SalaryEstimationRemoteDatasource implements SalaryEstimationDatasource {
  final Dio dio;

  SalaryEstimationRemoteDatasource(this.dio);

  @override
  Future<Map<String, dynamic>> getSalaryEstimation({
    required String jobTitle,
    required String location,
    String radius = "100",
  }) async {
    final Uri uri = Uri.parse(ApiConfig.salaryEstimation).replace(
      queryParameters: {
        'job_title': jobTitle,
        'location': location,
        'radius': radius,
      },
    );

    final storageService = sl<GetStorageService>();
    final box = storageService.salaryEstimationBox;

    var cachedResponse = box.read("salary_estimation");

    try {
      if (cachedResponse == null) {
        final response = await dio.getUri(uri);

        if (response.statusCode == 200) {
          box.write("salary_estimation", response.data);
          return response.data;
        } else {
          throw ServerFailure(
              'Received non-200 status code: ${response.statusCode}');
        }
      } else {
        await Future.delayed(Duration(seconds: 3));
        return cachedResponse;
      }
    } catch (e) {
      // Handle DioException with a custom failure
      if (e is DioException) {
        // You can inspect the DioException here if needed
        throw ServerFailure('DioException: ${e.message}');
      }
      // Throw a generic failure for any other exceptions
      throw ServerFailure('An unexpected error occurred: $e');
    }
  }
}
