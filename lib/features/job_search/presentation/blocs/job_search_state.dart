// State Definitions
import 'package:equatable/equatable.dart';

import '../../../../core/error/job_failure.dart';
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
  final JobFailure failure;

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
  final JobFailure failure;

  JobDetailsError(this.failure);

  @override
  List<Object> get props => [failure];
}
