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
        (failure) => emit(SalaryEstimationError(message: failure.toString())),
        (salaryEstimations) => emit(SalaryEstimationLoaded(salaryEstimations)),
      );
    });

    on<ResetSalaryEstimationsEvent>((event, emit) async {
      emit(SalaryEstimationInitial());
    });
  }
}
