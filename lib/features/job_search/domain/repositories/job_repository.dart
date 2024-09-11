import 'package:dartz/dartz.dart';

import '../../../../core/error/job_failure.dart';
import '../entities/job_entity.dart';

/// Manages job search operations.
abstract class JobRepository {
  /// Searches for jobs based on the query and filters.
  ///
  /// [query] - The search query to find jobs.
  /// [remoteJobsOnly] - If true, only remote jobs are returned.
  /// [employmentType] - Type of employment to filter by (e.g., 'FULLTIME').
  /// [datePosted] - Date range for job postings.
  ///
  /// Returns an [Either] where:
  /// - Left: [JobFailure] if there was an error.
  /// - Right: List of [JobEntity] matching the criteria.
  Future<Either<JobFailure, List<JobEntity>>> searchJobs({
    required String query,
    bool remoteJobsOnly = false,
    String employmentType = 'FULLTIME',
    String datePosted = 'all',
  });

  /// Retrieves job details for a specific job ID.
  ///
  /// [jobId] - Unique identifier for the job.
  ///
  /// Returns an [Either] where:
  /// - Left: [JobFailure] if there was an error.
  /// - Right: [JobEntity] with job details.
  Future<Either<JobFailure, JobEntity>> getJobDetails(String jobId);
}
