import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/job_failure.dart';
import '../../domain/entities/job_entity.dart';
import '../../domain/usecases/fetch_job_use_case.dart';
import '../../domain/usecases/get_job_details_use_case.dart';
import 'job_search_event.dart';
import 'job_search_state.dart';

class JobSearchBloc extends Bloc<JobSearchEvent, JobSearchState> {
  final FetchJobsUseCase searchJobs;
  final GetJobDetailsUseCase getJobDetailsUseCase;

  JobSearchBloc({
    required this.searchJobs,
    required this.getJobDetailsUseCase,
  }) : super(JobSearchInitial()) {
    on<SearchJobsEvent>(_onJobSearchRequested);
    on<JobDetailsRequested>(_onJobDetailsRequested);
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
    emit(JobSearchLoading());

    final Either<JobFailure, JobEntity> result =
        await getJobDetailsUseCase(event.jobId);

    result.fold(
      (failure) => emit(JobSearchError(failure)),
      (job) => emit(JobDetailsLoaded(job: job)),
    );
  }
}
