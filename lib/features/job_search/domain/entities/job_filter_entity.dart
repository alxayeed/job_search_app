// lib/features/job_search/domain/entities/job_filter_entity.dart

import '../../domain/enums/date_posted.dart';
import '../../domain/enums/employment_type.dart';
import '../../domain/enums/job_experience.dart';
import '../../domain/enums/job_country.dart';

class JobFilterEntity {
  final bool remoteJobsOnly;
  final EmploymentType? employmentType;
  final DatePosted? datePosted;
  final JobExperience? jobExperience;
  final JobCountry? jobCountry;
  final double radius;

  JobFilterEntity({
    this.remoteJobsOnly = false,
    this.employmentType,
    this.datePosted,
    this.jobExperience,
    this.jobCountry,
    this.radius = 25.0,
  });

  JobFilterEntity copyWith({
    bool? remoteJobsOnly,
    EmploymentType? employmentType,
    DatePosted? datePosted,
    JobExperience? jobExperience,
    JobCountry? jobCountry,
    double? radius,
  }) {
    return JobFilterEntity(
      remoteJobsOnly: remoteJobsOnly ?? this.remoteJobsOnly,
      employmentType: employmentType ?? this.employmentType,
      datePosted: datePosted ?? this.datePosted,
      jobExperience: jobExperience ?? this.jobExperience,
      jobCountry: jobCountry ?? this.jobCountry,
      radius: radius ?? this.radius,
    );
  }
}
