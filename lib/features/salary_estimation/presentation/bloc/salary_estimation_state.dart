part of 'salary_estimation_bloc.dart';

sealed class SalaryEstimationState extends Equatable {
  const SalaryEstimationState();
}

final class SalaryEstimationInitial extends SalaryEstimationState {
  @override
  List<Object> get props => [];
}

final class SalaryEstimationLoading extends SalaryEstimationState {
  @override
  List<Object> get props => [];
}

final class SalaryEstimationLoaded extends SalaryEstimationState {
  final List<SalaryEstimationEntity> salaryEstimations;

  SalaryEstimationLoaded(this.salaryEstimations);

  @override
  List<Object> get props => [salaryEstimations];
}

final class SalaryEstimationError extends SalaryEstimationState {
  final String message;

  SalaryEstimationError({required this.message});

  @override
  List<Object> get props => [message];
}
