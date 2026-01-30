import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final String baseUrl = 'https://jsearch.p.rapidapi.com';

  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get apiKey2 => dotenv.env['API_KEY2'] ?? '';
  static String get apiKey3 => dotenv.env['API_KEY3'] ?? '';

  // Endpoints
  static const String searchJobs = '/search';
  static const String getJobDetails = '/job-details';
  static const String salaryEstimation = '/estimated-salary';
}
