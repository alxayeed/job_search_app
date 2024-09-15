import 'package:equatable/equatable.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_entity.dart';

abstract class JobSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchJobsEvent extends JobSearchEvent {
  final String query;
  final bool remoteJobsOnly;
  final String employmentType;
  final String datePosted;

  SearchJobsEvent({
    required this.query,
    this.remoteJobsOnly = false,
    this.employmentType = 'FULLTIME',
    this.datePosted = 'all',
  });

  @override
  List<Object> get props => [query, remoteJobsOnly, employmentType, datePosted];
}

class JobDetailsRequested extends JobSearchEvent {
  final String jobId;

  JobDetailsRequested({required this.jobId});

  @override
  List<Object> get props => [jobId];
}

class ResetJobSearchEvent extends JobSearchEvent {}

class BookmarkJobEvent extends JobSearchEvent {
  final JobEntity job;

  BookmarkJobEvent({required this.job});

  @override
  List<Object> get props => [job];
}
