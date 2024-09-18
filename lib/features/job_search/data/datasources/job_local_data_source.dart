// job_local_data_source.dart
import 'package:get_storage/get_storage.dart';
import 'package:job_search_app/features/job_search/data/models/job_model.dart';


class JobLocalDataSource {
  JobLocalDataSource();

  final box = GetStorage();

  Future<void> addToBookmark(JobModel job) async {
    box.write(job.jobId, job.toJson());
  }

  Future<void> removeFromBookmark(JobModel job) async {
    box.remove(job.jobId);
  }

  Future<JobModel?> getCachedJob(String jobId) async {
    final cachedJobJson = box.read(jobId);

    if (cachedJobJson == null) return null;

    return JobModel.fromJson(cachedJobJson as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> getAllBookmarkedJobs() async {
    //TODO: Get all keys
    //TODO: Iterate through the keys to get all jobs and return
    //TODO: check the cached response
    final box = GetStorage();
    var cachedResponse = box.read("job_results");
    print(cachedResponse);

    return cachedResponse;
  }
}
