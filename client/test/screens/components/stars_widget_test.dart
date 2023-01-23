import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/components/starsWidget.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

void main() {
  testWidgets('Build the correct color for the number of stars given',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StarsWidget(number: 4, size: 23),
      ),
    );
    final icons =
        find.byType(Icon).evaluate().map((e) => e.widget as Icon).toList();
    var yellowStars = 0;
    var blackStars = 0;

    icons.forEach((element) {
      if (element.color == favorColors.Yellow)
        yellowStars++;
      else if (element.color == Colors.black) blackStars++;
    });
    expect(yellowStars, 4);
    expect(blackStars, 1);
  });

  testWidgets('Build stars of the given size ', (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StarsWidget(number: null, size: 23),
      ),
    );

    final icons =
        find.byType(Icon).evaluate().map((e) => e.widget as Icon).toList();

    icons.forEach((element) {
      expect(element.size, 23);
    });
  });

  testWidgets('If number is null it should build an empty row',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: StarsWidget(number: null, size: 23),
      ),
    );
    expect(find.byType(Row), findsOneWidget);
    expect(find.byIcon(Icons.star), findsNothing);
  });
}
