import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/job_search/data/models/apply_options_model.dart';
import 'package:job_search_app/features/job_search/data/models/job_highlights_model.dart';
import 'package:job_search_app/features/job_search/data/models/job_model.dart';
import 'package:job_search_app/features/job_search/data/models/job_required_experience_model.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_entity.dart';

void main() {
  const tJobId = '1';
  const tEmployerName = 'Employer Inc.';
  const tEmployerLogo = 'logo.png';
  const tEmployerWebsite = 'http://employer.com';
  const tJobEmploymentType = 'Full-time';
  const tJobTitle = 'Software Developer';
  const tJobApplyLink = 'http://apply.com';
  const tJobApplyIsDirect = true;
  const tJobDescription = 'Job description';
  const tJobIsRemote = true;
  const tJobPostedAtDatetimeUtc = '2024-01-01T00:00:00Z';
  const tJobCity = 'New York';
  const tJobCountry = 'USA';
  const tJobBenefits = ['Health Insurance', '401k'];
  const tJobGoogleLink = 'http://google.com';
  const tJobSalaryCurrency = 'USD';
  const tJobSalaryPeriod = 'Monthly';
  const tJobJobTitle = 'Senior Developer';
  const tJobPostingLanguage = 'English';
  const tIsBookmarked = false;

  // Sample nested models
  final tJobRequiredExperienceModel = JobRequiredExperienceModel(
    noExperienceRequired: true,
    requiredExperienceInMonths: 12,
    experienceMentioned: true,
    experiencePreferred: false,
  );

  final tJobHighlightsModel = JobHighlightsModel(
    qualifications: ['Bachelor\'s Degree', '3 years of experience'],
    responsibilities: ['Develop applications', 'Collaborate with teams'],
  );

  final tApplyOptionModel = ApplyOptionModel(applyLink: 'http://apply.com');

  // Test the JobModel class
  group('JobModel', () {
    test('should be a subclass of JobEntity', () {
      final jobModel = JobModel(jobId: tJobId);
      expect(jobModel, isA<JobEntity>());
    });

    test('constructor should create a valid model from parameters', () {
      final model = JobModel(
        jobId: tJobId,
        employerName: tEmployerName,
        employerLogo: tEmployerLogo,
        employerWebsite: tEmployerWebsite,
        jobEmploymentType: tJobEmploymentType,
        jobTitle: tJobTitle,
        jobApplyLink: tJobApplyLink,
        jobApplyIsDirect: tJobApplyIsDirect,
        applyOptions: [tApplyOptionModel],
        jobDescription: tJobDescription,
        jobIsRemote: tJobIsRemote,
        jobPostedAtDatetimeUtc: DateTime.parse(tJobPostedAtDatetimeUtc),
        jobCity: tJobCity,
        jobCountry: tJobCountry,
        jobBenefits: tJobBenefits,
        jobGoogleLink: tJobGoogleLink,
        jobRequiredExperience: tJobRequiredExperienceModel,
        jobSalaryCurrency: tJobSalaryCurrency,
        jobSalaryPeriod: tJobSalaryPeriod,
        jobHighlights: tJobHighlightsModel,
        jobJobTitle: tJobJobTitle,
        jobPostingLanguage: tJobPostingLanguage,
        isBookmarked: tIsBookmarked,
      );
      expect(model.jobId, tJobId);
      expect(model.employerName, tEmployerName);
      expect(model.employerLogo, tEmployerLogo);
      expect(model.employerWebsite, tEmployerWebsite);
      expect(model.jobEmploymentType, tJobEmploymentType);
      expect(model.jobTitle, tJobTitle);
      expect(model.jobApplyLink, tJobApplyLink);
      expect(model.jobApplyIsDirect, tJobApplyIsDirect);
      expect(model.applyOptions, [tApplyOptionModel]);
      expect(model.jobDescription, tJobDescription);
      expect(model.jobIsRemote, tJobIsRemote);
      expect(model.jobPostedAtDatetimeUtc,
          DateTime.parse(tJobPostedAtDatetimeUtc));
      expect(model.jobCity, tJobCity);
      expect(model.jobCountry, tJobCountry);
      expect(model.jobBenefits, tJobBenefits);
      expect(model.jobGoogleLink, tJobGoogleLink);
      expect(model.jobRequiredExperience, tJobRequiredExperienceModel);
      expect(model.jobSalaryCurrency, tJobSalaryCurrency);
      expect(model.jobSalaryPeriod, tJobSalaryPeriod);
      expect(model.jobHighlights, tJobHighlightsModel);
      expect(model.jobJobTitle, tJobJobTitle);
      expect(model.jobPostingLanguage, tJobPostingLanguage);
      expect(model.isBookmarked, tIsBookmarked);
    });

    test('fromJson should return a valid model', () {
      final jsonMap = {
        'job_id': tJobId,
        'employer_name': tEmployerName,
        'employer_logo': tEmployerLogo,
        'employer_website': tEmployerWebsite,
        'job_employment_type': tJobEmploymentType,
        'job_title': tJobTitle,
        'job_apply_link': tJobApplyLink,
        'job_apply_is_direct': tJobApplyIsDirect,
        'apply_options': [tApplyOptionModel.toJson()],
        'job_description': tJobDescription,
        'job_is_remote': tJobIsRemote,
        'job_posted_at_datetime_utc': tJobPostedAtDatetimeUtc,
        'job_city': tJobCity,
        'job_country': tJobCountry,
        'job_benefits': tJobBenefits,
        'job_google_link': tJobGoogleLink,
        'job_required_experience': tJobRequiredExperienceModel.toJson(),
        'job_salary_currency': tJobSalaryCurrency,
        'job_salary_period': tJobSalaryPeriod,
        'job_highlights': tJobHighlightsModel.toJson(),
        'job_job_title': tJobJobTitle,
        'job_posting_language': tJobPostingLanguage,
        'isBookmarked': tIsBookmarked,
      };
      final model = JobModel.fromJson(jsonMap);
      expect(model.jobId, tJobId);
      expect(model.employerName, tEmployerName);
      expect(model.employerLogo, tEmployerLogo);
      expect(model.employerWebsite, tEmployerWebsite);
      expect(model.jobEmploymentType, tJobEmploymentType);
      expect(model.jobTitle, tJobTitle);
      expect(model.jobApplyLink, tJobApplyLink);
      expect(model.jobApplyIsDirect, tJobApplyIsDirect);
      expect(model.applyOptions, [tApplyOptionModel]);
      expect(model.jobDescription, tJobDescription);
      expect(model.jobIsRemote, tJobIsRemote);
      expect(model.jobPostedAtDatetimeUtc,
          DateTime.parse(tJobPostedAtDatetimeUtc));
      expect(model.jobCity, tJobCity);
      expect(model.jobCountry, tJobCountry);
      expect(model.jobBenefits, tJobBenefits);
      expect(model.jobGoogleLink, tJobGoogleLink);
      expect(model.jobRequiredExperience, tJobRequiredExperienceModel);
      expect(model.jobSalaryCurrency, tJobSalaryCurrency);
      expect(model.jobSalaryPeriod, tJobSalaryPeriod);
      expect(model.jobHighlights, tJobHighlightsModel);
      expect(model.jobJobTitle, tJobJobTitle);
      expect(model.jobPostingLanguage, tJobPostingLanguage);
      expect(model.isBookmarked, tIsBookmarked);
    });

    test('toJson should return a valid JSON map', () {
      final model = JobModel(
        jobId: tJobId,
        employerName: tEmployerName,
        employerLogo: tEmployerLogo,
        employerWebsite: tEmployerWebsite,
        jobEmploymentType: tJobEmploymentType,
        jobTitle: tJobTitle,
        jobApplyLink: tJobApplyLink,
        jobApplyIsDirect: tJobApplyIsDirect,
        applyOptions: [tApplyOptionModel],
        jobDescription: tJobDescription,
        jobIsRemote: tJobIsRemote,
        jobPostedAtDatetimeUtc: DateTime.parse(tJobPostedAtDatetimeUtc),
        jobCity: tJobCity,
        jobCountry: tJobCountry,
        jobBenefits: tJobBenefits,
        jobGoogleLink: tJobGoogleLink,
        jobRequiredExperience: tJobRequiredExperienceModel,
        jobSalaryCurrency: tJobSalaryCurrency,
        jobSalaryPeriod: tJobSalaryPeriod,
        jobHighlights: tJobHighlightsModel,
        jobJobTitle: tJobJobTitle,
        jobPostingLanguage: tJobPostingLanguage,
        isBookmarked: tIsBookmarked,
      );
      final jsonMap = model.toJson();
      expect(jsonMap, {
        'job_id': tJobId,
        'employer_name': tEmployerName,
        'employer_logo': tEmployerLogo,
        'employer_website': tEmployerWebsite,
        'job_employment_type': tJobEmploymentType,
        'job_title': tJobTitle,
        'job_apply_link': tJobApplyLink,
        'job_apply_is_direct': tJobApplyIsDirect,
        'apply_options': [tApplyOptionModel.toJson()],
        'job_description': tJobDescription,
        'job_is_remote': tJobIsRemote,
        'job_posted_at_datetime_utc':
            DateTime.parse(tJobPostedAtDatetimeUtc).toIso8601String(),
        'job_city': tJobCity,
        'job_country': tJobCountry,
        'job_benefits': tJobBenefits,
        'job_google_link': tJobGoogleLink,
        'job_required_experience': tJobRequiredExperienceModel.toJson(),
        'job_salary_currency': tJobSalaryCurrency,
        'job_salary_period': tJobSalaryPeriod,
        'job_highlights': tJobHighlightsModel.toJson(),
        'job_job_title': tJobJobTitle,
        'job_posting_language': tJobPostingLanguage,
        'isBookmarked': tIsBookmarked,
      });
    });

    test('copyWith should return a new instance with updated values', () {
      final model = JobModel(
        jobId: tJobId,
        employerName: tEmployerName,
        employerLogo: tEmployerLogo,
        employerWebsite: tEmployerWebsite,
        jobEmploymentType: tJobEmploymentType,
        jobTitle: tJobTitle,
        jobApplyLink: tJobApplyLink,
        jobApplyIsDirect: tJobApplyIsDirect,
        applyOptions: [tApplyOptionModel],
        jobDescription: tJobDescription,
        jobIsRemote: tJobIsRemote,
        jobPostedAtDatetimeUtc: DateTime.parse(tJobPostedAtDatetimeUtc),
        jobCity: tJobCity,
        jobCountry: tJobCountry,
        jobBenefits: tJobBenefits,
        jobGoogleLink: tJobGoogleLink,
        jobRequiredExperience: tJobRequiredExperienceModel,
        jobSalaryCurrency: tJobSalaryCurrency,
        jobSalaryPeriod: tJobSalaryPeriod,
        jobHighlights: tJobHighlightsModel,
        jobJobTitle: tJobJobTitle,
        jobPostingLanguage: tJobPostingLanguage,
        isBookmarked: tIsBookmarked,
      );
      final updatedModel = model.copyWith(jobTitle: 'Updated Job Title');
      expect(updatedModel.jobTitle, 'Updated Job Title');
      expect(
          updatedModel.jobId, tJobId); // Ensure other fields remain unchanged
    });

    test('toEntity should return a valid JobEntity', () {
      final model = JobModel(
        jobId: tJobId,
        employerName: tEmployerName,
        employerLogo: tEmployerLogo,
        employerWebsite: tEmployerWebsite,
        jobEmploymentType: tJobEmploymentType,
        jobTitle: tJobTitle,
        jobApplyLink: tJobApplyLink,
        jobApplyIsDirect: tJobApplyIsDirect,
        applyOptions: [tApplyOptionModel],
        jobDescription: tJobDescription,
        jobIsRemote: tJobIsRemote,
        jobPostedAtDatetimeUtc: DateTime.parse(tJobPostedAtDatetimeUtc),
        jobCity: tJobCity,
        jobCountry: tJobCountry,
        jobBenefits: tJobBenefits,
        jobGoogleLink: tJobGoogleLink,
        jobRequiredExperience: tJobRequiredExperienceModel,
        jobSalaryCurrency: tJobSalaryCurrency,
        jobSalaryPeriod: tJobSalaryPeriod,
        jobHighlights: tJobHighlightsModel,
        jobJobTitle: tJobJobTitle,
        jobPostingLanguage: tJobPostingLanguage,
        isBookmarked: tIsBookmarked,
      );

      final jobEntity = model.toEntity();

      expect(jobEntity.jobId, tJobId);
      expect(jobEntity.employerName, tEmployerName);
      expect(jobEntity.employerLogo, tEmployerLogo);
      expect(jobEntity.employerWebsite, tEmployerWebsite);
      expect(jobEntity.jobEmploymentType, tJobEmploymentType);
      expect(jobEntity.jobTitle, tJobTitle);
      expect(jobEntity.jobApplyLink, tJobApplyLink);
      expect(jobEntity.jobApplyIsDirect, tJobApplyIsDirect);
      expect(jobEntity.applyOptions, [
        tApplyOptionModel.toEntity()
      ]); // Assuming you have toEntity in ApplyOptionModel
      expect(jobEntity.jobDescription, tJobDescription);
      expect(jobEntity.jobIsRemote, tJobIsRemote);
      expect(jobEntity.jobPostedAtDatetimeUtc,
          DateTime.parse(tJobPostedAtDatetimeUtc));
      expect(jobEntity.jobCity, tJobCity);
      expect(jobEntity.jobCountry, tJobCountry);
      expect(jobEntity.jobBenefits, tJobBenefits);
      expect(jobEntity.jobGoogleLink, tJobGoogleLink);
      expect(
          jobEntity.jobRequiredExperience,
          tJobRequiredExperienceModel
              .toEntity()); // Assuming toEntity is implemented
      expect(jobEntity.jobSalaryCurrency, tJobSalaryCurrency);
      expect(jobEntity.jobSalaryPeriod, tJobSalaryPeriod);
      expect(jobEntity.jobHighlights,
          tJobHighlightsModel.toEntity()); // Assuming toEntity is implemented
      expect(jobEntity.jobJobTitle, tJobJobTitle);
      expect(jobEntity.jobPostingLanguage, tJobPostingLanguage);
      expect(jobEntity.isBookmarked, tIsBookmarked);
    });
  });
}
