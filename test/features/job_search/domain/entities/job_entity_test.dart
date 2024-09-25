import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/job_search/domain/entities/entities.dart';

void main() {
  group('JobEntity', () {
    const tJobId = '12345';
    const tEmployerName = 'Company XYZ';
    const tJobTitle = 'Software Engineer';
    const tJobApplyLink = 'https://apply-link.com';
    const tIsBookmarked = true;
    final tApplyOptions = [ApplyOptionEntity(publisher: 'LinkedIn')];
    final tJobRequiredExperience = JobRequiredExperienceEntity(
      noExperienceRequired: false,
      requiredExperienceInMonths: 24,
    );
    final tJobHighlights = JobHighlightsEntity(
      qualifications: ['B.Sc in CS', '5 years experience'],
    );

    test('should return correct props', () {
      final entity = JobEntity(
        jobId: tJobId,
        employerName: tEmployerName,
        jobTitle: tJobTitle,
        jobApplyLink: tJobApplyLink,
        isBookmarked: tIsBookmarked,
        applyOptions: tApplyOptions,
        jobRequiredExperience: tJobRequiredExperience,
        jobHighlights: tJobHighlights,
      );

      expect(entity.props, [
        tJobId,
        tEmployerName,
        null, // employerLogo
        null, // employerWebsite
        null, // jobEmploymentType
        tJobTitle,
        tJobApplyLink,
        null, // jobApplyIsDirect
        tApplyOptions,
        null, // jobDescription
        null, // jobIsRemote
        null, // jobPostedAtDatetimeUtc
        null, // jobCity
        null, // jobCountry
        null, // jobBenefits
        null, // jobGoogleLink
        tJobRequiredExperience,
        null, // jobSalaryCurrency
        null, // jobSalaryPeriod
        tJobHighlights,
        null, // jobJobTitle
        null, // jobPostingLanguage
        tIsBookmarked,
      ]);
    });

    test('should consider two entities with same values as equal', () {
      final entity1 = JobEntity(
        jobId: tJobId,
        employerName: tEmployerName,
        jobTitle: tJobTitle,
        isBookmarked: tIsBookmarked,
        applyOptions: tApplyOptions,
        jobRequiredExperience: tJobRequiredExperience,
        jobHighlights: tJobHighlights,
      );

      final entity2 = JobEntity(
        jobId: tJobId,
        employerName: tEmployerName,
        jobTitle: tJobTitle,
        isBookmarked: tIsBookmarked,
        applyOptions: tApplyOptions,
        jobRequiredExperience: tJobRequiredExperience,
        jobHighlights: tJobHighlights,
      );

      expect(entity1, equals(entity2));
    });

    test('should consider two entities with different values as not equal', () {
      final entity1 = JobEntity(
        jobId: tJobId,
        employerName: tEmployerName,
        jobTitle: tJobTitle,
        isBookmarked: tIsBookmarked,
      );

      final entity2 = JobEntity(
        jobId: '54321',
        employerName: tEmployerName,
        jobTitle: tJobTitle,
        isBookmarked: tIsBookmarked,
      );

      expect(entity1, isNot(equals(entity2)));
    });

    test('should return JobModel with correct values when converting to model',
        () {
      final entity = JobEntity(
        jobId: tJobId,
        employerName: tEmployerName,
        jobTitle: tJobTitle,
        jobApplyLink: tJobApplyLink,
        isBookmarked: tIsBookmarked,
        applyOptions: tApplyOptions,
        jobRequiredExperience: tJobRequiredExperience,
        jobHighlights: tJobHighlights,
      );

      final model = entity.toModel();

      expect(model.jobId, tJobId);
      expect(model.employerName, tEmployerName);
      expect(model.jobTitle, tJobTitle);
      expect(model.jobApplyLink, tJobApplyLink);
      expect(model.isBookmarked, tIsBookmarked);
      expect(model.applyOptions?.first.publisher, 'LinkedIn');
      expect(model.jobRequiredExperience?.noExperienceRequired, false);
      expect(model.jobHighlights?.qualifications?.first, 'B.Sc in CS');
    });

    test('should handle null values properly in props and model conversion',
        () {
      final entity = JobEntity(
        jobId: tJobId,
      );

      expect(entity.props, [
        tJobId, // jobId
        null, // employerName
        null, // employerLogo
        null, // employerWebsite
        null, // jobEmploymentType
        null, // jobTitle
        null, // jobApplyLink
        null, // jobApplyIsDirect
        null, // applyOptions
        null, // jobDescription
        null, // jobIsRemote
        null, // jobPostedAtDatetimeUtc
        null, // jobCity
        null, // jobCountry
        null, // jobBenefits
        null, // jobGoogleLink
        null, // jobRequiredExperience
        null, // jobSalaryCurrency
        null, // jobSalaryPeriod
        null, // jobHighlights
        null, // jobJobTitle
        null, // jobPostingLanguage
        false, // isBookmarked default value
      ]);

      final model = entity.toModel();
      expect(model.jobId, tJobId);
      expect(model.isBookmarked, false);
    });

    test('should correctly copy entity with new values', () {
      final entity = JobEntity(
        jobId: tJobId,
        employerName: tEmployerName,
        jobTitle: tJobTitle,
      );

      final copiedEntity = entity.copyWith(
        jobTitle: 'New Title',
        isBookmarked: true,
      );

      expect(copiedEntity.jobTitle, 'New Title');
      expect(copiedEntity.isBookmarked, true);
      expect(copiedEntity.employerName, tEmployerName); // Unchanged field
    });

    test('should handle nested entities in copyWith', () {
      final entity = JobEntity(
        jobId: tJobId,
        jobRequiredExperience: tJobRequiredExperience,
      );

      final tJobRequiredExperience2 = JobRequiredExperienceEntity(
        noExperienceRequired: false,
        requiredExperienceInMonths: 12,
      );

      final copiedEntity = entity.copyWith(
        jobRequiredExperience: tJobRequiredExperience2,
      );

      expect(
          copiedEntity.jobRequiredExperience?.requiredExperienceInMonths, 12);
    });
  });
}
