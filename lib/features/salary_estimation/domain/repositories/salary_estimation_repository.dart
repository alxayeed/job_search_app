import 'package:dartz/dartz.dart';
import 'package:job_search_app/core/error/job_failure.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/entities.dart';

abstract class SalaryEstimationRepository {
  Future<Either<JobFailure, List<SalaryEstimationEntity>>> getSalaryEstimation({
    required String jobTitle,
    required String location,
    String radius = "100",
  });
}
