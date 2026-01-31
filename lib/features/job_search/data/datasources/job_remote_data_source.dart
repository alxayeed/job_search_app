import 'package:dio/dio.dart';
import 'package:job_search_app/core/config/api_config.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/get_storage_service.dart';

abstract class JobRemoteDataSource {
  Future<Map<String, dynamic>> searchJobs({
    required String query,
    bool remoteJobsOnly = false,
    String? employmentType,
    String? datePosted,
    String? experience,
    String? country,
    double? radius,
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
    String? employmentType,
    String? datePosted,
    String? experience,
    String? country,
    double? radius,
  }) async {
    final params = <String, dynamic>{
      'query': query,
      'num_pages': 1,
    };

    if (remoteJobsOnly) params['remote_jobs_only'] = true;
    if (employmentType != null) params['employment_types'] = employmentType;
    if (datePosted != null) params['date_posted'] = datePosted;
    if (experience != null) params['experience'] = experience;
    if (country != null) params['country'] = country;
    if (radius != null) params['radius'] = radius.toString();

    final storageService = sl<GetStorageService>();
    final box = storageService.jobResultsBox;
    final cachedResponse = box.read('job_results');

    try {
      final response = await dio.get(
        ApiConfig.searchJobs,
        queryParameters: params,
      );

      if (response.statusCode == 200) {
        box.write('job_results', response.data);
        return response.data;
      } else {
        throw ServerFailure('Failed to load jobs');
      }
    } on DioException catch (e) {
      throw e.error is Failure
          ? e.error!
          : UnknownFailure('Unexpected error occurred while fetching jobs');
    } catch (_) {
      throw UnknownFailure('Unexpected error occurred while fetching jobs');
    } finally {
      if (cachedResponse != null) return cachedResponse;
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
      print(e);
      throw e.error ??
          UnknownFailure('Unknown error occurred while fetching job details');
    } catch (e) {
      throw UnknownFailure(
          'Unexpected error occurred while fetching job details');
    }
  }
}
