import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/animations/conditionalAnimatedSwitch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'ConditionalAnimatedSwitcher displays the correct widget based on the condition',
      (WidgetTester tester) async {
    // Define two test widgets
    const testWidget1 = Text('First Widget', key: ValueKey('FirstWidget'));
    const testWidget2 = Text('Second Widget', key: ValueKey('SecondWidget'));

    // Build a widget tree with ConditionalAnimatedSwitcher
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            bool condition = true; // Initial condition

            return ConditionalAnimatedSwitcher(
              firstWidget: testWidget1,
              secondWidget: testWidget2,
              duration: const Duration(milliseconds: 500),
              condition: condition,
            );
          },
        ),
      ),
    );

    // Verify the first widget is displayed initially
    expect(find.byKey(const ValueKey('FirstWidget')), findsOneWidget);
    expect(find.byKey(const ValueKey('SecondWidget')), findsNothing);

    // Simulate changing the condition
    await tester.pumpWidget(
      MaterialApp(
        home: ConditionalAnimatedSwitcher(
          firstWidget: testWidget1,
          secondWidget: testWidget2,
          duration: const Duration(milliseconds: 500),
          condition: false, // Switch the condition to false
        ),
      ),
    );

    // Start the transition
    await tester.pump();

    // Verify the transition is in progress
    expect(find.byKey(const ValueKey('FirstWidget')), findsNothing);
    expect(find.byKey(const ValueKey('SecondWidget')), findsOneWidget);

    // Let the animation complete
    await tester.pumpAndSettle();

    // Verify the second widget is displayed after the animation
    expect(find.byKey(const ValueKey('SecondWidget')), findsOneWidget);
    expect(find.byKey(const ValueKey('FirstWidget')), findsNothing);
  });
}
