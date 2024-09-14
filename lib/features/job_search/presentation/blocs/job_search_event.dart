import 'package:equatable/equatable.dart';

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
