import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/customFieldMat.dart';
import 'package:project/screens/signup/signup.dart';

void main() {
  executeUnitTests();
  //executeWidgetTests();
}
/*
void executeWidgetTests() {
  group("customValidator for name field", () {
    test('customValidator returns error for invalid name', () {
      var custom_field_mat = find.byKey(Key("name_custom_field_mat"));
      CustomFieldMat widget = (custom_field_mat.first as CustomFieldMat);
      var result = widget.customValidator!('123');
      expect(result, 'You can\'t insert number or special characters');
    });

//      result = widget.customValidator('a' * 51);
    // expect(result, 'max 50 chars');

    /*var state = Form_SignUpState();
    var result = state.customValidator("name");
    expect(result, null);

    result = state.customValidator("name123");
    expect(result, "You can't insert number or special characters");
  });

  test("customValidator for surname field", () {
    var state = Form_SignUpState();
    var result = state.customValidator("surname");
    expect(result, null);

    result = state.customValidator("surname123");
    expect(result, "You can't insert number or special characters");

    result = state.customValidator("s" * 51);
    expect(result, "max 50 chars");
  });

  test("customValidator for email field", () {
    var state = _Form_SignUpState();
    var result = state.customValidator("email@example.com");
    expect(result, null);

    result = state.customValidator("email123");
    expect(result, "You can't insert number or special characters");

    result = state.customValidator("e" * 51);
    expect(result, "max 50 chars");
  });

  test("customValidator for password field", () {
    var state = _Form_SignUpState();
    var result = state.customValidator("Password123");
    expect(result, null);

    result = state.customValidator("password123");
    expect(result,
        "at least 8 characters long and contains at least one uppercase letter, one lowercase letter, and one digit");

    result = state.customValidator("p" * 51);
    expect(result, "max 50 chars");
  });*/
  });
}*/

void executeUnitTests() {
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
