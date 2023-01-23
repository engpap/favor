import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/errors/error_handling.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/main.dart';
import 'package:http/http.dart' as http;
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/introduction/introduction-1.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:provider/provider.dart';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  executeUnitTests();
  executeWidgetTests();
}

void executeUnitTests() {
  // Not relevant
}

void executeWidgetTests() {
  testWidgets("Shows Introduction Screen if userToken is null",
      (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider())
    ], child: const MyApp()));

    // Check if the SignInScreen is pushed
    var _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('token');
    bool actual = await Storage.isThereUserToken();
    expect(actual, false);

    // The pump and settle is necessary because there is the favor logo
    // animation before the Introduction Screen
    await tester.pumpAndSettle();
    expect(find.byType(Introduction1Screen), findsOneWidget);
  });
  /* TODO: when render library exceptions are removed
  testWidgets("Shows HomeScreen if userToken is not null",
      (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => UserProvider())
    ], child: const MyApp()));
    await Storage.setUserToken("valid_or_invalid_token");
    bool actual = await Storage.isThereUserToken();
    expect(actual, true);

    await tester.pumpAndSettle();
    // Check if the SignInScreen is pushed
    expect(find.byType(HomeScreen), findsOneWidget);
  });*/
}
