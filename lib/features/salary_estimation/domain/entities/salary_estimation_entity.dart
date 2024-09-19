import 'package:equatable/equatable.dart';
import 'package:job_search_app/features/salary_estimation/data/models/models.dart';

class SalaryEstimationEntity extends Equatable {
  final String? location;
  final String? jobTitle;
  final String? publisherName;
  final String? publisherLink;
  final double? minimumSalary;
  final double? maximumSalary;
  final double? medianSalary;
  final String? salaryPeriod;
  final String? salaryCurrency;

  SalaryEstimationEntity({
    this.location,
    this.jobTitle,
    this.publisherName,
    this.publisherLink,
    this.minimumSalary,
    this.maximumSalary,
    this.medianSalary,
    this.salaryPeriod,
    this.salaryCurrency,
  });

  @override
  List<Object?> get props => [
        location,
        jobTitle,
        publisherName,
        publisherLink,
        minimumSalary,
        maximumSalary,
        medianSalary,
        salaryPeriod,
        salaryCurrency,
      ];

  SalaryEstimationEntity copyWith({
    String? location,
    String? jobTitle,
    String? publisherName,
    String? publisherLink,
    double? minimumSalary,
    double? maximumSalary,
    double? medianSalary,
    String? salaryPeriod,
    String? salaryCurrency,
  }) {
    return SalaryEstimationEntity(
      location:  location ?? this.location,
      jobTitle: jobTitle ?? this.jobTitle,
      publisherName: publisherName ?? this.publisherName,
      publisherLink: publisherLink ?? this.publisherLink,
      minimumSalary: minimumSalary ?? this.minimumSalary,
      maximumSalary: maximumSalary ?? this.maximumSalary,
      medianSalary: medianSalary ?? this.medianSalary,
      salaryPeriod:  salaryPeriod ?? this.salaryPeriod,
      salaryCurrency: salaryCurrency ?? this.salaryCurrency
    );
  }

SalaryEstimationModel toModel(){
    return SalaryEstimationModel(
        location:  location,
        jobTitle: jobTitle,
        publisherName: publisherName,
        publisherLink: publisherLink,
        minimumSalary: minimumSalary,
        maximumSalary: maximumSalary,
        medianSalary: medianSalary,
        salaryPeriod:  salaryPeriod,
        salaryCurrency: salaryCurrency
    );
}
}
