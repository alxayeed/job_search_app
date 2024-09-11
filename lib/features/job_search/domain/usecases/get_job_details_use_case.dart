// lib/features/job_search/domain/usecases/get_job_details_use_case.dart

import 'package:dartz/dartz.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';
import '../../../../core/error/job_failure.dart';

/// Use case for fetching details of a specific job.
class GetJobDetailsUseCase {
  final JobRepository repository;

  /// Creates an instance of [GetJobDetailsUseCase] with the given [JobRepository].
  ///
  /// [repository] is used for fetching job details.
  GetJobDetailsUseCase(this.repository);

  /// Fetches details of a job based on the [jobId].
  ///
  /// [jobId] is the unique identifier of the job.
  ///
  /// Returns an [Either] with a [JobFailure] on failure or a [JobEntity] on success.
  Future<Either<JobFailure, JobEntity>> call(String jobId) async {
    return await repository.getJobDetails(jobId);
  }
}
