// job_local_data_source.dart
import 'package:job_search_app/features/job_search/data/models/job_model.dart';
import 'package:job_search_app/features/job_search/domain/entities/entities.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/services/get_storage_service.dart';

class JobLocalDataSource {
  JobLocalDataSource();

  final storageService = sl<GetStorageService>();

  Future<void> addToBookmark(JobModel job) async {
    storageService.bookmarkBox.write(job.jobId, job.toJson());
  }

  Future<void> removeFromBookmark(JobModel job) async {
    storageService.bookmarkBox.remove(job.jobId);
  }

  Future<JobModel?> getCachedJob(String jobId) async {
    final cachedJobJson = storageService.bookmarkBox.read(jobId);

    if (cachedJobJson == null) return null;

    return JobModel.fromJson(cachedJobJson as Map<String, dynamic>);
  }

  Future<List<JobEntity>> getAllBookmarkedJobs() async {
    final box = storageService.bookmarkBox;

    // Get all keys from the box
    final keys = box.getKeys();

    // Fetch all bookmarked jobs from the box
    final List<JobEntity> bookmarkedJobs = [];

    for (String key in keys) {
      final jobJson = box.read(key);
      if (jobJson != null) {
        final job = JobModel.fromJson(jobJson as Map<String, dynamic>);
        JobEntity jobEntity = job.toEntity();
        bookmarkedJobs.add(jobEntity);
      }
    }

    return bookmarkedJobs;
  }
}
