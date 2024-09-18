import 'package:get_storage/get_storage.dart';
import 'package:job_search_app/core/constants/app_strings.dart';

class GetStorageService {
  static GetStorageService? _instance;

  factory GetStorageService() {
    if (_instance == null) {
      _instance = GetStorageService._internal();
    }
    return _instance!;
  }

  GetStorageService._internal();

  Future<void> init() async {
    await GetStorage.init(AppStrings.bookmarkBox);
    await GetStorage.init(AppStrings.jobResultsBox);
  }

  // Access the boxes directly
  GetStorage get bookmarkBox => GetStorage(AppStrings.bookmarkBox);
  GetStorage get jobResultsBox => GetStorage(AppStrings.jobResultsBox);
}
