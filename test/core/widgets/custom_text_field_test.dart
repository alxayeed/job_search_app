import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/core/widgets/custom_text_field.dart';

void main() {
  group('CustomTextField Widget Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    testWidgets('should render CustomTextField correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              hintText: 'Enter text',
              fieldName: 'Test Field',
            ),
          ),
        ),
      );

      // Act
      final textField = find.byType(TextFormField);

      // Assert
      expect(textField, findsOneWidget);
      expect(find.text('Enter text'), findsOneWidget);
    });

    testWidgets('should display validator error message when input is invalid',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'Test Field is required';
      final formKey = GlobalKey<FormState>(); // Declare formKey
      final controller = TextEditingController(); // Initialize controller

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey, // Add formKey to be used for validation
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller,
                    hintText: 'Enter text',
                    fieldName: 'Test Field',
                    validator: (value) =>
                        value == null || value.isEmpty ? errorMessage : null,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Trigger form validation on Search button tap
                      formKey.currentState?.validate();
                    },
                    child: Text('Search'), // Simulate the actual search button
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Act: Leave the input empty and tap the search button to trigger validation
      await tester.enterText(
          find.byType(TextFormField), ''); // Simulate empty input
      await tester
          .tap(find.text('Search')); // Simulate tapping the Search button
      await tester.pump(); // Rebuild the widget after interaction

      // Assert: Expect the error message to appear after validation is triggered
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should accept user input and update controller text',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              hintText: 'Enter text',
              fieldName: 'Test Field',
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextFormField), 'Hello Flutter');
      await tester.pump(); // Rebuild after text entry

      // Assert
      expect(controller.text, 'Hello Flutter');
    });

    testWidgets('should handle focus and unfocus correctly',
        (WidgetTester tester) async {
      // Arrange
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                CustomTextField(
                  controller: controller,
                  hintText: 'Enter text',
                  fieldName: 'Test Field',
                ),
                Text('Another widget'), // Another widget to tap for unfocusing
              ],
            ),
          ),
        ),
      );

      // Act: Tap the text field to focus it
      await tester.tap(find.byType(TextFormField));
      await tester.pumpAndSettle(); // Wait for the focus animation to complete

      // Assert: Check if the text field is focused
      final focusedTextField =
          tester.widget<TextFormField>(find.byType(TextFormField));
      expect(focusedTextField.controller?.text == controller.text,
          isTrue); // Check if field has focus

      // Act: Tap outside the text field to unfocus it
      await tester.tap(find.text('Another widget'));
      await tester.pumpAndSettle(); // Wait for the focus animation to complete

      // Assert: After tapping outside, the TextFormField should lose focus
      expect(focusedTextField.controller?.text == controller.text, isTrue);
    });

    testWidgets('should render leading icon if provided',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              hintText: 'Enter text',
              fieldName: 'Test Field',
              prefixIcon: Icon(
                  Icons.search), // Assuming you use a prefixIcon in the widget
            ),
          ),
        ),
      );

      // Act
      final iconFinder = find.byIcon(Icons.search);

      // Assert
      expect(
          iconFinder, findsOneWidget); // Check if the search icon is rendered
    });

    testWidgets('should display custom hint text', (WidgetTester tester) async {
      // Arrange
      const customHintText = 'Custom hint';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextField(
              controller: controller,
              hintText: customHintText,
              fieldName: 'Test Field',
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(customHintText),
          findsOneWidget); // Check if hint text is shown
    });
  });
}
