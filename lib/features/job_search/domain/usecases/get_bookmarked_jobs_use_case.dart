import 'package:dartz/dartz.dart';
import 'package:job_search_app/core/error/job_failure.dart';
import 'package:job_search_app/features/job_search/domain/entities/entities.dart';
import 'package:job_search_app/features/job_search/domain/repositories/job_repository.dart';

class GetBookmarkedJobsUseCase{
  final JobRepository jobRepository;
  GetBookmarkedJobsUseCase(this.jobRepository);

  Future<Either<JobFailure, List<JobEntity>>> call() async {
    return await jobRepository.getAllBookmarkedJobs();
  }
}