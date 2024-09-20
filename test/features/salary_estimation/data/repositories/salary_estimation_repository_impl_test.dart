import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:job_search_app/core/error/job_failure.dart';
import 'package:job_search_app/features/salary_estimation/data/repositories/salary_estimation_repository_impl.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:job_search_app/features/salary_estimation/data/datasources/datasources.dart';

import 'salary_estimation_repository_impl_test.mocks.dart';

@GenerateMocks([SalaryEstimationDatasource])
void main() {
  late SalaryEstimationRepositoryImpl repository;
  late MockSalaryEstimationDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockSalaryEstimationDatasource();
    repository =
        SalaryEstimationRepositoryImpl(remoteDataSource: mockDatasource);
  });

  // Test data for successful case
  final mockSalaryData = [
    {
      "location": "New York",
      "job_title": "Software Engineer",
      "publisher_name": "Tech Corp",
      "publisher_link": "https://techcorp.com",
      "min_salary": 80000.0,
      "max_salary": 120000.0,
      "median_salary": 100000.0,
      "salary_period": "Yearly",
      "salary_currency": "USD",
    },
  ];

  group('getSalaryEstimation', () {
    const tJobTitle = 'Software Engineer';
    const tLocation = 'New York';
    const tRadius = '100';

    test('should return salary estimations when remote call is successful',
        () async {
      // Arrange
      when(mockDatasource.getSalaryEstimation(
              jobTitle: tJobTitle, location: tLocation))
          .thenAnswer((_) async => {'data': mockSalaryData});

      // Act
      final result = await repository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(result, isA<Right<JobFailure, List<SalaryEstimationEntity>>>());
      verify(mockDatasource.getSalaryEstimation(
          jobTitle: tJobTitle, location: tLocation));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('should return ServerFailure when remote call throws an exception',
        () async {
      // Arrange
      when(mockDatasource.getSalaryEstimation(
              jobTitle: tJobTitle, location: tLocation))
          .thenThrow(ServerFailure('Server error'));

      // Act
      final result = await repository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(result, isA<Left<JobFailure, List<SalaryEstimationEntity>>>());
      expect(result.fold((l) => l, (r) => null), isA<InputFailure>());
      verify(mockDatasource.getSalaryEstimation(
          jobTitle: tJobTitle, location: tLocation));
      verifyNoMoreInteractions(mockDatasource);
    });

    test('should return InputFailure if the data structure is unexpected',
        () async {
      // Arrange
      final wrongDataJson = {
        'invalid_key': [
          {
            "location": "New York",
            "job_title": "Software Engineer",
            // Missing required fields like 'publisher_name'
          },
        ],
      };

      when(mockDatasource.getSalaryEstimation(
              jobTitle: tJobTitle, location: tLocation))
          .thenAnswer((_) async => wrongDataJson);

      // Act
      final result = await repository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(result.isLeft(), true);
      expect(result, isA<Left<JobFailure, List<SalaryEstimationEntity>>>());
      verify(mockDatasource.getSalaryEstimation(
          jobTitle: tJobTitle, location: tLocation));
    });
  });
}
