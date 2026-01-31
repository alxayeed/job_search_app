import '../../domain/entities/job_entity.dart';
import '../../domain/enums/employment_type.dart';
import '../../domain/enums/job_country.dart';
import '../../domain/enums/job_experience.dart';
import '../../domain/enums/date_posted.dart';
import 'apply_options_model.dart';
import 'job_highlights_model.dart';

class JobModel {
  final String jobId;

  final String? employerName;
  final String? employerLogo;
  final String? employerWebsite;

  final String? jobTitle;
  final String? jobDescription;
  final String? jobApplyLink;

  final bool? jobIsRemote;
  final bool? jobApplyIsDirect;

  final String? jobCity;

  /// API raw values
  final String? employmentType;
  final String? country;
  final String? jobRequirement;
  final String? datePosted;

  final String? jobSalaryCurrency;
  final String? jobSalaryPeriod;
  final JobHighlightsModel? jobHighlights;
  final List<ApplyOptionModel>? applyOptions;

  final DateTime? jobPostedAtUtc;
  final bool isBookmarked;

  const JobModel({
    required this.jobId,
    this.employerName,
    this.employerLogo,
    this.employerWebsite,
    this.jobTitle,
    this.jobDescription,
    this.jobApplyLink,
    this.jobIsRemote,
    this.jobApplyIsDirect,
    this.jobCity,
    this.employmentType,
    this.country,
    this.jobRequirement,
    this.datePosted,
    this.jobSalaryCurrency,
    this.jobSalaryPeriod,
    this.jobHighlights,
    this.applyOptions,
    this.jobPostedAtUtc,
    this.isBookmarked = false,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      jobId: json['job_id'],
      employerName: json['employer_name'],
      employerLogo: json['employer_logo'],
      employerWebsite: json['employer_website'],
      jobTitle: json['job_title'],
      jobDescription: json['job_description'],
      jobApplyLink: json['job_apply_link'],
      jobApplyIsDirect: json['job_apply_is_direct'],
      jobIsRemote: json['job_is_remote'],
      jobCity: json['job_city'],
      employmentType: json['job_employment_type'],
      country: json['job_country'],
      jobRequirement: json['job_requirement'],
      datePosted: json['date_posted'],
      jobSalaryCurrency: json['job_salary_currency'],
      jobSalaryPeriod: json['job_salary_period'],
      jobHighlights: json['job_highlights'] != null
          ? JobHighlightsModel.fromJson(json['job_highlights'])
          : null,
      applyOptions: (json['apply_options'] as List?)
          ?.map((e) => ApplyOptionModel.fromJson(e))
          .toList(),
      jobPostedAtUtc: json['job_posted_at_datetime_utc'] != null
          ? DateTime.tryParse(json['job_posted_at_datetime_utc'])
          : null,
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'employer_name': employerName,
      'employer_logo': employerLogo,
      'employer_website': employerWebsite,
      'job_title': jobTitle,
      'job_description': jobDescription,
      'job_apply_link': jobApplyLink,
      'job_apply_is_direct': jobApplyIsDirect,
      'job_is_remote': jobIsRemote,
      'job_city': jobCity,
      'job_employment_type': employmentType,
      'job_country': country,
      'job_requirement': jobRequirement,
      'date_posted': datePosted,
      'job_salary_currency': jobSalaryCurrency,
      'job_salary_period': jobSalaryPeriod,
      'job_highlights': jobHighlights?.toJson(),
      'apply_options': applyOptions?.map((e) => e.toJson()).toList(),
      'job_posted_at_datetime_utc': jobPostedAtUtc?.toIso8601String(),
      'isBookmarked': isBookmarked,
    };
  }

  JobEntity toEntity() {
    return JobEntity(
      jobId: jobId,
      employerName: employerName,
      employerLogo: employerLogo,
      employerWebsite: employerWebsite,
      jobTitle: jobTitle,
      jobDescription: jobDescription,
      jobApplyLink: jobApplyLink,
      jobApplyIsDirect: jobApplyIsDirect,
      jobIsRemote: jobIsRemote,
      jobCity: jobCity,
      employmentType: _mapEmploymentType(employmentType),
      country: _mapCountry(country),
      experience: _mapExperience(jobRequirement),
      datePosted: _mapDatePosted(datePosted),
      jobSalaryCurrency: jobSalaryCurrency,
      jobSalaryPeriod: jobSalaryPeriod,
      jobHighlights: jobHighlights?.toEntity(),
      applyOptions: applyOptions!.map((e) => e.toEntity()).toList(),
      jobPostedAtUtc: jobPostedAtUtc,
      isBookmarked: isBookmarked,
    );
  }

  EmploymentType? _mapEmploymentType(String? value) {
    if (value == null) return null;
    try {
      return EmploymentType.values.firstWhere((e) => e.apiValue == value);
    } catch (_) {
      return null;
    }
  }

  JobCountry? _mapCountry(String? value) {
    if (value == null) return null;
    try {
      return JobCountry.values.firstWhere((e) => e.apiValue == value);
    } catch (_) {
      return null;
    }
  }

  JobExperience? _mapExperience(String? value) {
    if (value == null) return null;
    try {
      return JobExperience.values.firstWhere((e) => e.apiValue == value);
    } catch (_) {
      return null;
    }
  }

  DatePosted? _mapDatePosted(String? value) {
    if (value == null) return null;
    try {
      return DatePosted.values.firstWhere((e) => e.apiValue == value);
    } catch (_) {
      return null;
    }
  }


}
