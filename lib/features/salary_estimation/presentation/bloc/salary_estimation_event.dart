part of 'salary_estimation_bloc.dart';

sealed class SalaryEstimationEvent extends Equatable {
  const SalaryEstimationEvent();
}

class GetSalaryEstimationsEvent extends SalaryEstimationEvent {
  final String jobTitle;
  final String location;
  final String radius;

  GetSalaryEstimationsEvent({
    required this.jobTitle,
    required this.location,
    this.radius= "100",
  });

  @override
  List<Object> get props => [jobTitle, location, radius];
}
