import 'package:job_search_app/features/salary_estimation/domain/entities/entities.dart';

class SalaryEstimationModel extends SalaryEstimationEntity {
  SalaryEstimationModel({
    String? location,
    String? jobTitle,
    String? publisherName,
    String? publisherLink,
    double? minimumSalary,
    double? maximumSalary,
    double? medianSalary,
    String? salaryPeriod,
    String? salaryCurrency,
  }) : super(
            location: location,
            jobTitle: jobTitle,
            publisherName: publisherName,
            publisherLink: publisherLink,
            minimumSalary: minimumSalary,
            maximumSalary: maximumSalary,
            medianSalary: medianSalary,
            salaryPeriod: salaryPeriod,
            salaryCurrency: salaryCurrency);

  factory SalaryEstimationModel.fromJson(Map<String, dynamic> json) {
    return SalaryEstimationModel(
      location: json["location"],
      jobTitle: json["job_title"],
      publisherName: json["publisher_name"],
      publisherLink: json["publisher_link"],
      minimumSalary: json["min_salary"].toDouble(),
      maximumSalary: json["max_salary"].toDouble(),
      medianSalary: json["median_salary"].toDouble(),
      salaryPeriod: json["salary_period"],
      salaryCurrency: json["salary_currency"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "location": location,
      "job_title": jobTitle,
      "publisher_name": publisherName,
      "publisher_link": publisherLink,
      "min_salary": minimumSalary,
      "max_salary": maximumSalary,
      "median_salary": medianSalary,
      "salary_period": salaryPeriod,
      "salary_currency": salaryCurrency,
    };
  }

  SalaryEstimationEntity toEntity() {
    return SalaryEstimationEntity(
        location: location,
        jobTitle: jobTitle,
        publisherName: publisherName,
        publisherLink: publisherLink,
        minimumSalary: minimumSalary,
        maximumSalary: maximumSalary,
        medianSalary: medianSalary,
        salaryPeriod: salaryPeriod,
        salaryCurrency: salaryCurrency);
  }
}
