import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mockito/mockito.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/errors/error_handling.dart';
import 'package:http/http.dart' as http;
import '../utility_for_testing/mocks/mock_build_context.dart';
import '../utility_for_testing/mocks/mock_navigator.dart';

void main() {
  executeUnitTests();
  executeWidgetTests();
}

void executeUnitTests() {
  MockContext mockContext = MockContext();
  MockNavigator mockNavigator = MockNavigator();
  when(mockContext.findAncestorStateOfType<NavigatorState>())
      .thenReturn(mockNavigator);
  test('onSuccess callback is called when status code is between 200 and 299',
      () {
    var response = http.Response('', 200);
    var onSuccessCalled = false;
    var onSuccess = () {
      onSuccessCalled = true;
    };

    var context = mockContext;
    httpErrorHandle(response: response, context: context, onSuccess: onSuccess);
    expect(onSuccessCalled, true);
  });
}

void executeWidgetTests() {
  testWidgets(
      "httpErrorHandle should navigate to SignInScreen when status code is 401",
      (WidgetTester tester) async {
    var feedScreenContext;
    await tester.pumpWidget(
      CupertinoApp(
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        home: Builder(
          builder: (context) {
            feedScreenContext = context;
            return HomeScreen();
          },
        ),
      ),
    );

    var response = http.Response('{"message": "Unauthorized"}', 401);
    httpErrorHandle(
        response: response, context: feedScreenContext, onSuccess: () {});
    await tester.pumpAndSettle();
    // Check if the SignInScreen is pushed
    expect(find.byKey(Key("form_sign_in_container")), findsOneWidget);
  });
}
