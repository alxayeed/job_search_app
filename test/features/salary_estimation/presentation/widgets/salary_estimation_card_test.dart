import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

    // Build the widget and provide the mock navigation observer
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
}
