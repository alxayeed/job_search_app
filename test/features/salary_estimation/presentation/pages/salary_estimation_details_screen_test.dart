import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/core/constants/app_strings.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:job_search_app/features/salary_estimation/presentation/pages/salary_estimation_details_screen.dart';

import 'mock_url_launcher_platform.dart';

void main() {
  group("SalaryEstimationDetailsScreen Tests", () {
    late SalaryEstimationEntity salaryEstimation;
    late MockUrlLauncher mockUrlLauncher;

    setUp(() {
      salaryEstimation = SalaryEstimationEntity(
        jobTitle: 'Software Engineer',
        location: 'New York',
        publisherName: 'Tech Company',
        publisherLink: 'https://techcompany.com', // Valid URL here
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        salaryPeriod: 'Yearly',
        salaryCurrency: 'USD',
      );

      mockUrlLauncher = MockUrlLauncher();
    });

    testWidgets("SalaryEstimationDetailsScreen displays correctly",
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalaryEstimationDetailsScreen(entity: salaryEstimation),
          ),
        ),
      );

      // Check that the app bar displays the job title
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Software Engineer'), findsAtLeast(1));

      // Verify that all the sections and their content are displayed correctly
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('Publisher'), findsOneWidget);
      expect(find.text('Min Salary'), findsOneWidget);
      expect(find.text('Max Salary'), findsOneWidget);
      expect(find.text('Median Salary'), findsOneWidget);
      expect(find.text('Salary Period'), findsOneWidget);
      expect(find.text('Currency'), findsOneWidget);

      // Verify salary values
      expect(find.text('80000.00'), findsOneWidget); // Min Salary
      expect(find.text('120000.00'), findsOneWidget); // Max Salary
      expect(find.text('100000.00'), findsOneWidget); // Median Salary
    });

    testWidgets("Verify section icons and colors", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalaryEstimationDetailsScreen(entity: salaryEstimation),
          ),
        ),
      );

      // Verify icons
      expect(find.byIcon(Icons.location_on), findsOneWidget);
      expect(find.byIcon(Icons.business), findsOneWidget);
      expect(find.byIcon(Icons.trending_down), findsOneWidget); // Min Salary
      expect(find.byIcon(Icons.trending_up), findsOneWidget); // Max Salary
      expect(find.byIcon(Icons.trending_flat), findsOneWidget); // Median Salary
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
      expect(find.byIcon(Icons.money), findsOneWidget); // Currency

      // Verify salary section colors
      final minSalaryText = find.text('80000.00');
      final maxSalaryText = find.text('120000.00');
      final medianSalaryText = find.text('100000.00');

      expect(tester.widget<Text>(minSalaryText).style?.color,
          equals(Colors.green));
      expect(
          tester.widget<Text>(maxSalaryText).style?.color, equals(Colors.red));
      expect(tester.widget<Text>(medianSalaryText).style?.color,
          equals(Colors.blue));
    });

    // testWidgets("Publisher section is clickable and triggers launch for valid URL", (tester) async {
    //   // Set up the mock to return true when launching a valid URL.
    //   mockUrlLauncher.setLaunchExpectations(
    //     url: 'https://techcompany.com',
    //     enableJavaScript: true,
    //     enableDomStorage: true,
    //     useSafariVC: false,
    //     useWebView: false,
    //     universalLinksOnly: false,
    //     headers: {},
    //     webOnlyWindowName: null,
    //   );
    //   mockUrlLauncher.setResponse(true); // Mock the response to be successful.
    //
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: Scaffold(
    //         body: SalaryEstimationDetailsScreen(entity: salaryEstimation),
    //       ),
    //     ),
    //   );
    //
    //   // Allow time for the widget to be built
    //   await tester.pumpAndSettle();
    //
    //   // Simulate tap on the Publisher section
    //   await tester.tap(find.text('Tech Company'));
    //   await tester.pumpAndSettle();
    //
    //   // Check if the launch method was called
    //   expect(mockUrlLauncher.launchCalled, isTrue, reason: 'The launch method was not called');
    //
    //   // Verify the parameters passed to the launch method
    //   verify(mockUrlLauncher.launch(
    //     'https://techcompany.com',
    //     useSafariVC: false,
    //     useWebView: false,
    //     enableJavaScript: true,
    //     enableDomStorage: true,
    //     universalLinksOnly: false,
    //     headers: {},
    //     webOnlyWindowName: null,
    //   )).called(1);
    // });

    testWidgets("Publisher section should not call _launchURL with null URL",
        (tester) async {
      // Set publisherLink to null for this test
      final salaryEstimationWithNullLink = SalaryEstimationEntity(
        jobTitle: 'Software Engineer',
        location: 'New York',
        publisherName: 'Tech Company',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        publisherLink: null,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalaryEstimationDetailsScreen(
                entity: salaryEstimationWithNullLink),
          ),
        ),
      );

      // Simulate tap on the Publisher section
      await tester.tap(find.text('Tech Company'));
      await tester.pumpAndSettle();

      // Verify that the _launchURL function was not called
      expect(mockUrlLauncher.canLaunchCalled, isFalse);
      expect(mockUrlLauncher.launchCalled, isFalse);
    });

    testWidgets('displays "N/A" when publisherName is null',
        (WidgetTester tester) async {
      final salaryEstimation = SalaryEstimationEntity(
        jobTitle: 'Software Engineer',
        publisherName: null,
        location: 'New York',
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        publisherLink: 'https://techcompany.com',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalaryEstimationDetailsScreen(
              entity: salaryEstimation,
            ),
          ),
        ),
      );

      expect(find.text(AppStrings.notApplicable), findsOneWidget);
    });

    testWidgets('displays "N/A" when location is null',
        (WidgetTester tester) async {
      final salaryEstimation = SalaryEstimationEntity(
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Company',
        location: null,
        minimumSalary: 80000,
        maximumSalary: 120000,
        medianSalary: 100000,
        publisherLink: 'https://techcompany.com',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalaryEstimationDetailsScreen(
              entity: salaryEstimation,
            ),
          ),
        ),
      );

      expect(find.text(AppStrings.notApplicable), findsOneWidget);
    });

    testWidgets('displays fallback text for null salary range',
        (WidgetTester tester) async {
      final salaryEstimation = SalaryEstimationEntity(
        jobTitle: 'Software Engineer',
        publisherName: 'Tech Company',
        location: 'New York',
        minimumSalary: null,
        maximumSalary: null,
        medianSalary: null,
        publisherLink: 'https://techcompany.com',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SalaryEstimationDetailsScreen(
              entity: salaryEstimation,
            ),
          ),
        ),
      );

      expect(find.text('0.00'), findsNWidgets(3));
    });
  });
}
