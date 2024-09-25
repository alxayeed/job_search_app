import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/job_search/domain/entities/job_highlights_entity.dart';

void main() {
  group('JobHighlightsEntity', () {
    const tQualifications = ['Qualification 1', 'Qualification 2'];
    const tResponsibilities = ['Responsibility 1', 'Responsibility 2'];

    test('should return correct props', () {
      final entity = JobHighlightsEntity(
        qualifications: tQualifications,
        responsibilities: tResponsibilities,
      );

      expect(entity.props, [tQualifications, tResponsibilities]);
    });

    test('should consider two entities with same values as equal', () {
      final entity1 = JobHighlightsEntity(
        qualifications: tQualifications,
        responsibilities: tResponsibilities,
      );

      final entity2 = JobHighlightsEntity(
        qualifications: tQualifications,
        responsibilities: tResponsibilities,
      );

      expect(entity1, equals(entity2));
    });

    test('should consider two entities with different values as not equal', () {
      final entity1 = JobHighlightsEntity(
        qualifications: tQualifications,
        responsibilities: tResponsibilities,
      );

      final entity2 = JobHighlightsEntity(
        qualifications: ['Other Qualification'],
        responsibilities: tResponsibilities,
      );

      expect(entity1, isNot(equals(entity2)));
    });

    test(
        'should return JobHighlightsModel with correct values when converting to model',
        () {
      final entity = JobHighlightsEntity(
        qualifications: tQualifications,
        responsibilities: tResponsibilities,
      );

      final model = entity.toModel();

      expect(model.qualifications, tQualifications);
      expect(model.responsibilities, tResponsibilities);
    });

    test('should handle null values properly', () {
      final entity = JobHighlightsEntity(
        qualifications: null,
        responsibilities: null,
      );

      expect(entity.props, [null, null]);

      final model = entity.toModel();

      expect(model.qualifications, null);
      expect(model.responsibilities, null);
    });

    test('should handle empty lists properly', () {
      final entity = JobHighlightsEntity(
        qualifications: [],
        responsibilities: [],
      );

      expect(entity.props, [[], []]);

      final model = entity.toModel();

      expect(model.qualifications, []);
      expect(model.responsibilities, []);
    });
  });
}
