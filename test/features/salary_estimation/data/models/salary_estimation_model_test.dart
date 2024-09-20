import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/features/salary_estimation/data/models/salary_estimation_model.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/entities.dart';

void main() {
  final tSalaryEstimationModel = SalaryEstimationModel(
    location: 'New York',
    jobTitle: 'Software Engineer',
    publisherName: 'Tech Corp',
    publisherLink: 'https://techcorp.com',
    minimumSalary: 80000.0,
    maximumSalary: 120000.0,
    medianSalary: 100000.0,
    salaryPeriod: 'Yearly',
    salaryCurrency: 'USD',
  );

  final tSalaryEstimationJson = {
    "location": 'New York',
    "job_title": 'Software Engineer',
    "publisher_name": 'Tech Corp',
    "publisher_link": 'https://techcorp.com',
    "min_salary": 80000.0,
    "max_salary": 120000.0,
    "median_salary": 100000.0,
    "salary_period": 'Yearly',
    "salary_currency": 'USD',
  };

  final tNullSalaryEstimationJson = {
    "location": 'New York',
    "job_title": 'Software Engineer',
    "publisher_name": 'Tech Corp',
    "publisher_link": 'https://techcorp.com',
    "min_salary": null,
    "max_salary": null,
    "median_salary": null,
    "salary_period": 'Yearly',
    "salary_currency": 'USD',
  };

  group('fromJson', () {
    test('should correctly convert from JSON to model', () {
      // Act
      final result = SalaryEstimationModel.fromJson(tSalaryEstimationJson);

      // Assert
      expect(result, tSalaryEstimationModel);
      expect(result.minimumSalary, 80000.0);
      expect(result.maximumSalary, 120000.0);
      expect(result.medianSalary, 100000.0);
    });

    test('should handle null salary values in fromJson', () {
      // Act
      final result = SalaryEstimationModel.fromJson(tNullSalaryEstimationJson);

      // Assert
      expect(result.minimumSalary, null);
      expect(result.maximumSalary, null);
      expect(result.medianSalary, null);
      expect(result.salaryCurrency, 'USD');
    });

    test('should handle empty JSON without errors', () {
      // Act
      final result = SalaryEstimationModel.fromJson({});

      // Assert
      expect(result.location, null);
      expect(result.jobTitle, null);
      expect(result.publisherName, null);
      expect(result.publisherLink, null);
      expect(result.minimumSalary, null);
      expect(result.maximumSalary, null);
      expect(result.medianSalary, null);
      expect(result.salaryPeriod, null);
      expect(result.salaryCurrency, null);
    });

    test('should handle double conversion from JSON correctly', () {
      // Arrange
      final jsonWithIntSalary = {
        "location": 'New York',
        "job_title": 'Software Engineer',
        "publisher_name": 'Tech Corp',
        "publisher_link": 'https://techcorp.com',
        "min_salary": 80000, // Integer value in JSON
        "max_salary": 120000,
        "median_salary": 100000,
        "salary_period": 'Yearly',
        "salary_currency": 'USD',
      };

      // Act
      final result = SalaryEstimationModel.fromJson(jsonWithIntSalary);

      // Assert
      expect(result.minimumSalary, 80000.0); // Expect double
      expect(result.maximumSalary, 120000.0);
      expect(result.medianSalary, 100000.0);
    });
  });

  group('toJson', () {
    test('should correctly convert from model to JSON', () {
      // Act
      final result = tSalaryEstimationModel.toJson();

      // Assert
      expect(result, tSalaryEstimationJson);
    });

    test('should return correct JSON structure when some values are null', () {
      // Arrange
      final modelWithNullSalaries = SalaryEstimationModel(
        location: 'New York',
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Corp',
        publisherLink: 'https://techcorp.com',
        minimumSalary: null,
        maximumSalary: null,
        medianSalary: null,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      final expectedJson = {
        "location": 'New York',
        "job_title": 'Software Engineer',
        "publisher_name": 'Tech Corp',
        "publisher_link": 'https://techcorp.com',
        "min_salary": null,
        "max_salary": null,
        "median_salary": null,
        "salary_period": 'Yearly',
        "salary_currency": 'USD',
      };

      // Act
      final result = modelWithNullSalaries.toJson();

      // Assert
      expect(result, expectedJson);
    });
  });

  group('toEntity', () {
    test('should convert model to entity correctly', () {
      // Act
      final entity = tSalaryEstimationModel.toEntity();

      // Assert
      expect(entity, isA<SalaryEstimationEntity>());
      expect(entity.location, tSalaryEstimationModel.location);
      expect(entity.jobTitle, tSalaryEstimationModel.jobTitle);
      expect(entity.publisherName, tSalaryEstimationModel.publisherName);
      expect(entity.publisherLink, tSalaryEstimationModel.publisherLink);
      expect(entity.minimumSalary, tSalaryEstimationModel.minimumSalary);
      expect(entity.maximumSalary, tSalaryEstimationModel.maximumSalary);
      expect(entity.medianSalary, tSalaryEstimationModel.medianSalary);
      expect(entity.salaryPeriod, tSalaryEstimationModel.salaryPeriod);
      expect(entity.salaryCurrency, tSalaryEstimationModel.salaryCurrency);
    });
  });
}
