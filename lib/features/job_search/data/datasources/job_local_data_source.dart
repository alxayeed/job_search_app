// job_local_data_source.dart
import 'package:get_storage/get_storage.dart';
import 'package:job_search_app/features/job_search/data/models/job_model.dart';

class JobLocalDataSource {
  JobLocalDataSource();

  final box = GetStorage();

  Future<void> cacheJob(JobModel job) async {
    box.write(job.jobId, job.toJson());
  }

  Future<JobModel?> getCachedJob(String jobId) async {
    final cachedJobJson = box.read(jobId);

    if (cachedJobJson == null) return null;

    return JobModel.fromJson(cachedJobJson as Map<String, dynamic>);
  }
}
