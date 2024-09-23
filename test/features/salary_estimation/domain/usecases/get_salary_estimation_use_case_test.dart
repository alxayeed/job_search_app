import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/core/error/job_failure.dart';
import 'package:job_search_app/features/salary_estimation/domain/usecases/get_salary_estimation_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:job_search_app/features/salary_estimation/domain/repositories/salary_estimation_repository.dart';

import 'get_salary_estimation_use_case_test.mocks.dart';

@GenerateMocks([SalaryEstimationRepository])
void main() {
  late GetSalaryEstimationUseCase useCase;
  late MockSalaryEstimationRepository mockRepository;

  setUp(() {
    mockRepository = MockSalaryEstimationRepository();
    useCase = GetSalaryEstimationUseCase(mockRepository);
  });

  final tSalaryEstimationList = <SalaryEstimationEntity>[
    SalaryEstimationEntity(
      location: 'New York',
      jobTitle: 'Software Engineer',
      publisherName: 'Tech Corp',
      publisherLink: 'https://techcorp.com',
      minimumSalary: 80000,
      maximumSalary: 120000,
      medianSalary: 100000,
      salaryPeriod: 'Yearly',
      salaryCurrency: 'USD',
    ),
  ];

  final tJobTitle = 'Software Engineer';
  final tLocation = 'New York';
  final tRadius = '100';

  group('GetSalaryEstimationUseCase', () {
    test('should return salary estimations when repository call is successful',
        () async {
      // Arrange
      when(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      )).thenAnswer((_) async => Right(tSalaryEstimationList));

      // Act
      final result = await useCase(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(result, Right(tSalaryEstimationList));
      verify(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      ));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when repository call is unsuccessful',
        () async {
      // Arrange
      when(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      )).thenAnswer((_) async => Left(ServerFailure('Server error')));

      // Act
      final result = await useCase(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(
          result,
          Left<JobFailure, List<SalaryEstimationEntity>>(
              ServerFailure('Server error: Server error')));
      verify(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      ));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return InputFailure when job title is invalid', () async {
      // Arrange
      final invalidJobTitle = ''; // Empty job title
      when(mockRepository.getSalaryEstimation(
        jobTitle: invalidJobTitle,
        location: tLocation,
        radius: tRadius,
      )).thenAnswer((_) async => Left(InputFailure('Invalid job title')));

      // Act
      final result = await useCase(
        jobTitle: invalidJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(
          result,
          Left<JobFailure, List<SalaryEstimationEntity>>(
              InputFailure('Input is invalid: Invalid job title')));
      verify(mockRepository.getSalaryEstimation(
        jobTitle: invalidJobTitle,
        location: tLocation,
        radius: tRadius,
      ));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return InputFailure when location is invalid', () async {
      // Arrange
      final invalidLocation = ''; // Empty location
      when(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: invalidLocation,
        radius: tRadius,
      )).thenAnswer((_) async => Left(InputFailure('Invalid location')));

      // Act
      final result = await useCase(
        jobTitle: tJobTitle,
        location: invalidLocation,
        radius: tRadius,
      );

      // Assert
      expect(
          result,
          Left<JobFailure, List<SalaryEstimationEntity>>(
              InputFailure('Input is invalid: Invalid location')));
      verify(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: invalidLocation,
        radius: tRadius,
      ));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return an empty list when there are no salary estimations',
        () async {
      // Arrange
      when(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      )).thenAnswer((_) async => Right(<SalaryEstimationEntity>[]));

      // Act
      final result = await useCase(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(result, isA<Right<JobFailure, List<SalaryEstimationEntity>>>());
      expect(result.fold((l) => null, (r) => r), equals([]));
      verify(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      ));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure for unexpected errors', () async {
      // Arrange
      when(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      )).thenAnswer((_) async => Left(ServerFailure('Unexpected exception')));

      // Act
      final result = await useCase(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(
          result,
          Left<JobFailure, List<SalaryEstimationEntity>>(
              ServerFailure('Server error: Unexpected exception')));
      verify(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      ));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure for unexpected exceptions', () async {
      // Arrange
      when(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      )).thenAnswer((_) async => Left(UnknownFailure(
          'Unexpected exception'))); // Simulate a generic exception

      // Act
      final result = await useCase(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      );

      // Assert
      expect(
          result,
          Left<JobFailure, List<SalaryEstimationEntity>>(
              UnknownFailure('Unexpected error occurred')));
      verify(mockRepository.getSalaryEstimation(
        jobTitle: tJobTitle,
        location: tLocation,
        radius: tRadius,
      ));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
