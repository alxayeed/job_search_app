import 'package:dartz/dartz.dart';
import 'package:job_search_app/features/salary_estimation/data/datasources/datasources.dart';
import 'package:job_search_app/features/salary_estimation/data/models/salary_estimation_model.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:job_search_app/features/salary_estimation/domain/repositories/repositories.dart';

import '../../../../core/error/failure.dart';

class SalaryEstimationRepositoryImpl implements SalaryEstimationRepository {
  final SalaryEstimationDatasource remoteDataSource;

  SalaryEstimationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<SalaryEstimationEntity>>> getSalaryEstimation({
    required String jobTitle,
    required String location,
    String radius = "100",
  }) async {
    try {
      final Map<String, dynamic> result =
          await remoteDataSource.getSalaryEstimation(
        jobTitle: jobTitle,
        location: location,
        radius: radius,
      );

      final data = result['data'] as List<dynamic>?;
      if (data == null || data.isEmpty) {
        return Left(InputFailure('Data is null or not in the expected format'));
      }

      // Validate required fields
      for (var jobJson in data) {
        if (!jobJson.containsKey('publisher_name') ||
            !jobJson.containsKey('min_salary') ||
            !jobJson.containsKey('max_salary') ||
            !jobJson.containsKey('median_salary')) {
          return Left(InputFailure('Data does not contain required fields'));
        }
      }

      final List<SalaryEstimationModel> salaryEstimationModels = data
          .map((jobJson) => SalaryEstimationModel.fromJson(jobJson))
          .toList();

      final List<SalaryEstimationEntity> salaryEstimationEntities =
          salaryEstimationModels.map((model) => model.toEntity()).toList();

      return Right(salaryEstimationEntities);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(
          ServerFailure('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
