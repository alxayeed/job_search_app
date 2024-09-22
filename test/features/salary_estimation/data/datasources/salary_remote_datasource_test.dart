import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:job_search_app/core/config/api_config.dart';
import 'package:job_search_app/core/error/job_failure.dart';
import 'package:job_search_app/features/salary_estimation/data/datasources/salary_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_search_app/core/services/get_storage_service.dart';

import 'salary_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio, GetStorage, GetStorageService])
void main() {
  late SalaryEstimationRemoteDatasource datasource;
  late MockDio mockDio;
  late MockGetStorageService mockGetStorageService;
  late MockGetStorage mockStorageBox;

  setUp(() {
    mockDio = MockDio();
    mockGetStorageService = MockGetStorageService();
    mockStorageBox = MockGetStorage();

    GetIt.I.registerSingleton<GetStorageService>(mockGetStorageService);
    when(mockGetStorageService.salaryEstimationBox).thenReturn(mockStorageBox);

    datasource = SalaryEstimationRemoteDatasource(mockDio);
    when(mockStorageBox.read('salary_estimation')).thenReturn(null);
  });

  tearDown(() {
    reset(mockDio);
    reset(mockGetStorageService);
    reset(mockStorageBox);
    GetIt.I.unregister<GetStorageService>();
  });

  test('should fetch salary estimations from the API when no cache exists',
      () async {
    const jobTitle = 'Software Engineer';
    const location = 'New York';
    final uri = Uri.parse(ApiConfig.salaryEstimation).replace(
      queryParameters: {
        'job_title': jobTitle,
        'location': location,
        'radius': '100',
      },
    );

    final responseData = {
      'data': [
        {
          'jobTitle': 'Software Engineer',
          'location': 'New York',
          'company': 'Tech Corp',
          'salaryMin': 80000,
          'salaryMax': 120000,
          'salaryMedian': 100000,
        }
      ]
    };

    when(mockDio.getUri(uri)).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri.toString()),
        ));

    final result = await datasource.getSalaryEstimation(
        jobTitle: jobTitle, location: location);

    expect(result, responseData);
    verify(mockStorageBox.write('salary_estimation', responseData)).called(1);
    verify(mockDio.getUri(uri)).called(1);
    verify(mockStorageBox.read('salary_estimation')).called(1);
  });

  test('should return cached data when available', () async {
    final cachedData = {'data': []};
    when(mockStorageBox.read('salary_estimation')).thenReturn(cachedData);

    final result = await datasource.getSalaryEstimation(
        jobTitle: 'Software Engineer', location: 'New York');

    expect(result, cachedData);
    verify(mockStorageBox.read('salary_estimation')).called(1);
    verifyNever(mockDio.getUri(any));
  });

  test('should throw ServerFailure when API returns a non-200 status code',
      () async {
    const jobTitle = 'Software Engineer';
    const location = 'New York';
    final uri = Uri.parse(ApiConfig.salaryEstimation).replace(
      queryParameters: {
        'job_title': jobTitle,
        'location': location,
        'radius': '100',
      },
    );

    when(mockDio.getUri(uri)).thenAnswer((_) async => Response(
          data: null,
          statusCode: 404,
          requestOptions: RequestOptions(path: uri.toString()),
        ));

    expect(
      () async => await datasource.getSalaryEstimation(
          jobTitle: jobTitle, location: location),
      throwsA(isA<ServerFailure>()),
    );

    verify(mockDio.getUri(uri)).called(1);
  });

  test('should throw ServerFailure when API response is null', () async {
    const jobTitle = 'Software Engineer';
    const location = 'New York';
    final uri = Uri.parse(ApiConfig.salaryEstimation).replace(
      queryParameters: {
        'job_title': jobTitle,
        'location': location,
        'radius': '100',
      },
    );

    when(mockDio.getUri(uri)).thenAnswer((_) async => Response(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri.toString()),
        ));

    expect(
      () async => await datasource.getSalaryEstimation(
          jobTitle: jobTitle, location: location),
      throwsA(isA<ServerFailure>()),
    );

    verify(mockDio.getUri(uri)).called(1);
  });

  test('should throw ServerFailure when Dio throws an exception', () async {
    const jobTitle = 'Software Engineer';
    const location = 'New York';
    final uri = Uri.parse(ApiConfig.salaryEstimation).replace(
      queryParameters: {
        'job_title': jobTitle,
        'location': location,
        'radius': '100',
      },
    );

    when(mockDio.getUri(uri)).thenThrow(DioException(
      requestOptions: RequestOptions(path: uri.toString()),
      type: DioExceptionType.connectionTimeout,
    ));

    expect(
      () async => await datasource.getSalaryEstimation(
          jobTitle: jobTitle, location: location),
      throwsA(isA<ServerFailure>()),
    );

    verify(mockDio.getUri(uri)).called(1);
  });

  test('should throw ServerFailure when API response is empty', () async {
    const jobTitle = 'Software Engineer';
    const location = 'New York';
    final uri = Uri.parse(ApiConfig.salaryEstimation).replace(
      queryParameters: {
        'job_title': jobTitle,
        'location': location,
        'radius': '100',
      },
    );

    when(mockDio.getUri(uri)).thenAnswer((_) async => Response(
          data: {},
          statusCode: 200,
          requestOptions: RequestOptions(path: uri.toString()),
        ));

    expect(
      () async => await datasource.getSalaryEstimation(
          jobTitle: jobTitle, location: location),
      throwsA(isA<ServerFailure>()),
    );

    verify(mockDio.getUri(uri)).called(1);
  });

  test('should return cached data and not call API if cache is valid',
      () async {
    final cachedData = {
      'data': [
        {
          'jobTitle': 'Software Engineer',
          'location': 'New York',
          'salaryMin': 80000,
          'salaryMax': 120000,
        }
      ]
    };

    when(mockStorageBox.read('salary_estimation')).thenReturn(cachedData);

    final result = await datasource.getSalaryEstimation(
        jobTitle: 'Software Engineer', location: 'New York');

    expect(result, cachedData);
    verify(mockStorageBox.read('salary_estimation')).called(1);
    verifyNever(mockDio.getUri(any));
  });

  test('should return fresh data when cache is invalid or expired', () async {
    const jobTitle = 'Software Engineer';
    const location = 'New York';
    final uri = Uri.parse(ApiConfig.salaryEstimation).replace(
      queryParameters: {
        'job_title': jobTitle,
        'location': location,
        'radius': '100',
      },
    );

    // Simulate an expired or invalid cache
    when(mockStorageBox.read('salary_estimation')).thenReturn(null);

    final responseData = {
      'data': [
        {
          'jobTitle': 'Software Engineer',
          'location': 'New York',
          'salaryMin': 80000,
          'salaryMax': 120000,
        }
      ]
    };

    when(mockDio.getUri(uri)).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri.toString()),
        ));

    final result = await datasource.getSalaryEstimation(
        jobTitle: jobTitle, location: location);

    expect(result, responseData);
    verify(mockStorageBox.write('salary_estimation', responseData)).called(1);
    verify(mockDio.getUri(uri)).called(1);
    verify(mockStorageBox.read('salary_estimation')).called(1);
  });
}
