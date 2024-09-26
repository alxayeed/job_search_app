import 'package:job_search_app/features/job_search/data/models/job_model.dart';
import 'package:job_search_app/features/job_search/domain/entities/entities.dart';

import '../../../../core/services/get_storage_service.dart';

abstract class JobLocalDataSource {
  Future<void> addToBookmark(JobModel job);

  Future<void> removeFromBookmark(JobModel job);

  Future<JobModel?> getCachedJob(String jobId);

  Future<List<JobEntity>> getAllBookmarkedJobs();
}

class JobLocalDataSourceImpl implements JobLocalDataSource {
  final GetStorageService storageService;

  // Injecting GetStorageService via constructor
  JobLocalDataSourceImpl({required this.storageService});

  @override
  Future<void> addToBookmark(JobModel job) async {
    try {
      await storageService.bookmarkBox.write(job.jobId, job.toJson());
    } catch (e) {
      throw Exception('Failed to add job to bookmark: $e');
    }
  }

  @override
  Future<void> removeFromBookmark(JobModel job) async {
    try {
      await storageService.bookmarkBox.remove(job.jobId);
    } catch (e) {
      throw Exception('Failed to remove job from bookmark: $e');
    }
  }

  @override
  Future<JobModel?> getCachedJob(String jobId) async {
    try {
      final cachedJobJson = storageService.bookmarkBox.read(jobId);
      if (cachedJobJson == null) return null;
      return JobModel.fromJson(cachedJobJson as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to retrieve cached job: $e');
    }
  }

  @override
  Future<List<JobEntity>> getAllBookmarkedJobs() async {
    try {
      final box = storageService.bookmarkBox;

      // Get all keys from the box
      final keys = box.getKeys();

      // Fetch all bookmarked jobs from the box
      final List<JobEntity> bookmarkedJobs = [];

      for (String key in keys) {
        final jobJson = box.read(key);
        if (jobJson != null) {
          final job = JobModel.fromJson(jobJson as Map<String, dynamic>);
          bookmarkedJobs.add(job.toEntity());
        }
      }

      return bookmarkedJobs;
    } catch (e) {
      throw Exception('Failed to retrieve bookmarked jobs: $e');
    }
  }
}
