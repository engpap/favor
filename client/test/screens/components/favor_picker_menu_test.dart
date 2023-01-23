import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/components/favor_PickerMenu.dart';

import '../../utility_for_testing/utilities.dart';

void main() {
  // Set up the variables
  final contentList = [Text('item 1'), Text('item 2'), Text('item 3')];
  final placeholder = "placeholder";
  final heading = "heading";
  final textController = TextEditingController();

  // Set up the widget
  final mockFavor_pickerMenu = Favor_pickerMenu(
    contentList: contentList,
    textController: textController,
    placeholder: placeholder,
    heading: heading,
    prefixIcon: CupertinoIcons.add,
  );

  testWidgets('contentList is correctly displayed in the picker menu',
      (tester) async {
    await tester.pumpWidget(getApp(mockFavor_pickerMenu));
    // Tap on the suffix button to open the picker menu
    await tester.tap(find.byType(CupertinoButton).last);
    await tester.pump();
    // Verify that the items in the contentList are displayed in the picker menu
    expect(find.text('item 1'), findsOneWidget);
    expect(find.text('item 2'), findsOneWidget);
    expect(find.text('item 3'), findsOneWidget);
  });

  testWidgets('placeholder is correctly displayed in the text field',
      (tester) async {
    await tester.pumpWidget(getApp(mockFavor_pickerMenu));
    // Verify that the placeholder is displayed in the text field
    expect(find.text(placeholder), findsOneWidget);
  });

  testWidgets('heading is correctly displayed as the menu description',
      (tester) async {
    await tester.pumpWidget(getApp(mockFavor_pickerMenu));
    // Verify that the heading is displayed as the menu description
    expect(find.text(heading), findsOneWidget);
  });

  testWidgets('prefixIcon is correctly displayed in the text field',
      (tester) async {
    await tester.pumpWidget(getApp(mockFavor_pickerMenu));
    // Verify that the prefixIcon is displayed in the text field
    expect(find.byIcon(CupertinoIcons.add), findsOneWidget);
  });

  testWidgets('text input is correctly controlled by the textController',
      (tester) async {
    await tester.pumpWidget(getApp(mockFavor_pickerMenu));

    textController.text = 'initial value';
    // Verify that the text input is controlled by the textController
    expect(find.byType(CupertinoTextField), findsOneWidget);
    expect(find.text('initial value'), findsOneWidget);

    // Change the value of the text input
    textController.text = 'new value';
    await tester.pump();
    // Verify that the new value is displayed in the text input
    expect(find.text('new value'), findsOneWidget);
  });
}
