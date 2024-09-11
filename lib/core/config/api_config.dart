import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static final String baseUrl = 'https://jsearch.p.rapidapi.com';

  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  // Endpoints
  static const String searchJobs = '/search';
  static const String getJobDetails = '/job-details';
}
