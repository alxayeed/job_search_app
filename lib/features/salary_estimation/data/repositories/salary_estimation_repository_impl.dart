import 'package:dartz/dartz.dart';
import 'package:job_search_app/core/error/job_failure.dart';
import 'package:job_search_app/features/salary_estimation/data/datasources/datasources.dart';
import 'package:job_search_app/features/salary_estimation/data/models/models.dart';
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
    // TODO: implement getSalaryEstimation
    try {
      final Map<String, dynamic> result =
          await remoteDataSource.getSalaryEstimation(
        jobTitle: jobTitle,
        location: location,
      );

      final List<SalaryEstimationModel> salaryEstimationModel = (result['data'] as List)
          .map((jobJson) => SalaryEstimationModel.fromJson(jobJson))
          .toList();

      final List<SalaryEstimationEntity> salaryEstimationEntities =
      salaryEstimationModel.map((model) => model.toEntity()).toList();

      return Right(salaryEstimationEntities);

    } catch (e, stackTrace) {
      print('Exception: $e');
      print('StackTrace: $stackTrace');
      return Left(InputFailure(e.toString()));
    }
  }
}
