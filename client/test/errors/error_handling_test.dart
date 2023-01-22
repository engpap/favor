import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/screens/feed/feed.dart';
import 'package:project/screens/feed/feed_mobile.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/errors/error_handling.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:build_runner/build_runner.dart';
import 'package:provider/provider.dart';

import '../utility_for_testing/mocks/mock_navigator_observer.dart';

void main() {
  executeUnitTests();
  executeWidgetTests();
}

void executeUnitTests() {
  // Not relevant
}

void executeWidgetTests() {
  testWidgets(
      "httpErrorHandle should navigate to SignInScreen when status code is 401",
      (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(
      CupertinoApp(
        home: Feed_Screen_M(),
        navigatorObservers: [mockObserver],
        builder: (context, child) {
          var response = http.Response('{"message": "Unauthorized"}', 401);
          httpErrorHandle(
              response: response, context: context, onSuccess: () {});
          // Check if the SignInScreen is pushed
          expect(find.byType(SignInScreen), findsOneWidget);
          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );
  });
}
