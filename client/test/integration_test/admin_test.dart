import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project/screens/account/account.dart';
import 'package:project/screens/account/account_mobile.dart';
import 'package:project/screens/admin.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:project/main.dart';

import 'package:project/providers/app_provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/explore/providerExplore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility_for_testing/mocks/dummy_models.dart';
import '../main_test.dart' as app;
import 'relevant_interactions_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  /*testWidgets('AccountScreen test', (tester) async {
    SharedPreferences.setMockInitialValues({'token': 'valid_token'});
    app.mainAdmin();
    await tester.pumpAndSettle();

    // Go to "Account" screen and verity it is built
    final account_navbar_item = find.text("Account");
    await tester.tap(account_navbar_item);
    await tester.pumpAndSettle();

    expect(find.byType(AccountScreen), findsOneWidget);

    // Test log_out_button
    await safeTapByKey(tester, "log_out_button");
    await tester.pumpAndSettle();

    expect(find.byType(SignInScreen), findsOneWidget);
    final SignIn_loginButton = find.byKey(Key("SignIn_loginButton"));
    await tester.tap(SignIn_loginButton);
    await tester.pumpAndSettle();

    expect(find.byType(AdminScreen), findsOneWidget);
  });*/
}

Future safeTapByKey(WidgetTester tester, String key) async {
  await tester.ensureVisible(find.byKey(Key(key)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(key)));
}
