import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_search_app/core/widgets/show_error_widget.dart';

void main() {
  group('ShowErrorWidget Tests', () {
    testWidgets('renders correctly with a non-empty error message',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'Network error occurred!';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ShowErrorWidget(message: errorMessage),
        ),
      );

      // Assert
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Something went wrong!'), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('renders correctly with an empty error message',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = '';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ShowErrorWidget(message: errorMessage),
        ),
      );

      // Assert
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('Something went wrong!'), findsOneWidget);
      expect(find.text(errorMessage),
          findsOneWidget); // Should render an empty text widget
    });

    testWidgets('displays the correct icon size and color',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'Sample error message';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ShowErrorWidget(message: errorMessage),
        ),
      );

      // Assert
      final iconFinder = find.byIcon(Icons.error_outline);
      final icon = tester.widget<Icon>(iconFinder);

      expect(icon.size, 48); // Icon size is 48
      expect(icon.color, Colors.red); // Icon color is red
    });

    testWidgets('displays the correct text styles',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'An error occurred';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ShowErrorWidget(message: errorMessage),
        ),
      );

      // Assert
      final titleTextFinder = find.text('Something went wrong!');
      final messageTextFinder = find.text(errorMessage);

      final titleText = tester.widget<Text>(titleTextFinder);
      final messageText = tester.widget<Text>(messageTextFinder);

      expect(titleText.style?.fontSize, 18); // Title text size
      expect(titleText.style?.color, Colors.red); // Title text color

      expect(messageText.style?.color, Colors.grey); // Message text color
    });

    testWidgets('renders correctly with different error messages',
        (WidgetTester tester) async {
      const errorMessages = ['Error 1', 'Error 2', 'Error 3'];

      for (var message in errorMessages) {
        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: ShowErrorWidget(message: message),
          ),
        );

        // Assert
        expect(find.text(message), findsOneWidget);
      }
    });

    testWidgets('correct layout (main axis alignment)',
        (WidgetTester tester) async {
      const errorMessage = 'Test alignment';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ShowErrorWidget(message: errorMessage),
        ),
      );

      // Assert
      final columnFinder = find.byType(Column);
      final column = tester.widget<Column>(columnFinder);

      expect(column.mainAxisAlignment, MainAxisAlignment.center);
    });

    testWidgets('widget responds to screen size changes',
        (WidgetTester tester) async {
      const errorMessage = 'Screen size test';

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ShowErrorWidget(message: errorMessage),
        ),
      );

      // Simulate different screen sizes and check if the widget behaves correctly
      await tester.binding
          .setSurfaceSize(const Size(800, 600)); // Larger screen
      await tester.pump();
      expect(find.text(errorMessage),
          findsOneWidget); // Ensure the message is still rendered

      await tester.binding
          .setSurfaceSize(const Size(300, 400)); // Smaller screen
      await tester.pump();
      expect(find.text(errorMessage),
          findsOneWidget); // Ensure the message is still rendered
    });
  });
}
