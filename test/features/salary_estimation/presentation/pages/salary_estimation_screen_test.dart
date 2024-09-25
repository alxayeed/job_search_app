import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:job_search_app/core/widgets/show_error_widget.dart';
import 'package:job_search_app/features/job_search/presentation/widgets/app_drawer.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:job_search_app/features/salary_estimation/presentation/pages/salary_estimation_screen.dart';
import 'package:job_search_app/features/salary_estimation/presentation/bloc/bloc.dart';
import 'package:job_search_app/features/salary_estimation/presentation/widgets/salary_estimation_card.dart';
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

    testWidgets(
        'shows salary estimations when SalaryEstimationLoaded state is emitted',
        (tester) async {
      final salaryEstimations = [
        SalaryEstimationEntity(
            jobTitle: 'Software Developer',
            location: 'NYC',
            minimumSalary: 100000,
            maximumSalary: 120000,
            medianSalary: 110000),
        SalaryEstimationEntity(
            jobTitle: 'Data Scientist',
            location: 'SF',
            minimumSalary: 120000,
            maximumSalary: 140000,
            medianSalary: 130000),
      ];

      when(mockBloc.state)
          .thenReturn(SalaryEstimationLoaded(salaryEstimations));
      when(mockBloc.stream).thenAnswer(
          (_) => Stream.value(SalaryEstimationLoaded(salaryEstimations)));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('Software Developer'), findsOneWidget);
      expect(find.text('Data Scientist'), findsOneWidget);
      expect(find.byType(SalaryEstimationCard), findsNWidgets(2));
    });

    testWidgets('renders the AppBar with correct title', (tester) async {
      when(mockBloc.state).thenReturn(SalaryEstimationInitial());
      when(mockBloc.stream)
          .thenAnswer((_) => Stream.value(SalaryEstimationInitial()));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      // Check for the AppBar
      expect(find.byType(AppBar), findsOneWidget);
      // Check if the title is correct
      expect(find.text('Salary Estimation'), findsOneWidget);
    });

    testWidgets('renders the drawer menu', (tester) async {
      when(mockBloc.state).thenReturn(SalaryEstimationInitial());
      when(mockBloc.stream)
          .thenAnswer((_) => Stream.value(SalaryEstimationInitial()));

      await tester.pumpWidget(createWidgetUnderTest());

      final Finder drawerOpenButton = find.byIcon(Icons.menu);
      expect(drawerOpenButton, findsOneWidget);

      // Simulate a tap on the menu button to open the drawer
      await tester.tap(drawerOpenButton);
      await tester.pumpAndSettle();

      // Check for the Drawer widget
      expect(find.byType(AppDrawer), findsOneWidget);

      // Optionally, check for specific items in the drawer
      // expect(find.text('Search job'), findsOneWidget);
      // expect(find.text('Salary estimation'), findsOneWidget);
      // expect(find.text('Saved jobs'), findsOneWidget);
    });

    testWidgets(
        'shows multiple salary estimation cards and allows scrolling when results are large',
        (tester) async {
      final salaryEstimations = List.generate(
        50,
        (index) => SalaryEstimationEntity(
          jobTitle: 'Job Title $index',
          location: 'Location $index',
          minimumSalary: 50000 + index * 1000,
          maximumSalary: 60000 + index * 1000,
          medianSalary: 55000 + index * 1000,
        ),
      );

      when(mockBloc.state)
          .thenReturn(SalaryEstimationLoaded(salaryEstimations));
      when(mockBloc.stream).thenAnswer(
          (_) => Stream.value(SalaryEstimationLoaded(salaryEstimations)));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Check that there are multiple salary estimation cards
      expect(find.byType(SalaryEstimationCard), findsAny); // Initial load

      // Perform scrolling down action
      await tester.fling(find.byType(ListView), const Offset(0, -500), 1000);
      await tester.pumpAndSettle();

      // After scroll, more salary estimations should be visible
      expect(find.byType(SalaryEstimationCard), findsAny);

      // Perform scrolling up action
      await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
      await tester.pumpAndSettle();

      // After scroll, more salary estimations should be visible
      expect(find.byType(SalaryEstimationCard), findsAny);
    });

    testWidgets(
        'maintains scroll position after emitting SalaryEstimationLoaded',
        (tester) async {
      final salaryEstimations = List.generate(
        20,
        (index) => SalaryEstimationEntity(
          jobTitle: 'Job Title $index',
          location: 'Location $index',
          minimumSalary: 50000 + index * 1000,
          maximumSalary: 60000 + index * 1000,
          medianSalary: 55000 + index * 1000,
        ),
      );

      when(mockBloc.state)
          .thenReturn(SalaryEstimationLoaded(salaryEstimations));
      when(mockBloc.stream).thenAnswer(
          (_) => Stream.value(SalaryEstimationLoaded(salaryEstimations)));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Scroll down
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Emit new state
      when(mockBloc.state)
          .thenReturn(SalaryEstimationLoaded(salaryEstimations));
      await tester.pumpAndSettle();

      // Ensure the scroll position is maintained
      // expect(find.text('Job Title 1'), findsAny);
      expect(find.text('Min Salary: 50000.00'), findsAny);
    });
  });

  //NEW
  group('Additional SalaryEstimationScreen Widget Tests', () {
    // testWidgets('displays "No Results Found" when SalaryEstimationLoaded has empty list', (tester) async {
    //   when(mockBloc.state).thenReturn(SalaryEstimationLoaded([]));
    //   when(mockBloc.stream).thenAnswer((_) => Stream.value(SalaryEstimationLoaded([])));
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pumpAndSettle();
    //
    //   // Check that a no results message is shown
    //   expect(find.text('No Results Found'), findsOneWidget);
    // });

    // testWidgets('displays pagination loading indicator when more results are being fetched', (tester) async {
    //   final salaryEstimations = List.generate(
    //     10,
    //         (index) => SalaryEstimationEntity(
    //       jobTitle: 'Job Title $index',
    //       location: 'Location $index',
    //       minimumSalary: 50000 + index * 1000,
    //       maximumSalary: 60000 + index * 1000,
    //       medianSalary: 55000 + index * 1000,
    //     ),
    //   );
    //
    //   when(mockBloc.state).thenReturn(SalaryEstimationLoaded(salaryEstimations));
    //   when(mockBloc.stream).thenAnswer((_) => Stream.value(SalaryEstimationLoaded(salaryEstimations)));
    //   when(mockBloc.state).thenReturn(SalaryEstimationLoadingMore());
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pumpAndSettle();
    //
    //   // Ensure the initial estimations are displayed
    //   expect(find.byType(SalaryEstimationCard), findsNWidgets(10));
    //
    //   // Scroll to the bottom to trigger more loading
    //   await tester.fling(find.byType(ListView), const Offset(0, -500), 1000);
    //   await tester.pumpAndSettle();
    //
    //   // Check if the pagination loading indicator is visible
    //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // });

    // testWidgets('ensures error message is not duplicated', (tester) async {
    //   when(mockBloc.state).thenReturn(SalaryEstimationError(message: 'Custom Error Message'));
    //   when(mockBloc.stream).thenAnswer((_) => Stream.value(SalaryEstimationError(message: 'Custom Error Message')));
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pumpAndSettle();
    //
    //   // Ensure only one error message is shown
    //   expect(find.text('Custom Error Message'), findsOneWidget);
    //   expect(find.byType(ShowErrorWidget), findsOneWidget);
    // });

    // testWidgets('ensures form input persists after error', (tester) async {
    //   when(mockBloc.state).thenReturn(SalaryEstimationError(message: 'Something went wrong!'));
    //   when(mockBloc.stream).thenAnswer((_) => Stream.value(SalaryEstimationError(message: 'Something went wrong!')));
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pumpAndSettle();
    //
    //   // Simulate user input in the form
    //   await tester.enterText(find.byKey(Key('JobTitleInput')), 'Developer');
    //   await tester.enterText(find.byKey(Key('LocationInput')), 'New York');
    //
    //   // Trigger an error
    //   expect(find.byType(ShowErrorWidget), findsOneWidget);
    //
    //   // Ensure the form inputs persist after the error
    //   expect(find.text('Developer'), findsOneWidget);
    //   expect(find.text('New York'), findsOneWidget);
    // });
  });
}
