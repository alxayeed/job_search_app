// lib/features/job_search/domain/usecases/fetch_jobs_use_case.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

/// Use case for fetching jobs based on search criteria.
class FetchJobsUseCase {
  final JobRepository repository;

  /// Creates an instance of [FetchJobsUseCase] with the given [JobRepository].
  ///
  /// [repository] is used for fetching job data.
  FetchJobsUseCase(this.repository);

  /// Fetches jobs based on the search criteria.
  ///
  /// [query] is the search query for job titles or keywords.
  /// [remoteJobsOnly] indicates whether to fetch only remote jobs.
  /// [employmentType] specifies the type of employment (e.g., FULLTIME, PARTTIME).
  /// [datePosted] specifies the date range for job postings.
  ///
  /// Returns an [Either] with a [JobFailure] on failure or a list of [JobEntity] on success.
  Future<Either<Failure, List<JobEntity>>> call({
    required String query,
    bool remoteJobsOnly = false,
    String employmentType = 'FULLTIME',
    String datePosted = 'all',
  }) async {
    return await repository.searchJobs(
      query: query,
      remoteJobsOnly: remoteJobsOnly,
      employmentType: employmentType,
      datePosted: datePosted,
    );
  }
}
