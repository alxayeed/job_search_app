import 'package:dartz/dartz.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_entity.dart';

import '../../../../core/error/job_failure.dart';
import '../repositories/job_repository.dart';

class BookmarkJobUseCase{
  final JobRepository repository;
  BookmarkJobUseCase(this.repository);

  Future<Either<JobFailure, JobEntity>> call(JobEntity job) async {
    return await repository.bookmarkJob(job);
  }
}