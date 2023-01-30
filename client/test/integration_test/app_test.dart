import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/functions/tabs.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/feed/feed.dart';
import 'package:project/screens/signup/signup.dart';
import 'package:project/screens/signup2/signup2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main_test.dart' as app;

import 'package:project/screens/account/account.dart';
import 'package:project/screens/explore/explore.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/feed/feed_mobile.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/errors/error_handling.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/main.dart';
import 'package:http/http.dart' as http;
import 'package:project/providers/app_provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/explore/providerExplore.dart';
import 'package:provider/provider.dart';
import '../utility_for_testing/mocks/services/admin_service_mock.dart';
import '../utility_for_testing/mocks/services/apis/google_calendar_api_wrapper_mock.dart';
import '../utility_for_testing/mocks/services/auth_service_mock.dart';
import '../utility_for_testing/mocks/services/constants_service_mock.dart';
import '../utility_for_testing/mocks/services/favor_service_mock.dart';
import '../utility_for_testing/mocks/services/leaderboard_service_mock.dart';
import '../utility_for_testing/mocks/services/post_service_mock.dart';
import '../utility_for_testing/mocks/services/profile_service_mock.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
        "User has never signed up, so see introduction screens and HomeScreen widget is built",
        (tester) async {
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
    });

    testWidgets(
        "User has never signed up, so see introduction screens, open Feed Screen",
        (tester) async {
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

      // Go to "Home" screen and verify it is built
      final home_navbar_item = find.text("Home");
      await tester.tap(home_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(Feed_Screen), findsOneWidget);

      // Verify that posts are built
      expect(find.byKey(Key("favor_widget_${0}")), findsOneWidget);
      // Verify that categories are built
      expect(find.byKey(Key("favor_category_${0}")), findsOneWidget);
      // Verify that booked favors are not built since user is not even registered
      expect(find.byKey(Key("booked_favor_widget_${0}")), findsNothing);
    });

    testWidgets(
        "User has never signed up, so see introduction screens, open Explore Screen",
        (tester) async {
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

      // Go to "Explore" screen and verity it is built
      final explore_navbar_item = find.text("Explore");
      await tester.tap(explore_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(Explore_Screen), findsOneWidget);

      // Verify that posts are built
      expect(find.byKey(Key("favor_widget_${0}")), findsOneWidget);
    });

    testWidgets(
        "User has never signed up, so see introduction screens, open Favor Screen",
        (tester) async {
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

      // Go to "Favor" screen and verity it is built
      // Find and tap on "New Favor" item in the bottom navigation bar
      final new_favor_navbar_item = find.text("New Favor");
      await tester.tap(new_favor_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(FavorScreen), findsOneWidget);

      // Verify that posts are built
      expect(find.byKey(Key("column_favor_picker_menus")), findsOneWidget);
    });

    testWidgets(
        "User has never signed up, so see introduction screens, open Leaderboard Screen",
        (tester) async {
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

      // Go to "Leaderboard" screen and verity it is built
      final leaderboard_navbar_item = find.text("Leaderboard");
      await tester.tap(leaderboard_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(Leaderboard_Screen), findsOneWidget);

      // Verify that leaderboard cards are built
      expect(
          find.byKey(
            Key("leaderboard_card_${0}"),
          ),
          findsOneWidget);
      expect(
          find.byKey(
            Key("leaderboard_card_${1}"),
          ),
          findsOneWidget);
    });
  });

  testWidgets(
      "User has never signed up, so see introduction screens, open Account Screen. The user is redirected to the Sign In Screen",
      (tester) async {
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
  });

  testWidgets(
      "User has never signed up, so see introduction screens, open Account Screen. The user is redirected to the Sign In Screen and move to the Sign Up Screen.",
      (tester) async {
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
  });

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
        'email@test.it');

    await tester.enterText(
        find.byKey(
          Key("custom_card_password_signin"),
        ),
        'Password123');

    // After inserting all correct information, the user is redirected to
    // the HomeScreen.
    final signIn_loginButton = find.byKey(Key("SignIn_loginButton"));
    await tester.tap(signIn_loginButton);
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  // TODO
  testWidgets("User signs in, they open a post.", (tester) async {
    await Storage.setUserToken('valid_token');
    app.main();
    await tester.pumpAndSettle();

    /// Make sure that introduction screens are not shown when user has logged in before
    final gesture_detector_1 = find.byKey(Key("gesture_detector_intro1"));
    expect(gesture_detector_1, findsNothing);

    /// Find the first favor widget
    final favor_widget = find.byType(FavorWidget).first;
    await tester.tap(favor_widget);
    await tester.pumpAndSettle();
    expect(FavorInformationPageScreen, findsOneWidget);

    // Verify that user is redirected to Feed when successfully book a favor
    final book_it_button = find.byKey(Key("book_it_button"));
    await tester.tap(book_it_button);
    await tester.pumpAndSettle();
    expect(find.byType(Feed_Screen), findsOneWidget);
  });
}
