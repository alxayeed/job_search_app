import 'package:equatable/equatable.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_entity.dart';

import '../../domain/entities/job_filter_entity.dart';
import '../../domain/enums/date_posted.dart';
import '../../domain/enums/employment_type.dart';
import '../../domain/enums/job_country.dart';
import '../../domain/enums/job_experience.dart';

abstract class JobSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchJobsEvent extends JobSearchEvent {
  final String query;
  final JobFilterEntity? filters;

  // final bool remoteJobsOnly;
  // final EmploymentType? employmentType;
  // final DatePosted? datePosted;
  // final JobExperience? jobExperience;
  // final JobCountry? jobCountry;

  SearchJobsEvent({
    required this.query,
    this.filters,
    // this.remoteJobsOnly = false,
    // this.employmentType,
    // this.datePosted,
    // this.jobExperience,
    // this.jobCountry,
  });

  @override
  List<Object?> get props => [
    query,
    filters,
    // remoteJobsOnly,
    // employmentType,
    // datePosted,
    // jobExperience,
    // jobCountry,
  ];
}

class JobDetailsRequested extends JobSearchEvent {
  final String jobId;

  JobDetailsRequested({required this.jobId});

  @override
  List<Object?> get props => [jobId];
}

class ResetJobSearchEvent extends JobSearchEvent {}

class BookmarkJobEvent extends JobSearchEvent {
  final JobEntity job;

  BookmarkJobEvent({required this.job});

  @override
  List<Object?> get props => [job];
}

class GetBookmarkedJobsEvent extends JobSearchEvent {
  @override
  List<Object?> get props => [];
}
