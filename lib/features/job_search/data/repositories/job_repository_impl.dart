import 'package:dartz/dartz.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_entity.dart';
import 'package:job_search_app/features/job_search/data/models/job_model.dart';
import 'package:job_search_app/features/job_search/domain/repositories/job_repository.dart';

import '../../../../core/error/failure.dart';
import '../datasources/job_local_data_source.dart';
import '../datasources/job_remote_data_source.dart';

/// Implementation of the [JobRepository] that handles the interaction with the remote data source.
class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource remoteDataSource;
  final JobLocalDataSource localDataSource;

  /// Creates an instance of [JobRepositoryImpl] with the given [JobDataSource].
  ///
  /// [remoteDataSource] is the data source used for making HTTP requests.
  JobRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<JobEntity>>> searchJobs({
    required String query,
    bool remoteJobsOnly = false,
    String employmentType = 'FULLTIME',
    String datePosted = 'all',
  }) async {
    try {
      final Map<String, dynamic> result = await remoteDataSource.searchJobs(
        query: query,
        remoteJobsOnly: remoteJobsOnly,
        employmentType: employmentType,
        datePosted: datePosted,
      );

      final List<JobModel> jobModels = (result['data'] as List)
          .map((jobJson) => JobModel.fromJson(jobJson))
          .toList();

      final List<JobEntity> jobEntities =
          jobModels.map((model) => model.toEntity()).toList();

      return Right(jobEntities);
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('StackTrace: $stackTrace');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> getJobDetails(String jobId) async {
    try {
      JobModel? cachedJob = await localDataSource.getCachedJob(jobId);

      if (cachedJob != null) {
        JobEntity cachedJobEntity = cachedJob.toEntity();
        return Right(cachedJobEntity);
      }

      final Map<String, dynamic> result =
          await remoteDataSource.getJobDetails(jobId);
      final JobModel jobModel = JobModel.fromJson(result['data'][0]);
      final JobEntity jobEntity = jobModel.toEntity();

      return Right(jobEntity);
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('StackTrace: $stackTrace');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> bookmarkJob(JobEntity job) async {
    try {
      JobEntity updatedEntity = job.copyWith(isBookmarked: true);
      JobModel jobModel = updatedEntity.toModel();
      await localDataSource.addToBookmark(jobModel);

      return Right(updatedEntity);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobEntity>> removeJobFromBookmark(
      JobEntity job) async {
    try {
      JobEntity updatedEntity = job.copyWith(isBookmarked: false);
      JobModel jobModel = updatedEntity.toModel();
      await localDataSource.removeFromBookmark(jobModel);

      return Right(updatedEntity);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<JobEntity>>> getAllBookmarkedJobs() async {
    try {
      final List<JobEntity> jobEntities =
          await localDataSource.getAllBookmarkedJobs();

      // final List<JobModel> jobModels = (result['data'] as List)
      //     .map((jobJson) => JobModel.fromJson(jobJson))
      //     .toList();
      //
      // final List<JobEntity> jobEntities =
      // jobModels.map((model) => model.toEntity()).toList();

      return Right(jobEntities);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
