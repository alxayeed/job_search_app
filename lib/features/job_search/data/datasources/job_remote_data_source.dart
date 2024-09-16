import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_search_app/core/config/api_config.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class JobDataSource {
  Future<Map<String, dynamic>> searchJobs({
    required String query,
    bool remoteJobsOnly = false,
    String employmentType = 'FULLTIME',
    String datePosted = 'all',
  });

  Future<Map<String, dynamic>> getJobDetails(String jobId);
}

class JobRemoteDataSource implements JobDataSource {
  final Dio dio;

  JobRemoteDataSource(this.dio);

  @override
  Future<Map<String, dynamic>> searchJobs({
    required String query,
    bool remoteJobsOnly = false,
    String employmentType = 'FULLTIME',
    String datePosted = 'all',
  }) async {
    final Uri uri = Uri.parse(ApiConfig.searchJobs).replace(
      queryParameters: {
        'query': query,
        'num_pages': '20',
        'remote_jobs_only': remoteJobsOnly.toString(),
        'employment_types': employmentType,
        'date_posted': datePosted,
      },
    );

    final box = GetStorage();
    var cachedResponse = box.read("job_results");

    try {
      if (cachedResponse == null) {
        final response = await dio.getUri(uri);
        if (response.statusCode == 200) {
          box.write("job_results", response.data);
          // Return the response data
          return response.data;
        } else {
          // Handle error
          throw Exception('Failed to load jobs');
        }
      } else {
        await Future.delayed(Duration(seconds: 3));
        return cachedResponse;
      }
    } catch (e) {
      // Handle exceptions
      throw Exception('Failed to load jobs: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getJobDetails(String jobId) async {
    final Uri uri = Uri.parse(ApiConfig.getJobDetails).replace(
      queryParameters: {
        'job_id': jobId,
      },
    );

    try {
      final response = await dio.getUri(uri);

      if (response.statusCode == 200) {
        // Return the response data
        return response.data;
      } else {
        // Handle error
        throw Exception('Failed to load job details');
      }
    } catch (e) {
      // Handle exceptions
      throw Exception('Failed to load job details: $e');
    }
  }

  Future<Map<String, dynamic>> getCachedResponse() async {
    final jsonString =
        await rootBundle.loadString('assets/fake_response/search_jobs.json');

    // Parse the JSON string into a Map
    final cachedResponse = jsonDecode(jsonString) as Map<String, dynamic>;

    // Wait for 3 seconds before returning the cached response
    await Future.delayed(Duration(seconds: 3));

    return cachedResponse;
  }
}
