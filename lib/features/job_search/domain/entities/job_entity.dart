// job_entity.dart
import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String jobId;
  final String? employerName;
  final String? employerLogo;
  final String? employerWebsite;
  final String? jobEmploymentType;
  final String? jobTitle;
  final String? jobApplyLink;
  final bool? jobApplyIsDirect;
  final List<ApplyOption>? applyOptions;
  final String? jobDescription;
  final bool? jobIsRemote;
  final DateTime? jobPostedAtDatetimeUtc;
  final String? jobCity;
  final String? jobCountry;
  final List<String>? jobBenefits;
  final String? jobGoogleLink;
  final JobRequiredExperience? jobRequiredExperience;
  final String? jobSalaryCurrency;
  final String? jobSalaryPeriod;
  final JobHighlights? jobHighlights;
  final String? jobJobTitle;
  final String? jobPostingLanguage;

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
  });

  @override
  List<Object?> get props => [
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
      ];
}

class ApplyOption extends Equatable {
  final String? publisher;
  final String? applyLink;
  final bool? isDirect;

  ApplyOption({
    this.publisher,
    this.applyLink,
    this.isDirect,
  });

  @override
  List<Object?> get props => [publisher, applyLink, isDirect];
}

class JobRequiredExperience extends Equatable {
  final bool? noExperienceRequired;
  final int? requiredExperienceInMonths;
  final bool? experienceMentioned;
  final bool? experiencePreferred;

  JobRequiredExperience({
    this.noExperienceRequired,
    this.requiredExperienceInMonths,
    this.experienceMentioned,
    this.experiencePreferred,
  });

  @override
  List<Object?> get props => [
        noExperienceRequired,
        requiredExperienceInMonths,
        experienceMentioned,
        experiencePreferred,
      ];
}

class JobHighlights extends Equatable {
  final List<String>? qualifications;
  final List<String>? responsibilities;

  JobHighlights({
    this.qualifications,
    this.responsibilities,
  });

  @override
  List<Object?> get props => [qualifications, responsibilities];
}
