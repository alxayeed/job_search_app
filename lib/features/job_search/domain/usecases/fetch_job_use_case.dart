import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/job_entity.dart';
import '../enums/employment_type.dart';
import '../enums/date_posted.dart';
import '../enums/job_experience.dart';
import '../enums/job_country.dart';
import '../repositories/job_repository.dart';

class FetchJobsUseCase {
  final JobRepository repository;

  FetchJobsUseCase(this.repository);

  Future<Either<Failure, List<JobEntity>>> call({
    required String query,
    bool remoteJobsOnly = false,
    EmploymentType? employmentType,
    DatePosted? datePosted,
    JobExperience? experience,
    JobCountry? country,
  }) async {
    return await repository.searchJobs(
      query: query,
      remoteJobsOnly: remoteJobsOnly,
      employmentType: employmentType!.apiValue,
      datePosted: datePosted!.apiValue,
      experience: experience?.apiValue,
      country: country?.apiValue,
    );
  }
}
