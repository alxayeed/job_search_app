import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:job_search_app/core/widgets/show_error_widget.dart';
import 'package:job_search_app/features/salary_estimation/presentation/pages/salary_estimation_screen.dart';
import 'package:job_search_app/features/salary_estimation/presentation/bloc/bloc.dart';
import 'package:job_search_app/features/salary_estimation/presentation/widgets/salary_search_form_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../widgets/salary_search_form_widget_test.mocks.dart';

@GenerateMocks([SalaryEstimationBloc])
void main() {
  late MockSalaryEstimationBloc mockBloc;

  setUpAll(() {
    provideDummy<SalaryEstimationState>(SalaryEstimationInitial());
  });

  setUp(() {
    if (GetIt.I.isRegistered<SalaryEstimationBloc>()) {
      GetIt.I.unregister<SalaryEstimationBloc>();
    }

    mockBloc = MockSalaryEstimationBloc();
    GetIt.I.registerSingleton<SalaryEstimationBloc>(mockBloc);

    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(SalaryEstimationLoading()));
  });

  tearDownAll(() {
    GetIt.I.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<SalaryEstimationBloc>(
        create: (_) => mockBloc,
        child: const SalaryEstimationScreen(),
      ),
    );
  }

  group('SalaryEstimationScreen Widget Tests', () {
    testWidgets('renders the initial state with form and empty message',
        (WidgetTester tester) async {
      when(mockBloc.state).thenReturn(SalaryEstimationInitial());
      when(mockBloc.stream)
          .thenAnswer((_) => Stream.value(SalaryEstimationInitial()));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(SalarySearchFormWidget), findsNWidgets(1));
      expect(find.text("Start your job search"), findsOneWidget);
    });

    testWidgets(
        'shows lottie animation when SalaryEstimationLoading state is emitted',
        (tester) async {
      when(mockBloc.state).thenReturn(SalaryEstimationLoading());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Lottie), findsOneWidget);
    });

    testWidgets(
      'shows error Widget when SalaryEstimationError state is emitted',
      (tester) async {
        when(mockBloc.state).thenReturn(
            SalaryEstimationError(message: "Please try again later!"));
        when(mockBloc.stream).thenAnswer((_) => Stream.value(
            SalaryEstimationError(message: "Please try again later!")));

        await tester.pumpWidget(createWidgetUnderTest());

        // Allow the widget to rebuild after the state change
        await tester.pumpAndSettle();

        expect(find.byType(ShowErrorWidget), findsOneWidget);
        expect(find.byIcon(Icons.error_outline), findsOneWidget);
        expect(find.text('Something went wrong!'), findsOneWidget);

        // Optional: Check for specific error message
        expect(find.text('Please try again later!'), findsOneWidget);
      },
    );

    // Uncomment and complete these tests as needed

    // testWidgets(
    //     'shows salary estimations when SalaryEstimationLoaded state is emitted',
    //     (tester) async {
    //   final salaryEstimations = [
    //     SalaryEstimationEntity(
    //         jobTitle: 'Software Developer',
    //         location: 'NYC',
    //         minimumSalary: 100000,
    //         maximumSalary: 120000,
    //         medianSalary: 110000),
    //     SalaryEstimationEntity(
    //         jobTitle: 'Data Scientist',
    //         location: 'SF',
    //         minimumSalary: 120000,
    //         maximumSalary: 140000,
    //         medianSalary: 130000),
    //   ];

    //   when(mockBloc.state)
    //       .thenReturn(SalaryEstimationLoaded(salaryEstimations));

    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pump();

    //   expect(find.text('Software Developer'), findsOneWidget);
    //   expect(find.text('Data Scientist'), findsOneWidget);
    //   expect(find.byType(SalaryEstimationCard), findsNWidgets(2));
    // });
  });
}
