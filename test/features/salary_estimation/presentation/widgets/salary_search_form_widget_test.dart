import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/core/widgets/custom_text_field.dart';
import 'package:job_search_app/features/salary_estimation/presentation/bloc/salary_estimation_bloc.dart';
import 'package:job_search_app/features/salary_estimation/presentation/widgets/salary_search_form_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'salary_search_form_widget_test.mocks.dart';

@GenerateMocks([SalaryEstimationBloc])
void main() {
  group('SalarySearchFormWidget Tests', () {
    late TextEditingController jobTitleController;
    late TextEditingController locationController;
    late MockSalaryEstimationBloc salaryEstimationBloc;

    setUpAll(() {
      provideDummy<SalaryEstimationState>(SalaryEstimationInitial());
    });

    setUp(() {
      jobTitleController = TextEditingController();
      locationController = TextEditingController();
      salaryEstimationBloc = MockSalaryEstimationBloc();

      // Stub the state to return an initial state
      when(salaryEstimationBloc.state).thenReturn(SalaryEstimationInitial());

      // Stub the stream to return an empty stream
      when(salaryEstimationBloc.stream).thenAnswer((_) => Stream.empty());
    });

    tearDown(() {
      jobTitleController.dispose();
      locationController.dispose();
    });

    testWidgets('should render SalarySearchFormWidget correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => salaryEstimationBloc,
            child: Scaffold(
              body: SalarySearchFormWidget(
                jobTitleController: jobTitleController,
                locationController: locationController,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomTextField), findsNWidgets(2));
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('should display the correct job title hint text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => salaryEstimationBloc,
            child: Scaffold(
              body: SalarySearchFormWidget(
                jobTitleController: jobTitleController,
                locationController: locationController,
              ),
            ),
          ),
        ),
      );

      final jobTitleFieldFinder = find.byWidgetPredicate((widget) =>
          widget is CustomTextField && widget.hintText == 'Enter Job Title...');
      expect(jobTitleFieldFinder, findsOneWidget);
    });

    testWidgets('should display the correct location hint text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => salaryEstimationBloc,
            child: Scaffold(
              body: SalarySearchFormWidget(
                jobTitleController: jobTitleController,
                locationController: locationController,
              ),
            ),
          ),
        ),
      );

      final locationFieldFinder = find.byWidgetPredicate((widget) =>
          widget is CustomTextField && widget.hintText == 'Enter Location...');
      expect(locationFieldFinder, findsOneWidget);
    });

    testWidgets('should validate job title field', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => salaryEstimationBloc,
            child: Scaffold(
              body: SalarySearchFormWidget(
                jobTitleController: jobTitleController,
                locationController: locationController,
              ),
            ),
          ),
        ),
      );

      // Tap the search button without entering any values
      await tester.tap(find.text('Search'));
      await tester.pump();

      expect(find.text('Job Title is required'), findsOneWidget);
    });

    testWidgets('should have correct button color and style',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => salaryEstimationBloc,
            child: Scaffold(
              body: SalarySearchFormWidget(
                jobTitleController: jobTitleController,
                locationController: locationController,
              ),
            ),
          ),
        ),
      );

      final ElevatedButton button =
          tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.style?.backgroundColor?.resolve({}), Colors.blueAccent);
      expect(button.style?.elevation?.resolve({}), 5);
    });

    testWidgets('should display validator error message when input is invalid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => salaryEstimationBloc,
            child: Scaffold(
              body: SalarySearchFormWidget(
                jobTitleController: jobTitleController,
                locationController: locationController,
              ),
            ),
          ),
        ),
      );

      // Leave inputs empty and tap the Search button
      await tester.tap(find.text('Search'));
      await tester.pump(); // Rebuild the widget after interaction

      expect(find.text('Job Title is required'), findsOneWidget);
      expect(find.text('Location is required'), findsOneWidget);
    });

    testWidgets('should accept user input and update controller text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => salaryEstimationBloc,
            child: Scaffold(
              body: SalarySearchFormWidget(
                jobTitleController: jobTitleController,
                locationController: locationController,
              ),
            ),
          ),
        ),
      );

      // Act: Enter text in the job title and location fields
      await tester.enterText(
          find.byType(CustomTextField).first, 'Software Engineer');
      await tester.enterText(find.byType(CustomTextField).last, 'New York');
      await tester.pump(); // Rebuild after text entry

      // Assert: Check if controllers are updated
      expect(jobTitleController.text, 'Software Engineer');
      expect(locationController.text, 'New York');
    });

    testWidgets('should dispatch GetSalaryEstimationsEvent when form is valid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SalaryEstimationBloc>(
            create: (context) => salaryEstimationBloc,
            child: Scaffold(
              body: SalarySearchFormWidget(
                jobTitleController: jobTitleController,
                locationController: locationController,
              ),
            ),
          ),
        ),
      );

      // Act: Fill the form with valid data
      await tester.enterText(find.byType(TextField).first, 'Software Engineer');
      await tester.enterText(find.byType(TextField).last, 'New York');
      await tester.pump(); // Rebuild after text entry

      // Act: Tap the Search button
      await tester.tap(find.text('Search'));
      await tester.pump(); // Rebuild after interaction

      // Assert: Verify that the event was added to the bloc
      verify(salaryEstimationBloc.add(
        GetSalaryEstimationsEvent(
          jobTitle: 'Software Engineer',
          location: 'New York',
        ),
      )).called(1);
    });
  });
}
