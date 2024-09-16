import 'package:isar/isar.dart';

import '../../domain/entities/job_entity.dart';
import 'models.dart';

@collection
class JobModel extends JobEntity {
  JobModel({
    required String jobId,
    String? employerName,
    String? employerLogo,
    String? employerWebsite,
    String? jobEmploymentType,
    String? jobTitle,
    String? jobApplyLink,
    bool? jobApplyIsDirect,
    List<ApplyOptionModel>? applyOptions,
    String? jobDescription,
    bool? jobIsRemote,
    DateTime? jobPostedAtDatetimeUtc,
    String? jobCity,
    String? jobCountry,
    List<String>? jobBenefits,
    String? jobGoogleLink,
    JobRequiredExperienceModel? jobRequiredExperience,
    String? jobSalaryCurrency,
    String? jobSalaryPeriod,
    JobHighlightsModel? jobHighlights,
    String? jobJobTitle,
    String? jobPostingLanguage,
    bool isBookmarked = false,
  }) : super(
          jobId: jobId,
          employerName: employerName,
          employerLogo: employerLogo,
          employerWebsite: employerWebsite,
          jobEmploymentType: jobEmploymentType,
          jobTitle: jobTitle,
          jobApplyLink: jobApplyLink,
          jobApplyIsDirect: jobApplyIsDirect,
          applyOptions: applyOptions,
          jobDescription: jobDescription,
          jobIsRemote: jobIsRemote,
          jobPostedAtDatetimeUtc: jobPostedAtDatetimeUtc,
          jobCity: jobCity,
          jobCountry: jobCountry,
          jobBenefits: jobBenefits,
          jobGoogleLink: jobGoogleLink,
          jobRequiredExperience: jobRequiredExperience,
          jobSalaryCurrency: jobSalaryCurrency,
          jobSalaryPeriod: jobSalaryPeriod,
          jobHighlights: jobHighlights,
          jobJobTitle: jobJobTitle,
          jobPostingLanguage: jobPostingLanguage,
          isBookmarked: isBookmarked,
        );

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      jobId: json['job_id'],
      employerName: json['employer_name'],
      employerLogo: json['employer_logo'],
      employerWebsite: json['employer_website'],
      jobEmploymentType: json['job_employment_type'],
      jobTitle: json['job_title'],
      jobApplyLink: json['job_apply_link'],
      jobApplyIsDirect: json['job_apply_is_direct'],
      applyOptions: (json['apply_options'] as List?)
          ?.map((option) => ApplyOptionModel.fromJson(option))
          .toList(),
      jobDescription: json['job_description'],
      jobIsRemote: json['job_is_remote'],
      jobPostedAtDatetimeUtc: json['job_posted_at_datetime_utc'] != null
          ? DateTime.tryParse(json['job_posted_at_datetime_utc'])
          : null,
      jobCity: json['job_city'],
      jobCountry: json['job_country'],
      jobBenefits: (json['job_benefits'] as List<dynamic>?)
          ?.map((benefit) => benefit.toString())
          .toList(),
      jobGoogleLink: json['job_google_link'],
      jobRequiredExperience: json['job_required_experience'] != null
          ? JobRequiredExperienceModel.fromJson(json['job_required_experience'])
          : null,
      jobSalaryCurrency: json['job_salary_currency'],
      jobSalaryPeriod: json['job_salary_period'],
      jobHighlights: json['job_highlights'] != null
          ? JobHighlightsModel.fromJson(json['job_highlights'])
          : null,
      jobJobTitle: json['job_job_title'],
      jobPostingLanguage: json['job_posting_language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'employer_name': employerName,
      'employer_logo': employerLogo,
      'employer_website': employerWebsite,
      'job_employment_type': jobEmploymentType,
      'job_title': jobTitle,
      'job_apply_link': jobApplyLink,
      'job_apply_is_direct': jobApplyIsDirect,
      'apply_options':
          applyOptions?.map((e) => (e as ApplyOptionModel).toJson()).toList(),
      'job_description': jobDescription,
      'job_is_remote': jobIsRemote,
      'job_posted_at_datetime_utc': jobPostedAtDatetimeUtc?.toIso8601String(),
      'job_city': jobCity,
      'job_country': jobCountry,
      'job_benefits': jobBenefits,
      'job_google_link': jobGoogleLink,
      'job_required_experience':
          (jobRequiredExperience as JobRequiredExperienceModel?)?.toJson(),
      'job_salary_currency': jobSalaryCurrency,
      'job_salary_period': jobSalaryPeriod,
      'job_highlights': (jobHighlights as JobHighlightsModel?)?.toJson(),
      'job_job_title': jobJobTitle,
      'job_posting_language': jobPostingLanguage,
    };
  }

  JobEntity toEntity() {
    return JobEntity(
      jobId: jobId,
      employerName: employerName,
      employerLogo: employerLogo,
      employerWebsite: employerWebsite,
      jobEmploymentType: jobEmploymentType,
      jobTitle: jobTitle,
      jobApplyLink: jobApplyLink,
      jobApplyIsDirect: jobApplyIsDirect,
      applyOptions:
          applyOptions?.map((e) => (e as ApplyOptionModel).toEntity()).toList(),
      jobDescription: jobDescription,
      jobIsRemote: jobIsRemote,
      jobPostedAtDatetimeUtc: jobPostedAtDatetimeUtc,
      jobCity: jobCity,
      jobCountry: jobCountry,
      jobBenefits: jobBenefits,
      jobGoogleLink: jobGoogleLink,
      jobRequiredExperience:
          (jobRequiredExperience as JobRequiredExperienceModel?)?.toEntity(),
      jobSalaryCurrency: jobSalaryCurrency,
      jobSalaryPeriod: jobSalaryPeriod,
      jobHighlights: (jobHighlights as JobHighlightsModel?)?.toEntity(),
      jobJobTitle: jobJobTitle,
      jobPostingLanguage: jobPostingLanguage,
      isBookmarked: isBookmarked,
    );
  }
}






