import 'package:dio/dio.dart';
import 'package:job_search_app/core/config/api_config.dart';
import 'package:job_search_app/core/error/job_failure.dart';

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
    try {
      final response = await dio.getUri(uri);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerFailure('Failed to load jobs: ${response.statusMessage}');
      }
    } catch (e) {
      throw ServerFailure('Failed to load jobs: $e');
    }
  }
}
