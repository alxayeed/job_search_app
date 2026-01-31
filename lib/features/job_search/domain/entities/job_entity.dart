import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/employment_type.dart';
import '../enums/job_country.dart';
import '../enums/job_experience.dart';
import '../enums/date_posted.dart';
import 'apply_options_entity.dart';
import 'job_highlights_entity.dart';
import '../../data/models/job_model.dart';

part 'job_entity.freezed.dart';

@freezed
abstract class JobEntity with _$JobEntity {
  const factory JobEntity({
    required String jobId,
    String? employerName,
    String? employerLogo,
    String? employerWebsite,
    String? jobTitle,
    String? jobDescription,
    String? jobApplyLink,
    bool? jobIsRemote,
    bool? jobApplyIsDirect,
    String? jobCity,
    EmploymentType? employmentType,
    JobCountry? country,
    JobExperience? experience,
    DatePosted? datePosted,
    String? jobSalaryCurrency,
    String? jobSalaryPeriod,
    JobHighlightsEntity? jobHighlights,
    List<ApplyOptionEntity>? applyOptions,
    DateTime? jobPostedAtUtc,
    @Default(false) bool isBookmarked,
  }) = _JobEntity;

  const JobEntity._();

  JobModel toModel() {
    return JobModel(
      jobId: jobId,
      employerName: employerName,
      employerLogo: employerLogo,
      employerWebsite: employerWebsite,
      jobTitle: jobTitle,
      jobDescription: jobDescription,
      jobApplyLink: jobApplyLink,
      jobIsRemote: jobIsRemote,
      jobApplyIsDirect: jobApplyIsDirect,
      jobCity: jobCity,
      employmentType: employmentType?.apiValue,
      country: country?.apiValue,
      jobRequirement: experience?.apiValue,
      datePosted: datePosted?.apiValue,
      jobSalaryCurrency: jobSalaryCurrency,
      jobSalaryPeriod: jobSalaryPeriod,
      jobHighlights: jobHighlights?.toModel(),
      applyOptions: applyOptions?.map((e) => e.toModel()).toList(),
      jobPostedAtUtc: jobPostedAtUtc,
      isBookmarked: isBookmarked,
    );
  }
}
