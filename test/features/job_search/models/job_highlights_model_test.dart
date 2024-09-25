import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/job_search/data/models/job_highlights_model.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_highlights_entity.dart';

void main() {
  const tQualifications = ['Bachelor\'s Degree', '3+ years experience'];
  const tResponsibilities = ['Develop software', 'Maintain documentation'];

  // Test the JobHighlightsModel class
  group('JobHighlightsModel', () {
    test('should be a subclass of JobHighlightsEntity', () {
      final jobHighlightsModel = JobHighlightsModel();
      expect(jobHighlightsModel, isA<JobHighlightsEntity>());
    });

    test('constructor should create a valid model from parameters', () {
      final model = JobHighlightsModel(
        qualifications: tQualifications,
        responsibilities: tResponsibilities,
      );
      expect(model.qualifications, tQualifications);
      expect(model.responsibilities, tResponsibilities);
    });

    test('fromJson should return a valid model', () {
      final jsonMap = {
        'Qualifications': tQualifications,
        'Responsibilities': tResponsibilities,
      };
      final model = JobHighlightsModel.fromJson(jsonMap);
      expect(model.qualifications, tQualifications);
      expect(model.responsibilities, tResponsibilities);
    });

    test('toJson should return a valid JSON map', () {
      final model = JobHighlightsModel(
        qualifications: tQualifications,
        responsibilities: tResponsibilities,
      );
      final jsonMap = model.toJson();
      expect(jsonMap, {
        'Qualifications': tQualifications,
        'Responsibilities': tResponsibilities,
      });
    });

    test('toEntity should return a valid JobHighlightsEntity', () {
      final model = JobHighlightsModel(
        qualifications: tQualifications,
        responsibilities: tResponsibilities,
      );
      final entity = model.toEntity();
      expect(entity.qualifications, tQualifications);
      expect(entity.responsibilities, tResponsibilities);
    });
  });
}
