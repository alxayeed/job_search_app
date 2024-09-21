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
      );

      final data = result['data'] as List<dynamic>?; // Cast to List<dynamic>
      if (data == null) {
        return Left(InputFailure('Data is null or not in the expected format'));
      }

      final List<SalaryEstimationModel> salaryEstimationModels = data
          .map((jobJson) => SalaryEstimationModel.fromJson(jobJson))
          .toList();

      final List<SalaryEstimationEntity> salaryEstimationEntities =
          salaryEstimationModels.map((model) => model.toEntity()).toList();

      return Right(salaryEstimationEntities);
    } catch (e) {
      print('Exception: $e');
      return Left(InputFailure('Error occurred: ${e.toString()}'));
    }
  }
}
