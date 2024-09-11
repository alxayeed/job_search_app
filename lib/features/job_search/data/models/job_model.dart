import '../../domain/entities/job_entity.dart';

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
    List<ApplyOption>? applyOptions,
    String? jobDescription,
    bool? jobIsRemote,
    DateTime? jobPostedAtDatetimeUtc,
    String? jobCity,
    String? jobCountry,
    List<String>? jobBenefits,
    String? jobGoogleLink,
    JobRequiredExperience? jobRequiredExperience,
    String? jobSalaryCurrency,
    String? jobSalaryPeriod,
    JobHighlights? jobHighlights,
    String? jobJobTitle,
    String? jobPostingLanguage,
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
          ?.map((option) => ApplyOption(
                publisher: option['publisher'],
                applyLink: option['apply_link'],
                isDirect: option['is_direct'],
              ))
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
          ? JobRequiredExperience(
              noExperienceRequired: json['job_required_experience']
                      ['no_experience_required'] ==
                  'true',
              requiredExperienceInMonths: json['job_required_experience']
                          ['required_experience_in_months'] !=
                      null
                  ? int.tryParse(json['job_required_experience']
                      ['required_experience_in_months'])
                  : null,
              experienceMentioned: json['job_required_experience']
                      ['experience_mentioned'] ==
                  'true',
              experiencePreferred: json['job_required_experience']
                      ['experience_preferred'] ==
                  'true',
            )
          : null,
      jobSalaryCurrency: json['job_salary_currency'],
      jobSalaryPeriod: json['job_salary_period'],
      jobHighlights: json['job_highlights'] != null
          ? JobHighlights(
              qualifications:
                  (json['job_highlights']['Qualifications'] as List<dynamic>?)
                      ?.map((qual) => qual.toString())
                      .toList(),
              responsibilities:
                  (json['job_highlights']['Responsibilities'] as List<dynamic>?)
                      ?.map((resp) => resp.toString())
                      .toList(),
            )
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
      'apply_options': applyOptions
          ?.map((option) => {
                'publisher': option.publisher,
                'apply_link': option.applyLink,
                'is_direct': option.isDirect,
              })
          .toList(),
      'job_description': jobDescription,
      'job_is_remote': jobIsRemote,
      'job_posted_at_datetime_utc': jobPostedAtDatetimeUtc?.toIso8601String(),
      'job_city': jobCity,
      'job_country': jobCountry,
      'job_benefits': jobBenefits,
      'job_google_link': jobGoogleLink,
      'job_required_experience': jobRequiredExperience != null
          ? {
              'no_experience_required':
                  jobRequiredExperience!.noExperienceRequired,
              'required_experience_in_months':
                  jobRequiredExperience!.requiredExperienceInMonths,
              'experience_mentioned':
                  jobRequiredExperience!.experienceMentioned,
              'experience_preferred':
                  jobRequiredExperience!.experiencePreferred,
            }
          : null,
      'job_salary_currency': jobSalaryCurrency,
      'job_salary_period': jobSalaryPeriod,
      'job_highlights': jobHighlights != null
          ? {
              'Qualifications': jobHighlights!.qualifications,
              'Responsibilities': jobHighlights!.responsibilities,
            }
          : null,
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
    );
  }
}
