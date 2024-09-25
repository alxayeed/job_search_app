import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/job_search/domain/entities/apply_options_entity.dart';

void main() {
  group('ApplyOptionEntity', () {
    const tPublisher = 'Test Publisher';
    const tApplyLink = 'https://applylink.com';
    const tIsDirect = true;

    test('should return correct props', () {
      final entity = ApplyOptionEntity(
        publisher: tPublisher,
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );

      expect(entity.props, [tPublisher, tApplyLink, tIsDirect]);
    });

    test('should consider two entities with same values as equal', () {
      final entity1 = ApplyOptionEntity(
        publisher: tPublisher,
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );

      final entity2 = ApplyOptionEntity(
        publisher: tPublisher,
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );

      expect(entity1, equals(entity2));
    });

    test('should consider two entities with different values as not equal', () {
      final entity1 = ApplyOptionEntity(
        publisher: tPublisher,
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );

      final entity2 = ApplyOptionEntity(
        publisher: 'Another Publisher',
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );

      expect(entity1, isNot(equals(entity2)));
    });

    test(
        'should return ApplyOptionModel with correct values when converting to model',
        () {
      final entity = ApplyOptionEntity(
        publisher: tPublisher,
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );

      final model = entity.toModel();

      expect(model.publisher, tPublisher);
      expect(model.applyLink, tApplyLink);
      expect(model.isDirect, tIsDirect);
    });

    test('should handle null values properly', () {
      final entity = ApplyOptionEntity(
        publisher: null,
        applyLink: null,
        isDirect: null,
      );

      expect(entity.props, [null, null, null]);

      final model = entity.toModel();

      expect(model.publisher, null);
      expect(model.applyLink, null);
      expect(model.isDirect, null);
    });
  });
}
