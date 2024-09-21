import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:job_search_app/core/config/api_config.dart';
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

    // Register the mock storage service with GetIt
    GetIt.I.registerSingleton<GetStorageService>(mockGetStorageService);

    // Stub the salaryEstimationBox to return a mock storage box
    when(mockGetStorageService.salaryEstimationBox).thenReturn(mockStorageBox);

    datasource = SalaryEstimationRemoteDatasource(mockDio);

    // Mock the storage service behavior
    when(mockStorageBox.read('salary_estimation'))
        .thenReturn(null); // Simulate no cached data
  });

  tearDown(() {
    // Reset any registered mocks after each test
    reset(mockDio);
    reset(mockGetStorageService);
    reset(mockStorageBox);
    // Optionally unregister GetStorageService to clean up
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

    // Simulate the response from Dio
    when(mockDio.getUri(uri)).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: uri.toString()),
        ));

    // Act: Call the datasource method
    final result = await datasource.getSalaryEstimation(
      jobTitle: jobTitle,
      location: location,
    );

    // Assert: Ensure data is returned as expected
    expect(result, responseData);

    // Ensure the data is written to the storage
    verify(mockStorageBox.write('salary_estimation', responseData)).called(1);

    // Ensure the Dio request was made
    verify(mockDio.getUri(uri)).called(1);

    // Ensure the storage was read for cached data
    verify(mockStorageBox.read('salary_estimation')).called(1);
  });
}