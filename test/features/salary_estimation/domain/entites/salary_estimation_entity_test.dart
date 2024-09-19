import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';

void main() {
  group('SalaryEstimationEntity', () {
    test('should be equal if all properties are the same', () {
      final entity1 = SalaryEstimationEntity(
        location: 'New York',
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Corp',
        publisherLink: 'https://techcorp.com',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      final entity2 = SalaryEstimationEntity(
        location: 'New York',
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Corp',
        publisherLink: 'https://techcorp.com',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      expect(entity1, equals(entity2));
    });

    test('should create a copy with updated values', () {
      final original = SalaryEstimationEntity(
        location: 'New York',
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Corp',
        publisherLink: 'https://techcorp.com',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      final updated = original.copyWith(
        location: 'San Francisco',
        maximumSalary: 130000,
      );

      expect(updated.location, 'San Francisco');
      expect(updated.maximumSalary, 130000);
      expect(updated.minimumSalary, original.minimumSalary);
      expect(updated.jobTitle, original.jobTitle);
      expect(updated.publisherName, original.publisherName);
      expect(updated.publisherLink, original.publisherLink);
      expect(updated.medianSalary, original.medianSalary);
      expect(updated.salaryPeriod, original.salaryPeriod);
      expect(updated.salaryCurrency, original.salaryCurrency);
    });

    test('should not be equal if properties are different', () {
      final entity1 = SalaryEstimationEntity(
        location: 'New York',
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Corp',
        publisherLink: 'https://techcorp.com',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      final entity2 = SalaryEstimationEntity(
        location: 'San Francisco',
        jobTitle: 'Data Scientist',
        publisherName: 'Data Inc',
        publisherLink: 'https://datainc.com',
        minimumSalary: 90000,
        maximumSalary: 130000,
        medianSalary: 110000,
        salaryPeriod: 'Monthly',
        salaryCurrency: 'EUR',
      );

      expect(entity1, isNot(equals(entity2)));
    });

    test('should convert to model correctly', () {
      final entity = SalaryEstimationEntity(
        location: 'New York',
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Corp',
        publisherLink: 'https://techcorp.com',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      final model = entity.toModel();

      expect(model.location, entity.location);
      expect(model.jobTitle, entity.jobTitle);
      expect(model.publisherName, entity.publisherName);
      expect(model.publisherLink, entity.publisherLink);
      expect(model.minimumSalary, entity.minimumSalary);
      expect(model.maximumSalary, entity.maximumSalary);
      expect(model.medianSalary, entity.medianSalary);
      expect(model.salaryPeriod, entity.salaryPeriod);
      expect(model.salaryCurrency, entity.salaryCurrency);
    });

    test('should handle null properties in copyWith', () {
      final original = SalaryEstimationEntity(
        location: 'New York',
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Corp',
        publisherLink: 'https://techcorp.com',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      final updated = original.copyWith(
        location: null,
        jobTitle: null,
        publisherName: null,
        publisherLink: null,
        minimumSalary: null,
        maximumSalary: null,
        medianSalary: null,
        salaryPeriod: null,
        salaryCurrency: null,
      );

      expect(updated.location, original.location);
      expect(updated.jobTitle, original.jobTitle);
      expect(updated.publisherName, original.publisherName);
      expect(updated.publisherLink, original.publisherLink);
      expect(updated.minimumSalary, original.minimumSalary);
      expect(updated.maximumSalary, original.maximumSalary);
      expect(updated.medianSalary, original.medianSalary);
      expect(updated.salaryPeriod, original.salaryPeriod);
      expect(updated.salaryCurrency, original.salaryCurrency);
    });

    test('should correctly update only specified properties', () {
      final original = SalaryEstimationEntity(
        location: 'New York',
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Corp',
        publisherLink: 'https://techcorp.com',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      final updated = original.copyWith(
        location: 'San Francisco',
        minimumSalary: 90000,
      );

      expect(updated.location, 'San Francisco');
      expect(updated.jobTitle, original.jobTitle);
      expect(updated.publisherName, original.publisherName);
      expect(updated.publisherLink, original.publisherLink);
      expect(updated.minimumSalary, 90000);
      expect(updated.maximumSalary, original.maximumSalary);
      expect(updated.medianSalary, original.medianSalary);
      expect(updated.salaryPeriod, original.salaryPeriod);
      expect(updated.salaryCurrency, original.salaryCurrency);
    });
  });
}
