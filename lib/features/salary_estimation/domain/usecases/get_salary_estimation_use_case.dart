import 'package:dartz/dartz.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/entities.dart';
import 'package:job_search_app/features/salary_estimation/domain/repositories/repositories.dart';

import '../../../../core/error/failure.dart';

class GetSalaryEstimationUseCase {
  final SalaryEstimationRepository salaryEstimationRepository;

  GetSalaryEstimationUseCase(this.salaryEstimationRepository);

  Future<Either<Failure, List<SalaryEstimationEntity>>> call({
    required String jobTitle,
    required String location,
    String radius = "100",
  }) async {
    final result = await salaryEstimationRepository.getSalaryEstimation(
      jobTitle: jobTitle,
      location: location,
      radius: radius,
    );

    return result.fold(
      (failure) {
        // Map failures to centralized JobFailure types
        if (failure is InputFailure) {
          return Left(InputFailure('Input is invalid: ${failure.message}'));
        } else if (failure is ServerFailure) {
          return Left(ServerFailure('Server error: ${failure.message}'));
        }
        // Handle any unexpected errors
        return Left(UnknownFailure('Unexpected error occurred'));
      },
      (salaryEstimationEntities) => Right(salaryEstimationEntities),
    );
  }
}
