// State Definitions
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/job_entity.dart';

abstract class JobSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class JobSearchInitial extends JobSearchState {}

class JobSearchLoading extends JobSearchState {}

class JobSearchLoaded extends JobSearchState {
  final List<JobEntity> jobs;

  JobSearchLoaded(this.jobs);

  @override
  List<Object> get props => [jobs];
}

class JobSearchError extends JobSearchState {
  final Failure failure;

  JobSearchError(this.failure);

  @override
  List<Object> get props => [failure];
}

class JobDetailsLoading extends JobSearchState {}

class JobDetailsLoaded extends JobSearchState {
  final JobEntity job;

  JobDetailsLoaded({required this.job});

  @override
  List<Object> get props => [job];
}

class JobDetailsError extends JobSearchState {
  final Failure failure;

  JobDetailsError(this.failure);

  @override
  List<Object> get props => [failure];
}

class BookmarkAddedState extends JobSearchState {
  final JobEntity job;

  BookmarkAddedState({required this.job});

  @override
  List<Object> get props => [job];
}

class BookmarkRemovedState extends JobSearchState {
  final JobEntity job;

  BookmarkRemovedState({required this.job});

  @override
  List<Object> get props => [job];
}

class BookmarkedJobsLoading extends JobSearchState {}

class BookmarkedJobsLoaded extends JobSearchState {
  final List<JobEntity> jobs;

  BookmarkedJobsLoaded(this.jobs);

  @override
  List<Object> get props => [jobs];
}

class BookmarkedJobsErrorState extends JobSearchState {
  final String message;

  BookmarkedJobsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
