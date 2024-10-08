import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/core/error/failure.dart';
import 'package:job_search_app/features/salary_estimation/domain/usecases/get_salary_estimation_use_case.dart';
import 'package:job_search_app/features/salary_estimation/presentation/bloc/bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:job_search_app/features/salary_estimation/presentation/bloc/salary_estimation_bloc.dart';

import 'salary_estimation_bloc_test.mocks.dart';

@GenerateMocks([GetSalaryEstimationUseCase])
void main() {
  late SalaryEstimationBloc bloc;
  late MockGetSalaryEstimationUseCase mockGetSalaryEstimationUseCase;

  setUp(() {
    mockGetSalaryEstimationUseCase = MockGetSalaryEstimationUseCase();
    bloc = SalaryEstimationBloc(
        getSalaryEstimationUseCase: mockGetSalaryEstimationUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is SalaryEstimationInitial', () {
    expect(bloc.state, SalaryEstimationInitial());
  });

  blocTest<SalaryEstimationBloc, SalaryEstimationState>(
    'emits [SalaryEstimationLoading, SalaryEstimationLoaded] when GetSalaryEstimationsEvent is added and succeeds',
    build: () {
      when(mockGetSalaryEstimationUseCase(
        jobTitle: anyNamed('jobTitle'),
        location: anyNamed('location'),
        radius: anyNamed('radius'),
      )).thenAnswer(
        (_) async => Right([
          SalaryEstimationEntity(
            location: 'New York',
            jobTitle: 'Developer',
            publisherName: 'Publisher',
            publisherLink: 'http://publisher.com',
            minimumSalary: 40000,
            maximumSalary: 60000,
            medianSalary: 50000,
            salaryPeriod: 'Yearly',
            salaryCurrency: 'USD',
          )
        ]),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(
        GetSalaryEstimationsEvent(jobTitle: 'Developer', location: 'New York')),
    expect: () => [
      SalaryEstimationLoading(),
      SalaryEstimationLoaded([
        SalaryEstimationEntity(
          location: 'New York',
          jobTitle: 'Developer',
          publisherName: 'Publisher',
          publisherLink: 'http://publisher.com',
          minimumSalary: 40000,
          maximumSalary: 60000,
          medianSalary: 50000,
          salaryPeriod: 'Yearly',
          salaryCurrency: 'USD',
        )
      ]),
    ],
    verify: (_) {
      verify(mockGetSalaryEstimationUseCase(
        jobTitle: 'Developer',
        location: 'New York',
        radius: '100',
      )).called(1);
    },
  );

  blocTest<SalaryEstimationBloc, SalaryEstimationState>(
    'emits [SalaryEstimationLoading, SalaryEstimationError] when GetSalaryEstimationsEvent is added and fails',
    build: () {
      when(mockGetSalaryEstimationUseCase(
        jobTitle: anyNamed('jobTitle'),
        location: anyNamed('location'),
        radius: anyNamed('radius'),
      )).thenAnswer(
        (_) async =>
            Left(NetworkFailure("Please check your internet connection")),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(
        GetSalaryEstimationsEvent(jobTitle: 'Developer', location: 'New York')),
    expect: () => [
      SalaryEstimationLoading(),
      SalaryEstimationError(
          message: 'Network failure. Please check your connection.'),
    ],
    verify: (_) {
      verify(mockGetSalaryEstimationUseCase(
        jobTitle: 'Developer',
        location: 'New York',
        radius: '100',
      )).called(1);
    },
  );

  blocTest<SalaryEstimationBloc, SalaryEstimationState>(
    'emits [SalaryEstimationInitial] when ResetSalaryEstimationsEvent is added',
    build: () => bloc,
    act: (bloc) => bloc.add(ResetSalaryEstimationsEvent()),
    expect: () => [SalaryEstimationInitial()],
  );

  // Additional Test Cases
  blocTest<SalaryEstimationBloc, SalaryEstimationState>(
    'emits [SalaryEstimationLoading, SalaryEstimationLoaded] with empty list when GetSalaryEstimationsEvent is added and returns empty list',
    build: () {
      when(mockGetSalaryEstimationUseCase(
        jobTitle: anyNamed('jobTitle'),
        location: anyNamed('location'),
        radius: anyNamed('radius'),
      )).thenAnswer(
        (_) async => Right([]),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(
        GetSalaryEstimationsEvent(jobTitle: 'Developer', location: 'New York')),
    expect: () => [
      SalaryEstimationLoading(),
      SalaryEstimationEmpty(),
    ],
    verify: (_) {
      verify(mockGetSalaryEstimationUseCase(
        jobTitle: 'Developer',
        location: 'New York',
        radius: '100',
      )).called(1);
    },
  );

  blocTest<SalaryEstimationBloc, SalaryEstimationState>(
    'emits [SalaryEstimationLoading, SalaryEstimationError] when GetSalaryEstimationsEvent is added with invalid job title or location',
    build: () {
      when(mockGetSalaryEstimationUseCase(
        jobTitle: anyNamed('jobTitle'),
        location: anyNamed('location'),
        radius: anyNamed('radius'),
      )).thenAnswer(
        (_) async => Left(InputFailure("Invalid job title or location")),
      );
      return bloc;
    },
    act: (bloc) =>
        bloc.add(GetSalaryEstimationsEvent(jobTitle: '', location: '')),
    expect: () => [
      SalaryEstimationLoading(),
      SalaryEstimationError(message: 'Invalid job title or location'),
    ],
    verify: (_) {
      verify(mockGetSalaryEstimationUseCase(
        jobTitle: '',
        location: '',
        radius: '100',
      )).called(1);
    },
  );

  blocTest<SalaryEstimationBloc, SalaryEstimationState>(
    'emits [SalaryEstimationLoading, SalaryEstimationLoaded] when GetSalaryEstimationsEvent is added with different radius values',
    build: () {
      when(mockGetSalaryEstimationUseCase(
        jobTitle: anyNamed('jobTitle'),
        location: anyNamed('location'),
        radius: anyNamed('radius'),
      )).thenAnswer(
        (_) async => Right([
          SalaryEstimationEntity(
            location: 'New York',
            jobTitle: 'Developer',
            publisherName: 'Publisher',
            publisherLink: 'http://publisher.com',
            minimumSalary: 40000,
            maximumSalary: 60000,
            medianSalary: 50000,
            salaryPeriod: 'Yearly',
            salaryCurrency: 'USD',
          )
        ]),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetSalaryEstimationsEvent(
        jobTitle: 'Developer', location: 'New York', radius: '50')),
    expect: () => [
      SalaryEstimationLoading(),
      SalaryEstimationLoaded([
        SalaryEstimationEntity(
          location: 'New York',
          jobTitle: 'Developer',
          publisherName: 'Publisher',
          publisherLink: 'http://publisher.com',
          minimumSalary: 40000,
          maximumSalary: 60000,
          medianSalary: 50000,
          salaryPeriod: 'Yearly',
          salaryCurrency: 'USD',
        )
      ]),
    ],
    verify: (_) {
      verify(mockGetSalaryEstimationUseCase(
        jobTitle: 'Developer',
        location: 'New York',
        radius: '50',
      )).called(1);
    },
  );

  blocTest<SalaryEstimationBloc, SalaryEstimationState>(
    'emits [SalaryEstimationLoading, SalaryEstimationLoaded, SalaryEstimationLoading, SalaryEstimationLoaded] when multiple GetSalaryEstimationsEvent are added in quick succession',
    build: () {
      when(mockGetSalaryEstimationUseCase(
        jobTitle: anyNamed('jobTitle'),
        location: anyNamed('location'),
        radius: anyNamed('radius'),
      )).thenAnswer((invocation) async {
        final jobTitle =
            invocation.namedArguments[const Symbol('jobTitle')] as String;
        final location =
            invocation.namedArguments[const Symbol('location')] as String;

        if (location == 'New York') {
          return Right([
            SalaryEstimationEntity(
              location: 'New York',
              jobTitle: jobTitle,
              publisherName: 'Publisher',
              publisherLink: 'http://publisher.com',
              minimumSalary: 40000,
              maximumSalary: 60000,
              medianSalary: 50000,
              salaryPeriod: 'Yearly',
              salaryCurrency: 'USD',
            ),
          ]);
        } else if (location == 'San Francisco') {
          return Right([
            SalaryEstimationEntity(
              location: 'San Francisco',
              jobTitle: jobTitle,
              publisherName: 'Publisher',
              publisherLink: 'http://publisher.com',
              minimumSalary: 80000,
              maximumSalary: 120000,
              medianSalary: 100000,
              salaryPeriod: 'Yearly',
              salaryCurrency: 'USD',
            ),
          ]);
        }
        return Right([]);
      });
      return bloc;
    },
    act: (bloc) {
      bloc.add(GetSalaryEstimationsEvent(
          jobTitle: 'Developer', location: 'New York'));
      bloc.add(GetSalaryEstimationsEvent(
          jobTitle: 'Developer', location: 'San Francisco'));
    },
    expect: () => [
      SalaryEstimationLoading(),
      SalaryEstimationLoaded([
        SalaryEstimationEntity(
          location: 'New York',
          jobTitle: 'Developer',
          publisherName: 'Publisher',
          publisherLink: 'http://publisher.com',
          minimumSalary: 40000,
          maximumSalary: 60000,
          medianSalary: 50000,
          salaryPeriod: 'Yearly',
          salaryCurrency: 'USD',
        )
      ]),
      SalaryEstimationLoading(),
      SalaryEstimationLoaded([
        SalaryEstimationEntity(
          location: 'San Francisco',
          jobTitle: 'Developer',
          publisherName: 'Publisher',
          publisherLink: 'http://publisher.com',
          minimumSalary: 80000,
          maximumSalary: 120000,
          medianSalary: 100000,
          salaryPeriod: 'Yearly',
          salaryCurrency: 'USD',
        )
      ]),
    ],
  );

  // Additional Event Class Coverage
  test('GetSalaryEstimationsEvent overrides equality for different parameters',
      () {
    final event1 =
        GetSalaryEstimationsEvent(jobTitle: 'Developer', location: 'New York');
    final event2 = GetSalaryEstimationsEvent(
        jobTitle: 'Developer', location: 'San Francisco');
    final event3 =
        GetSalaryEstimationsEvent(jobTitle: 'Engineer', location: 'New York');

    expect(event1 == event2, isFalse);
    expect(event1 == event3, isFalse);
    expect(event1 == event1, isTrue);
  });

  test('ResetSalaryEstimationsEvent equality check', () {
    final event1 = ResetSalaryEstimationsEvent();
    final event2 = ResetSalaryEstimationsEvent();

    expect(event1 == event2, isTrue);
  });
}
