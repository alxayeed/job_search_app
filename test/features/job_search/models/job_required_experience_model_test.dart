import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/job_search/data/models/job_required_experience_model.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_required_experience_entity.dart';

void main() {
  const tNoExperienceRequired = true;
  const tRequiredExperienceInMonths = 24;
  const tExperienceMentioned = true;
  const tExperiencePreferred = false;

  // Test the JobRequiredExperienceModel class
  group('JobRequiredExperienceModel', () {
    test('should be a subclass of JobRequiredExperienceEntity', () {
      final jobRequiredExperienceModel = JobRequiredExperienceModel();
      expect(jobRequiredExperienceModel, isA<JobRequiredExperienceEntity>());
    });

    test('constructor should create a valid model from parameters', () {
      final model = JobRequiredExperienceModel(
        noExperienceRequired: tNoExperienceRequired,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );
      expect(model.noExperienceRequired, tNoExperienceRequired);
      expect(model.requiredExperienceInMonths, tRequiredExperienceInMonths);
      expect(model.experienceMentioned, tExperienceMentioned);
      expect(model.experiencePreferred, tExperiencePreferred);
    });

    test('fromJson should return a valid model', () {
      final jsonMap = {
        'no_experience_required': 'true',
        'required_experience_in_months': '24',
        'experience_mentioned': 'true',
        'experience_preferred': 'false',
      };
      final model = JobRequiredExperienceModel.fromJson(jsonMap);
      expect(model.noExperienceRequired, isTrue);
      expect(model.requiredExperienceInMonths, tRequiredExperienceInMonths);
      expect(model.experienceMentioned, isTrue);
      expect(model.experiencePreferred, isFalse);
    });

    test('toJson should return a valid JSON map', () {
      final model = JobRequiredExperienceModel(
        noExperienceRequired: tNoExperienceRequired,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );
      final jsonMap = model.toJson();
      expect(jsonMap, {
        'no_experience_required': tNoExperienceRequired,
        'required_experience_in_months': tRequiredExperienceInMonths,
        'experience_mentioned': tExperienceMentioned,
        'experience_preferred': tExperiencePreferred,
      });
    });

    test('toEntity should return a valid JobRequiredExperienceEntity', () {
      final model = JobRequiredExperienceModel(
        noExperienceRequired: tNoExperienceRequired,
        requiredExperienceInMonths: tRequiredExperienceInMonths,
        experienceMentioned: tExperienceMentioned,
        experiencePreferred: tExperiencePreferred,
      );
      final entity = model.toEntity();
      expect(entity.noExperienceRequired, tNoExperienceRequired);
      expect(entity.requiredExperienceInMonths, tRequiredExperienceInMonths);
      expect(entity.experienceMentioned, tExperienceMentioned);
      expect(entity.experiencePreferred, tExperiencePreferred);
    });
  });
}
