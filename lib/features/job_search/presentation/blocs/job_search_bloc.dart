import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:job_search_app/features/job_search/presentation/blocs/blocs.dart';
import '../../../../core/error/job_failure.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/usecases/bookmark_job_use_case.dart';
import '../../domain/usecases/fetch_job_use_case.dart';
import '../../domain/usecases/get_job_details_use_case.dart';

class JobSearchBloc extends Bloc<JobSearchEvent, JobSearchState> {
  final FetchJobsUseCase searchJobs;
  final GetJobDetailsUseCase getJobDetailsUseCase;
  final BookmarkJobUseCase bookmarkJobUseCase;

  JobSearchBloc({
    required this.searchJobs,
    required this.getJobDetailsUseCase,
    required this.bookmarkJobUseCase,
  }) : super(JobSearchInitial()) {
    on<SearchJobsEvent>(_onJobSearchRequested);
    on<JobDetailsRequested>(_onJobDetailsRequested);
    on<ResetJobSearchEvent>(_onResetJobSearchEvent);
    on<BookmarkJobEvent>(_onBookmarkJob);
  }

  Future<void> _onJobSearchRequested(
      SearchJobsEvent event, Emitter<JobSearchState> emit) async {
    emit(JobSearchLoading());

    final Either<JobFailure, List<JobEntity>> result = await searchJobs(
      query: event.query,
      remoteJobsOnly: event.remoteJobsOnly,
      employmentType: event.employmentType,
      datePosted: event.datePosted,
    );

    result.fold(
      (failure) => emit(JobSearchError(failure)),
      (jobs) => emit(JobSearchLoaded(jobs)),
    );
  }

  Future<void> _onJobDetailsRequested(
      JobDetailsRequested event, Emitter<JobSearchState> emit) async {
    emit(JobDetailsLoading());

    final Either<JobFailure, JobEntity> result =
        await getJobDetailsUseCase(event.jobId);

    result.fold(
      (failure) => emit(JobSearchError(failure)),
      (job) => emit(JobDetailsLoaded(job: job)),
    );
  }

  Future<void> _onBookmarkJob(
      BookmarkJobEvent event, Emitter<JobSearchState> emit) async {
    final Either<JobFailure, JobEntity> result =
        await bookmarkJobUseCase(event.job);

    result.fold(
      (failure) => emit(JobSearchError(failure)),
      (job) => emit(
        job.isBookmarked
            ? BookmarkAddedState(job: job)
            : BookmarkRemovedState(job: job),
      ),
    );
  }

  void _onResetJobSearchEvent(
      ResetJobSearchEvent event, Emitter<JobSearchState> emit) {
    emit(JobSearchInitial());
  }
}
