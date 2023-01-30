import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project/screens/signup/signup.dart';
import 'package:project/screens/signup2/signup2.dart';
import '../main_test.dart' as app;
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/helpers/storage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("Try to sign up", () {
    testWidgets(
        "User has never signed up, they sign up after introduction screens.",
        (tester) async {
      await Storage.setUserToken('init');
      app.main();
      await tester.pumpAndSettle();

      final gesture_detector_1 = find.byKey(Key("gesture_detector_intro1"));
      await tester.tap(gesture_detector_1);
      await tester.pumpAndSettle();

      final gesture_detector_2 = find.byKey(Key("gesture_detector_intro2"));
      await tester.tap(gesture_detector_2);
      await tester.pumpAndSettle();

      final gesture_detector_3 = find.byKey(Key("gesture_detector_intro3"));
      await tester.tap(gesture_detector_3);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);

      // Go to "Account" screen and verity it is built
      final account_navbar_item = find.text("Account");
      await tester.tap(account_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(SignInScreen), findsOneWidget);

      final signIn_signUpButton = find.byKey(Key("SignIn_signUpButton"));
      await tester.tap(signIn_signUpButton);
      await tester.pumpAndSettle();
      expect(find.byType(SignUpScreen), findsOneWidget);

      await tester.enterText(
          find.byKey(
            Key("custom_card_name"),
          ),
          'name_test');

      await tester.enterText(
          find.byKey(
            Key("custom_card_surname"),
          ),
          'surname_test');

      await tester.enterText(
          find.byKey(
            Key("custom_card_email"),
          ),
          'email@test.it');

      await tester.enterText(
          find.byKey(
            Key("custom_card_password"),
          ),
          'Password123');

      await tester.enterText(
          find.byKey(
            Key("custom_card_confirm_password"),
          ),
          'Password123');

      final signUp_registerButton = find.byKey(Key("SignUp_registerButton"));
      await tester.tap(signUp_registerButton);
      await tester.pumpAndSettle();
      expect(find.byType(SignUp2Screen), findsOneWidget);

      await tester.enterText(
          find.byKey(
            Key("custom_card_age"),
          ),
          '23');

      await tester.enterText(
          find.byKey(
            Key("custom_card_gender"),
          ),
          'Male');

      await tester.enterText(
          find.byKey(
            Key("custom_card_city"),
          ),
          'Milan');

      await tester.enterText(
          find.byKey(
            Key("custom_card_job"),
          ),
          'Software Developer');

      await tester.enterText(
          find.byKey(
            Key("custom_card_bio"),
          ),
          'custom bio');

      // After inserting all correct information, the user is redirected to
      // the SignInScreen.
      final registerButton_SignUp = find.byKey(Key("RegisterButton_SignUp2"));
      await tester.tap(registerButton_SignUp);
      await tester.pumpAndSettle();
      expect(find.byType(SignInScreen), findsOneWidget);

      await tester.enterText(
          find.byKey(
            Key("custom_card_email_signin"),
          ),
          'invalid');

      await tester.enterText(
          find.byKey(
            Key("custom_card_password_signin"),
          ),
          'invalid');

      // After inserting incorrect information, the user is warned by the input form
      expect(
          find.textContaining("This password is not valid."), findsOneWidget);
      expect(find.textContaining("This mail is not valid"), findsOneWidget);
    });
  });
}
