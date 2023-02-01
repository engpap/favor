import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility_for_testing/mocks/dummy_models.dart';
import '../main_test.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('AccountScreen test', (tester) async {
    SharedPreferences.setMockInitialValues({'token': 'valid_token'});
    app.mainAuth();
    await tester.pumpAndSettle();

    // Go to "Account" screen and verity it is built
    final account_navbar_item = find.text("Account");
    await tester.tap(account_navbar_item);
    await tester.pumpAndSettle();

    // Test Column widget
    expect(find.byKey(Key("account_tablet")), findsOneWidget);

    // Test Text widget for user name and surname
    expect(find.byKey(Key("name_surname_text")), findsOneWidget);
    expect(find.textContaining(dummy_user.name), findsOneWidget);

    // Test Text widget for email
    expect(find.byKey(Key("email_text")), findsOneWidget);
    expect(find.text(dummy_user.email!), findsOneWidget);

    // Test Text widget for bio
    expect(find.byKey(Key("bio_text")), findsOneWidget);
    expect(find.text(dummy_user.bio!), findsOneWidget);

    // Test Text widget for age
    expect(find.byKey(Key("age_text")), findsOneWidget);
    expect(find.text(dummy_user.age.toString()), findsOneWidget);

    // Test Text widget for job
    expect(find.byKey(Key("job_text")), findsOneWidget);
    expect(find.text(dummy_user.job!), findsOneWidget);

    // Test Text widget for city
    expect(find.byKey(Key("city_text")), findsOneWidget);
    expect(find.text(dummy_user.city!), findsOneWidget);
  });
}
