import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/job_search/data/models/apply_options_model.dart';
import 'package:job_search_app/features/job_search/domain/entities/apply_options_entity.dart';

void main() {
  const tPublisher = 'Publisher Name';
  const tApplyLink = 'http://example.com/apply';
  const tIsDirect = true;

  // Test the ApplyOptionModel class
  group('ApplyOptionModel', () {
    test('should be a subclass of ApplyOptionEntity', () {
      final applyOptionModel = ApplyOptionModel();
      expect(applyOptionModel, isA<ApplyOptionEntity>());
    });

    test('constructor should create a valid model from parameters', () {
      final model = ApplyOptionModel(
        publisher: tPublisher,
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );
      expect(model.publisher, tPublisher);
      expect(model.applyLink, tApplyLink);
      expect(model.isDirect, tIsDirect);
    });

    test('fromJson should return a valid model', () {
      final jsonMap = {
        'publisher': tPublisher,
        'apply_link': tApplyLink,
        'is_direct': tIsDirect,
      };
      final model = ApplyOptionModel.fromJson(jsonMap);
      expect(model.publisher, tPublisher);
      expect(model.applyLink, tApplyLink);
      expect(model.isDirect, tIsDirect);
    });

    test('toJson should return a valid JSON map', () {
      final model = ApplyOptionModel(
        publisher: tPublisher,
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );
      final jsonMap = model.toJson();
      expect(jsonMap, {
        'publisher': tPublisher,
        'apply_link': tApplyLink,
        'is_direct': tIsDirect,
      });
    });

    test('toEntity should return a valid ApplyOptionEntity', () {
      final model = ApplyOptionModel(
        publisher: tPublisher,
        applyLink: tApplyLink,
        isDirect: tIsDirect,
      );
      final entity = model.toEntity();
      expect(entity.publisher, tPublisher);
      expect(entity.applyLink, tApplyLink);
      expect(entity.isDirect, tIsDirect);
    });
  });
}
