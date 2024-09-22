import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/job_failure.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'salary_estimation_event.dart';
part 'salary_estimation_state.dart';

class SalaryEstimationBloc
    extends Bloc<SalaryEstimationEvent, SalaryEstimationState> {
  final GetSalaryEstimationUseCase getSalaryEstimationUseCase;

  SalaryEstimationBloc({required this.getSalaryEstimationUseCase})
      : super(SalaryEstimationInitial()) {
    on<GetSalaryEstimationsEvent>((event, emit) async {
      emit(SalaryEstimationLoading());

      final Either<JobFailure, List<SalaryEstimationEntity>> result =
          await getSalaryEstimationUseCase(
        jobTitle: event.jobTitle,
        location: event.location,
        radius: event.radius,
      );

      result.fold(
        (failure) {
          // Emit an error state with a specific message
          emit(SalaryEstimationError(message: _mapFailureToMessage(failure)));
        },
        (salaryEstimations) => emit(SalaryEstimationLoaded(salaryEstimations)),
      );
    });

    on<ResetSalaryEstimationsEvent>((event, emit) async {
      emit(SalaryEstimationInitial());
    });
  }

  // Map JobFailure to user-friendly messages
  String _mapFailureToMessage(JobFailure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'Network failure. Please check your connection.';
      case ServerFailure:
        return 'Server error. Please try again later.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
