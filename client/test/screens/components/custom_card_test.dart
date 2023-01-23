import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/components/customCard.dart';

import '../../utility_for_testing/utilities.dart';

void main() {
  /// Height property of Container cannot be tested since there's not getter
  /// inside this flutter class!
  testWidgets('CustomCard has properly initialized its Container',
      (WidgetTester tester) async {
    // Build the CustomCard widget
    await tester.pumpWidget(getApp(CustomCard(child: Text('Test'))));

    // Verify that the child widget (Text) is displayed
    expect(find.text('Test'), findsOneWidget);

    // Verify that the Container has the correct decoration
    final container = tester.firstWidget(find.byType(Container)) as Container;
    expect(container.decoration, isA<BoxDecoration>());

    // Verify that the Container has the correct margin
    expect(container.margin, EdgeInsets.all(9));

    // Verify that the Container has the correct padding
    expect(container.padding, EdgeInsets.all(9));
  });

  testWidgets(
      'CustomCard has properly initialized its Container when passing required and non required parameters',
      (WidgetTester tester) async {
    // Build the CustomCard widget
    await tester.pumpWidget(getApp(CustomCard(
        customHeight: 13,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Text('Test'))));

    // Verify that the child widget (Text) is displayed
    expect(find.text('Test'), findsOneWidget);

    final container = tester.firstWidget(find.byType(Container)) as Container;

    // Verify that the Container has the correct margin
    expect(container.margin, EdgeInsets.zero);

    // Verify that the Container has the correct padding
    expect(container.padding, EdgeInsets.zero);
  });
}
