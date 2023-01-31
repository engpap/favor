import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/customFieldMat.dart';
import 'package:project/screens/signup/signup.dart';

void main() {
  testWidgets('Form SignUp', (WidgetTester tester) async {
    // Create the widget
    await tester.pumpWidget(
      CupertinoApp(
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        home: Form_SignUp(),
      ),
    );

    // Verify that the form has an autovalidate mode of onUserInteraction.
    expect(find.byType(Form), findsOneWidget);
    Form formWidget = tester.widget(find.byType(Form));
    expect(formWidget.autovalidateMode, AutovalidateMode.onUserInteraction);

    // Verify that the form contains 5 input fields by:
    // Verifying that the form contains 5 CustomCard widgets
    expect(find.byType(CustomCard), findsNWidgets(5));
    // Verifying that the form contains 5 CustomFieldMat widgets
    expect(find.byType(CustomFieldMat), findsNWidgets(5));
  });
}
