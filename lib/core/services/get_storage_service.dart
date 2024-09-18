import 'package:get_storage/get_storage.dart';
import 'package:job_search_app/core/constants/app_strings.dart';

class GetStorageService {
  static final GetStorageService _instance = GetStorageService._internal();

  factory GetStorageService() {
    return _instance;
  }

  GetStorageService._internal();

  Future<void> init() async {
    await GetStorage.init();
  }

  // Store single instances of each box
  late final GetStorage _bookmarkBox = GetStorage(AppStrings.bookmarkBox);
  late final GetStorage _jobResultsBox = GetStorage(AppStrings.jobResultsBox);

  GetStorage get bookmarkBox => _bookmarkBox;
  GetStorage get jobResultsBox => _jobResultsBox;
}
