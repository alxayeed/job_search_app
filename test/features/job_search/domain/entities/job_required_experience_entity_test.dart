import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_required_experience_entity.dart';

void main() {
  group('JobRequiredExperienceEntity', () {
    const tNoExperienceRequired = true;
    const tRequiredExperienceInMonths = 24;
    const tExperienceMentioned = true;
    const tExperiencePreferred = false;

    test('should return correct props', () {
      final entity = JobRequiredExperienceEntity(
        noExperienceRequired: tNoExperienceRequired,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );

      expect(entity.props, [
        tNoExperienceRequired,
        tRequiredExperienceInMonths,
        tExperienceMentioned,
        tExperiencePreferred
      ]);
    });

    test('should consider two entities with same values as equal', () {
      final entity1 = JobRequiredExperienceEntity(
        noExperienceRequired: tNoExperienceRequired,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );

      final entity2 = JobRequiredExperienceEntity(
        noExperienceRequired: tNoExperienceRequired,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );

      expect(entity1, equals(entity2));
    });

    test('should consider two entities with different values as not equal', () {
      final entity1 = JobRequiredExperienceEntity(
        noExperienceRequired: tNoExperienceRequired,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );

      final entity2 = JobRequiredExperienceEntity(
        noExperienceRequired: false,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );

      expect(entity1, isNot(equals(entity2)));
    });

    test(
        'should return JobRequiredExperienceModel with correct values when converting to model',
        () {
      final entity = JobRequiredExperienceEntity(
        noExperienceRequired: tNoExperienceRequired,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );

      final model = entity.toModel();

      expect(model.noExperienceRequired, tNoExperienceRequired);
      expect(model.requiredExperienceInMonths, tRequiredExperienceInMonths);
      expect(model.experienceMentioned, tExperienceMentioned);
      expect(model.experiencePreferred, tExperiencePreferred);
    });

    test('should handle null values properly', () {
      final entity = JobRequiredExperienceEntity(
        noExperienceRequired: null,
        requiredExperienceInMonths: null,
        experienceMentioned: null,
        experiencePreferred: null,
      );

      expect(entity.props, [null, null, null, null]);

      final model = entity.toModel();

      expect(model.noExperienceRequired, null);
      expect(model.requiredExperienceInMonths, null);
      expect(model.experienceMentioned, null);
      expect(model.experiencePreferred, null);
    });

    test('should handle zero and negative experience values', () {
      final entityZeroExperience = JobRequiredExperienceEntity(
        requiredExperienceInMonths: 0,
      );
      final entityNegativeExperience = JobRequiredExperienceEntity(
        requiredExperienceInMonths: -5,
      );

      expect(entityZeroExperience.requiredExperienceInMonths, 0);
      expect(entityNegativeExperience.requiredExperienceInMonths, -5);
    });
  });
}
