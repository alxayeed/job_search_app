import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/core/constants/app_strings.dart';
import 'package:job_search_app/features/salary_estimation/domain/entities/salary_estimation_entity.dart';
import 'package:job_search_app/features/salary_estimation/presentation/widgets/salary_estimation_card.dart';
import 'package:job_search_app/features/salary_estimation/presentation/pages/salary_estimation_details_screen.dart';

class MockNavigatorObserver extends NavigatorObserver {
  bool didPushRoute = false;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    didPushRoute = true;
    super.didPush(route, previousRoute);
  }
}

void main() {
  testWidgets(
      'SalaryEstimationCard displays correct data and navigates to details screen',
      (WidgetTester tester) async {
    final SalaryEstimationEntity salaryEstimation = SalaryEstimationEntity(
      jobTitle: 'Software Engineer',
      location: 'New York',
      publisherName: 'Tech Company',
      minimumSalary: 80000,
      maximumSalary: 120000,
    );

    final MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SalaryEstimationCard(entity: salaryEstimation),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Location: New York'), findsOneWidget);
    expect(find.text('Publisher: Tech Company'), findsOneWidget);
    expect(find.text('Min Salary: 80000.00'), findsOneWidget);
    expect(find.text('Max Salary: 120000.00'), findsOneWidget);

    await tester.tap(find.byType(SalaryEstimationCard));
    await tester.pumpAndSettle();

    expect(mockNavigatorObserver.didPushRoute, isTrue);

    expect(find.byType(SalaryEstimationDetailsScreen), findsOneWidget);
  });

  testWidgets(
      'SalaryEstimationCard displays correct data and navigates to details screen',
      (WidgetTester tester) async {
    final SalaryEstimationEntity salaryEstimation = SalaryEstimationEntity(
      jobTitle: 'Software Engineer',
      location: 'New York',
      publisherName: 'Tech Company',
      minimumSalary: 80000,
      maximumSalary: 120000,
    );

    final MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SalaryEstimationCard(entity: salaryEstimation),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    // Check for the presence of text widgets
    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Location: New York'), findsOneWidget);
    expect(find.text('Publisher: Tech Company'), findsOneWidget);
    expect(find.text('Min Salary: 80000.00'), findsOneWidget);
    expect(find.text('Max Salary: 120000.00'), findsOneWidget);

    // Verify the colors of the text
    final jobTitleFinder = find.text('Software Engineer');
    final locationFinder = find.text('Location: New York');
    final publisherFinder = find.text('Publisher: Tech Company');
    final minSalaryFinder = find.text('Min Salary: 80000.00');
    final maxSalaryFinder = find.text('Max Salary: 120000.00');

    // Get the text widget's styles
    final jobTitleWidget = tester.widget<Text>(jobTitleFinder);
    final locationWidget = tester.widget<Text>(locationFinder);
    final publisherWidget = tester.widget<Text>(publisherFinder);
    final minSalaryWidget = tester.widget<Text>(minSalaryFinder);
    final maxSalaryWidget = tester.widget<Text>(maxSalaryFinder);

    // Assert colors
    expect(
      jobTitleWidget.style?.color,
      Colors.black87,
    );
    expect(
      locationWidget.style?.color,
      Colors.grey[600],
    );
    expect(
      publisherWidget.style?.color,
      Colors.grey[600],
    );
    expect(
      minSalaryWidget.style?.color,
      Colors.green,
    );
    expect(
      maxSalaryWidget.style?.color,
      Colors.red,
    );

    // Simulate tap on the SalaryEstimationCard
    await tester.tap(find.byType(SalaryEstimationCard));
    await tester.pumpAndSettle();

    // Verify navigation
    expect(mockNavigatorObserver.didPushRoute, isTrue);
    expect(find.byType(SalaryEstimationDetailsScreen), findsOneWidget);
  });

  testWidgets('SalaryEstimationCard displays "N/A" when jobTitle is null',
      (WidgetTester tester) async {
    final SalaryEstimationEntity salaryEstimation = SalaryEstimationEntity(
      jobTitle: null,
      location: 'New York',
      publisherName: 'Tech Company',
      minimumSalary: 80000,
      maximumSalary: 120000,
    );

    final MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SalaryEstimationCard(entity: salaryEstimation),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    expect(find.text(AppStrings.notApplicable), findsOneWidget);
    expect(find.text('Location: New York'), findsOneWidget);
    expect(find.text('Publisher: Tech Company'), findsOneWidget);
    expect(find.text('Min Salary: 80000.00'), findsOneWidget);
    expect(find.text('Max Salary: 120000.00'), findsOneWidget);
  });

  testWidgets('SalaryEstimationCard displays "N/A" when location is null',
      (WidgetTester tester) async {
    final SalaryEstimationEntity salaryEstimation = SalaryEstimationEntity(
      jobTitle: 'Software Engineer',
      location: null,
      publisherName: 'Tech Company',
      minimumSalary: 80000,
      maximumSalary: 120000,
    );

    final MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SalaryEstimationCard(entity: salaryEstimation),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Location: ${AppStrings.notApplicable}'), findsOneWidget);
    expect(find.text('Publisher: Tech Company'), findsOneWidget);
    expect(find.text('Min Salary: 80000.00'), findsOneWidget);
    expect(find.text('Max Salary: 120000.00'), findsOneWidget);
  });

  testWidgets(
      'SalaryEstimationCard displays "No Publisher" when publisherName is null',
      (WidgetTester tester) async {
    final SalaryEstimationEntity salaryEstimation = SalaryEstimationEntity(
      jobTitle: 'Software Engineer',
      location: 'New York',
      publisherName: null,
      minimumSalary: 80000,
      maximumSalary: 120000,
    );

    final MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SalaryEstimationCard(entity: salaryEstimation),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Location: New York'), findsOneWidget);
    expect(find.text('Publisher: ${AppStrings.notApplicable}'), findsOneWidget);
    expect(find.text('Min Salary: 80000.00'), findsOneWidget);
    expect(find.text('Max Salary: 120000.00'), findsOneWidget);
  });

  testWidgets('SalaryEstimationCard displays "0.00" when minimumSalary is null',
      (WidgetTester tester) async {
    final SalaryEstimationEntity salaryEstimation = SalaryEstimationEntity(
      jobTitle: 'Software Engineer',
      location: 'New York',
      publisherName: 'Tech Company',
      minimumSalary: null,
      maximumSalary: 120000,
    );

    final MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SalaryEstimationCard(entity: salaryEstimation),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Location: New York'), findsOneWidget);
    expect(find.text('Publisher: Tech Company'), findsOneWidget);
    expect(find.text('Min Salary: 0.00'), findsOneWidget);
    expect(find.text('Max Salary: 120000.00'), findsOneWidget);
  });

  testWidgets('SalaryEstimationCard displays "0.00" when maximumSalary is null',
      (WidgetTester tester) async {
    final SalaryEstimationEntity salaryEstimation = SalaryEstimationEntity(
      jobTitle: 'Software Engineer',
      location: 'New York',
      publisherName: 'Tech Company',
      minimumSalary: 80000,
      maximumSalary: null,
    );

    final MockNavigatorObserver mockNavigatorObserver = MockNavigatorObserver();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SalaryEstimationCard(entity: salaryEstimation),
        ),
        navigatorObservers: [mockNavigatorObserver],
      ),
    );

    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Location: New York'), findsOneWidget);
    expect(find.text('Publisher: Tech Company'), findsOneWidget);
    expect(find.text('Min Salary: 80000.00'), findsOneWidget);
    expect(find.text('Max Salary: 0.00'), findsOneWidget);
  });
}
