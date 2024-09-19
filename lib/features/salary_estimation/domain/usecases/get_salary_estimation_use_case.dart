import 'package:dartz/dartz.dart';
import 'package:job_search_app/core/error/job_failure.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/entities.dart';
import 'package:job_search_app/features/salary_estimation/domain/repositories/repositories.dart';

class GetSalaryEstimationUseCase {
  final SalaryEstimationRepository salaryEstimationRepository;

  GetSalaryEstimationUseCase(this.salaryEstimationRepository);

  Future<Either<JobFailure, List<SalaryEstimationEntity>>> call({
    required String jobTitle,
    required String location,
    String radius = "100",
  }) async {
    return await salaryEstimationRepository.getSalaryEstimation(
      jobTitle: jobTitle,
      location: location,
      radius: radius,
    );
  }
}
