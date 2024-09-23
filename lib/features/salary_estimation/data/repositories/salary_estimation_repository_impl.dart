import 'package:dartz/dartz.dart';
import 'package:job_search_app/core/error/job_failure.dart';
import 'package:job_search_app/features/salary_estimation/data/datasources/datasources.dart';
import 'package:job_search_app/features/salary_estimation/data/models/salary_estimation_model.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:job_search_app/features/salary_estimation/domain/repositories/repositories.dart';

class SalaryEstimationRepositoryImpl implements SalaryEstimationRepository {
  final SalaryEstimationDatasource remoteDataSource;

  SalaryEstimationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<JobFailure, List<SalaryEstimationEntity>>> getSalaryEstimation({
    required String jobTitle,
    required String location,
    String radius = "100",
  }) async {
    try {
      final Map<String, dynamic> result =
          await remoteDataSource.getSalaryEstimation(
        jobTitle: jobTitle,
        location: location,
        radius: radius, // Ensure to include radius if needed
      );

      final data = result['data'] as List<dynamic>?;
      if (data == null || data.isEmpty) {
        return Left(InputFailure('Data is null or not in the expected format'));
      }

      final List<SalaryEstimationModel> salaryEstimationModels = data
          .map((jobJson) => SalaryEstimationModel.fromJson(jobJson))
          .toList();

      final List<SalaryEstimationEntity> salaryEstimationEntities =
          salaryEstimationModels.map((model) => model.toEntity()).toList();

      return Right(salaryEstimationEntities);
    } catch (e) {
      // Handle specific errors
      if (e is JobFailure) {
        return Left(e); // Propagate specific JobFailure
      }
      // General fallback for unexpected errors
      return Left(
          ServerFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
