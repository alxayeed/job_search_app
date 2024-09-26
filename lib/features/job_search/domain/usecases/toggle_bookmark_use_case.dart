import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/job_entity.dart';
import '../repositories/job_repository.dart';

class ToggleBookmarkUseCase {
  final JobRepository repository;

  ToggleBookmarkUseCase(this.repository);

  Future<Either<Failure, JobEntity>> call(JobEntity job) async {
    if (job.isBookmarked) {
      return await repository.removeJobFromBookmark(job);
    } else {
      return await repository.bookmarkJob(job);
    }
  }
}
