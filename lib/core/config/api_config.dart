import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../features/job_search/presentation/screens/job_details_screen.dart';
import '../services/get_storage_service.dart';

class ApiConfig {
  static final String baseUrl = 'https://jsearch.p.rapidapi.com';
  static final _storage = sl<GetStorageService>();

  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get apiKey2 => dotenv.env['API_KEY2'] ?? '';
  static String get apiKey3 => dotenv.env['API_KEY3'] ?? '';

  static String? _currentKey;

  static String get currentKey {
    _currentKey ??= _storage.jobResultsBox.read('selected_api_key') ?? apiKey;
    return _currentKey!;
  }

  static void setCurrentKey(String? key) {
    if (key != null && key.isNotEmpty) {
      _currentKey = key;
      _storage.jobResultsBox.write('selected_api_key', key);
    }
  }

  static List<String> get availableKeys =>
      [apiKey, apiKey2, apiKey3].where((k) => k.isNotEmpty).toList();

  static const String searchJobs = '/search';
  static const String getJobDetails = '/job-details';
  static const String salaryEstimation = '/estimated-salary';
}
