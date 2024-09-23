// Mocks generated by Mockito 5.4.4 from annotations
// in job_search_app/test/features/salary_estimation/presentation/bloc/salary_estimation_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:job_search_app/core/error/job_failure.dart' as _i6;
import 'package:job_search_app/features/salary_estimation/domain/entities/entities.dart'
    as _i7;
import 'package:job_search_app/features/salary_estimation/domain/repositories/repositories.dart'
    as _i2;
import 'package:job_search_app/features/salary_estimation/domain/usecases/get_salary_estimation_use_case.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSalaryEstimationRepository_0 extends _i1.SmartFake
    implements _i2.SalaryEstimationRepository {
  _FakeSalaryEstimationRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetSalaryEstimationUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSalaryEstimationUseCase extends _i1.Mock
    implements _i4.GetSalaryEstimationUseCase {
  MockGetSalaryEstimationUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SalaryEstimationRepository get salaryEstimationRepository =>
      (super.noSuchMethod(
        Invocation.getter(#salaryEstimationRepository),
        returnValue: _FakeSalaryEstimationRepository_0(
          this,
          Invocation.getter(#salaryEstimationRepository),
        ),
      ) as _i2.SalaryEstimationRepository);

  @override
  _i5.Future<_i3.Either<_i6.JobFailure, List<_i7.SalaryEstimationEntity>>>
      call({
    required String? jobTitle,
    required String? location,
    String? radius = r'100',
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #call,
              [],
              {
                #jobTitle: jobTitle,
                #location: location,
                #radius: radius,
              },
            ),
            returnValue: _i5.Future<
                    _i3.Either<_i6.JobFailure,
                        List<_i7.SalaryEstimationEntity>>>.value(
                _FakeEither_1<_i6.JobFailure, List<_i7.SalaryEstimationEntity>>(
              this,
              Invocation.method(
                #call,
                [],
                {
                  #jobTitle: jobTitle,
                  #location: location,
                  #radius: radius,
                },
              ),
            )),
          ) as _i5.Future<
              _i3.Either<_i6.JobFailure, List<_i7.SalaryEstimationEntity>>>);
}
