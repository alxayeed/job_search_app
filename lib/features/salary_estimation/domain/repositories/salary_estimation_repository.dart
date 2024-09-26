import 'package:dartz/dartz.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/entities.dart';

import '../../../../core/error/failure.dart';

abstract class SalaryEstimationRepository {
  Future<Either<Failure, List<SalaryEstimationEntity>>> getSalaryEstimation({
    required String jobTitle,
    required String location,
    String radius = "100",
  });
}
