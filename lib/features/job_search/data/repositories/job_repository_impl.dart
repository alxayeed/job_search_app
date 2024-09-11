import 'package:dartz/dartz.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_entity.dart';
import 'package:job_search_app/features/job_search/data/models/job_model.dart';
import 'package:job_search_app/features/job_search/domain/repositories/job_repository.dart';
import 'package:job_search_app/core/error/job_failure.dart';

import '../datasources/job_remote_data_source.dart';

/// Implementation of the [JobRepository] that handles the interaction with the remote data source.
class JobRepositoryImpl implements JobRepository {
  final JobDataSource remoteDataSource;

  /// Creates an instance of [JobRepositoryImpl] with the given [JobDataSource].
  ///
  /// [remoteDataSource] is the data source used for making HTTP requests.
  JobRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<JobFailure, List<JobEntity>>> searchJobs({
    required String query,
    bool remoteJobsOnly = false,
    String employmentType = 'FULLTIME',
    String datePosted = 'all',
  }) async {
    try {
      // Call the remote data source to fetch the job search results.
      final Map<String, dynamic> result = await remoteDataSource.searchJobs(
        query: query,
        remoteJobsOnly: remoteJobsOnly,
        employmentType: employmentType,
        datePosted: datePosted,
      );

      // Convert the JSON response into a list of [JobModel] objects.
      final List<JobModel> jobModels = (result['data'] as List)
          .map((jobJson) => JobModel.fromJson(jobJson))
          .toList();

      // Convert the list of [JobModel] to a list of [JobEntity].
      final List<JobEntity> jobEntities =
          jobModels.map((model) => model.toEntity()).toList();

      return Right(jobEntities);
    } catch (e) {
      // Handle any errors that occur and return a [ServerFailure].
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<JobFailure, JobEntity>> getJobDetails(String jobId) async {
    try {
      // Call the remote data source to fetch job details.
      final Map<String, dynamic> result =
          await remoteDataSource.getJobDetails(jobId);

      // Convert the JSON response into a [JobModel] object.
      final JobModel jobModel = JobModel.fromJson(result['data']);

      // Convert the [JobModel] to a [JobEntity].
      final JobEntity jobEntity = jobModel.toEntity();

      return Right(jobEntity);
    } catch (e) {
      // Handle any errors that occur and return a [ServerFailure].
      return Left(ServerFailure(e.toString()));
    }
  }
}
