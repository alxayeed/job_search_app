import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_search_app/core/error/failure.dart';
import 'package:job_search_app/core/services/get_storage_service.dart';
import 'package:job_search_app/features/job_search/data/datasources/job_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../salary_estimation/data/datasources/salary_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio, GetStorage, GetStorageService])
void main() {
  late JobRemoteDataSourceImpl dataSource;
  late MockDio mockDio;
  late MockGetStorageService mockStorageService;
  late MockGetStorage mockStorageBox;

  setUp(() {
    mockDio = MockDio();
    mockStorageService = MockGetStorageService();
    mockStorageBox = MockGetStorage();

    GetIt.I.registerSingleton<GetStorageService>(mockStorageService);
    when(mockStorageService.jobResultsBox).thenReturn(mockStorageBox);

    dataSource = JobRemoteDataSourceImpl(mockDio);
    when(mockStorageBox.read("job_results")).thenReturn(null);
  });

  tearDown(() {
    reset(mockDio);
    reset(mockStorageService);
    reset(mockStorageBox);

    GetIt.I.unregister<GetStorageService>();
  });

  group('JobRemoteDataSourceImpl', () {
    final String jobId = '123';
    final String query = 'Flutter Developer';

    test('should return job data when the response is 200', () async {
      // Arrange
      final mockResponse = {
        'jobs': [
          {'id': jobId, 'title': 'Flutter Developer'}
        ],
      };
      when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '')));

      // Act
      final result = await dataSource.searchJobs(query: query);

      // Assert
      expect(result, mockResponse);
      verify(mockDio.getUri(any)).called(1);
    });

    test('should return cached response when available', () async {
      // Arrange
      final cachedResponse = {
        'jobs': [
          {'id': jobId, 'title': 'Cached Flutter Developer'}
        ],
      };
      when(mockStorageBox.read("job_results")).thenReturn(cachedResponse);

      // Act
      final result = await dataSource.searchJobs(query: query);

      // Assert
      expect(result, cachedResponse);
      verifyNever(mockDio.getUri(any));
    });

    test('should throw ServerFailure when status code is not 200', () async {
      // Arrange
      when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          data: {}, statusCode: 404, requestOptions: RequestOptions(path: '')));

      // Act
      final call = () async => await dataSource.searchJobs(query: query);

      // Assert
      expect(call, throwsA(isA<ServerFailure>()));
    });

    test('should throw UnknownFailure on DioException', () async {
      // Arrange
      when(mockDio.getUri(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Some Dio Error',
      ));

      // Act
      final call = () async => await dataSource.searchJobs(query: query);

      // Assert
      expect(call, throwsA(isA<UnknownFailure>()));
    });

    test('should throw UnknownFailure on unexpected error', () async {
      // Arrange
      when(mockDio.getUri(any)).thenThrow(Exception('Unexpected error'));

      // Act
      final call = () async => await dataSource.searchJobs(query: query);

      // Assert
      expect(call, throwsA(isA<UnknownFailure>()));
    });

    test('should return job details when the response is 200', () async {
      // Arrange
      final mockResponse = {'id': jobId, 'title': 'Flutter Developer'};
      when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '')));

      // Act
      final result = await dataSource.getJobDetails(jobId);

      // Assert
      expect(result, mockResponse);
      verify(mockDio.getUri(any)).called(1);
    });

    test('should throw ServerFailure when getting job details and status code is not 200', () async {
      // Arrange
      when(mockDio.getUri(any)).thenAnswer((_) async => Response(
          data: {}, statusCode: 404, requestOptions: RequestOptions(path: '')));

      // Act
      final call = () async => await dataSource.getJobDetails(jobId);

      // Assert
      expect(call, throwsA(isA<UnknownFailure>()));
    });

    test('should throw UnknownFailure on DioException when getting job details', () async {
      // Arrange
      when(mockDio.getUri(any)).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Some Dio Error',
      ));

      // Act
      final call = () async => await dataSource.getJobDetails(jobId);

      // Assert
      expect(call, throwsA(isA<UnknownFailure>()));
    });

    test('should throw UnknownFailure on unexpected error when getting job details', () async {
      // Arrange
      when(mockDio.getUri(any)).thenThrow(Exception('Unexpected error'));

      // Act
      final call = () async => await dataSource.getJobDetails(jobId);

      // Assert
      expect(call, throwsA(isA<UnknownFailure>()));
    });
  });
}
