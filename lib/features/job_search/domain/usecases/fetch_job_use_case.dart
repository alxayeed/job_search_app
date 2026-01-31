import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/job_entity.dart';
import '../entities/job_filter_entity.dart';
import '../repositories/job_repository.dart';

class FetchJobsUseCase {
  final JobRepository repository;

  FetchJobsUseCase(this.repository);

  Future<Either<Failure, List<JobEntity>>> call({
    required String query,
    JobFilterEntity? filters,
  }) async {
    return repository.searchJobs(
      query: query,
      remoteJobsOnly: filters?.remoteJobsOnly ?? false,
      employmentType: filters?.employmentType?.apiValue,
      datePosted: filters?.datePosted?.apiValue,
      experience: filters?.jobExperience?.apiValue,
      country: filters?.jobCountry?.apiValue,
      radius: filters?.radius,
    );
  }
}
