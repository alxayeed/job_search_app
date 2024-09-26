import 'package:dio/dio.dart';
import 'package:job_search_app/core/config/api_config.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/get_storage_service.dart';

abstract class JobRemoteDataSource {
  Future<Map<String, dynamic>> searchJobs({
    required String query,
    bool remoteJobsOnly = false,
    String employmentType = 'FULLTIME',
    String datePosted = 'all',
  });

  Future<Map<String, dynamic>> getJobDetails(String jobId);
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final Dio dio;

  JobRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> searchJobs({
    required String query,
    bool remoteJobsOnly = false,
    String employmentType = 'FULLTIME',
    String datePosted = 'all',
  }) async {
    final Uri uri = Uri.parse(ApiConfig.searchJobs).replace(
      queryParameters: {
        'query': query,
        'num_pages': '1',
        'remote_jobs_only': remoteJobsOnly.toString(),
        'employment_types': employmentType,
        'date_posted': datePosted,
      },
    );

    final storageService = sl<GetStorageService>();
    final box = storageService.jobResultsBox;

    var cachedResponse = box.read("job_results");

    try {
      if (cachedResponse == null) {
        final response = await dio.getUri(uri);
        if (response.statusCode == 200) {
          box.write("job_results", response.data);
          return response.data;
        } else {
          throw ServerFailure('Failed to load jobs');
        }
      } else {
        await Future.delayed(const Duration(seconds: 3));
        return cachedResponse;
      }
    } on DioException catch (e) {
      // Throw a default failure if error is null
      throw e.error ??
          UnknownFailure('Unknown error occurred while fetching jobs');
    } catch (e) {
      throw UnknownFailure('Unexpected error occurred while fetching jobs');
    }
  }

  @override
  Future<Map<String, dynamic>> getJobDetails(String jobId) async {
    final Uri uri = Uri.parse(ApiConfig.getJobDetails).replace(
      queryParameters: {
        'job_id': jobId,
      },
    );

    try {
      final response = await dio.getUri(uri);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerFailure('Failed to load job details');
      }
    } on DioException catch (e) {
      // Throw a default failure if error is null
      throw e.error ??
          UnknownFailure('Unknown error occurred while fetching job details');
    } catch (e) {
      throw UnknownFailure(
          'Unexpected error occurred while fetching job details');
    }
  }
}
