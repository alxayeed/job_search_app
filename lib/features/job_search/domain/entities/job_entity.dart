// job_entity.dart
import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';
import 'entities.dart';

class JobEntity extends Equatable {
  final String jobId;
  final String? employerName;
  final String? employerLogo;
  final String? employerWebsite;
  final String? jobEmploymentType;
  final String? jobTitle;
  final String? jobApplyLink;
  final bool? jobApplyIsDirect;
  final List<ApplyOptionEntity>? applyOptions;
  final String? jobDescription;
  final bool? jobIsRemote;
  final DateTime? jobPostedAtDatetimeUtc;
  final String? jobCity;
  final String? jobCountry;
  final List<String>? jobBenefits;
  final String? jobGoogleLink;
  final JobRequiredExperienceEntity? jobRequiredExperience;
  final String? jobSalaryCurrency;
  final String? jobSalaryPeriod;
  final JobHighlightsEntity? jobHighlights;
  final String? jobJobTitle;
  final String? jobPostingLanguage;
  final bool isBookmarked;

  JobEntity({
    required this.jobId,
    this.employerName,
    this.employerLogo,
    this.employerWebsite,
    this.jobEmploymentType,
    this.jobTitle,
    this.jobApplyLink,
    this.jobApplyIsDirect,
    this.applyOptions,
    this.jobDescription,
    this.jobIsRemote,
    this.jobPostedAtDatetimeUtc,
    this.jobCity,
    this.jobCountry,
    this.jobBenefits,
    this.jobGoogleLink,
    this.jobRequiredExperience,
    this.jobSalaryCurrency,
    this.jobSalaryPeriod,
    this.jobHighlights,
    this.jobJobTitle,
    this.jobPostingLanguage,
    this.isBookmarked = false,
  });

  JobEntity copyWith({
    String? jobId,
    String? employerName,
    String? employerLogo,
    String? employerWebsite,
    String? jobEmploymentType,
    String? jobTitle,
    String? jobApplyLink,
    bool? jobApplyIsDirect,
    List<ApplyOptionEntity>? applyOptions,
    String? jobDescription,
    bool? jobIsRemote,
    DateTime? jobPostedAtDatetimeUtc,
    String? jobCity,
    String? jobCountry,
    List<String>? jobBenefits,
    String? jobGoogleLink,
    JobRequiredExperienceEntity? jobRequiredExperience,
    String? jobSalaryCurrency,
    String? jobSalaryPeriod,
    JobHighlightsEntity? jobHighlights,
    String? jobJobTitle,
    String? jobPostingLanguage,
    bool? isBookmarked,
  }) {
    return JobEntity(
      jobId: jobId ?? this.jobId,
      employerName: employerName ?? this.employerName,
      employerLogo: employerLogo ?? this.employerLogo,
      employerWebsite: employerWebsite ?? this.employerWebsite,
      jobEmploymentType: jobEmploymentType ?? this.jobEmploymentType,
      jobTitle: jobTitle ?? this.jobTitle,
      jobApplyLink: jobApplyLink ?? this.jobApplyLink,
      jobApplyIsDirect: jobApplyIsDirect ?? this.jobApplyIsDirect,
      applyOptions: applyOptions ?? this.applyOptions,
      jobDescription: jobDescription ?? this.jobDescription,
      jobIsRemote: jobIsRemote ?? this.jobIsRemote,
      jobPostedAtDatetimeUtc: jobPostedAtDatetimeUtc ??
          this.jobPostedAtDatetimeUtc,
      jobCity: jobCity ?? this.jobCity,
      jobCountry: jobCountry ?? this.jobCountry,
      jobBenefits: jobBenefits ?? this.jobBenefits,
      jobGoogleLink: jobGoogleLink ?? this.jobGoogleLink,
      jobRequiredExperience: jobRequiredExperience ??
          this.jobRequiredExperience,
      jobSalaryCurrency: jobSalaryCurrency ?? this.jobSalaryCurrency,
      jobSalaryPeriod: jobSalaryPeriod ?? this.jobSalaryPeriod,
      jobHighlights: jobHighlights ?? this.jobHighlights,
      jobJobTitle: jobJobTitle ?? this.jobJobTitle,
      jobPostingLanguage: jobPostingLanguage ?? this.jobPostingLanguage,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  List<Object?> get props =>
      [
        jobId,
        employerName,
        employerLogo,
        employerWebsite,
        jobEmploymentType,
        jobTitle,
        jobApplyLink,
        jobApplyIsDirect,
        applyOptions,
        jobDescription,
        jobIsRemote,
        jobPostedAtDatetimeUtc,
        jobCity,
        jobCountry,
        jobBenefits,
        jobGoogleLink,
        jobRequiredExperience,
        jobSalaryCurrency,
        jobSalaryPeriod,
        jobHighlights,
        jobJobTitle,
        jobPostingLanguage,
        isBookmarked,
      ];

  JobModel toModel() {
    return JobModel(
      jobId: jobId,
      employerName: employerName,
      employerLogo: employerLogo,
      employerWebsite: employerWebsite,
      jobEmploymentType: jobEmploymentType,
      jobTitle: jobTitle,
      jobApplyLink: jobApplyLink,
      jobApplyIsDirect: jobApplyIsDirect,
      applyOptions: applyOptions?.map((e) => e.toModel()).toList(),
      jobDescription: jobDescription,
      jobIsRemote: jobIsRemote,
      jobPostedAtDatetimeUtc: jobPostedAtDatetimeUtc,
      jobCity: jobCity,
      jobCountry: jobCountry,
      jobBenefits: jobBenefits,
      jobGoogleLink: jobGoogleLink,
      jobRequiredExperience: jobRequiredExperience?.toModel(),
      jobSalaryCurrency: jobSalaryCurrency,
      jobSalaryPeriod: jobSalaryPeriod,
      jobHighlights: jobHighlights?.toModel(),
      jobJobTitle: jobJobTitle,
      jobPostingLanguage: jobPostingLanguage,
      isBookmarked: isBookmarked,
    );
  }

}






