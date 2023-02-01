import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project/screens/feed/feed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main_test.dart' as app;
import 'package:project/screens/explore/explore.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/helpers/storage.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('User has never signed up', () {
    testWidgets(
        "User has never signed up, so see introduction screens and HomeScreen widget is built",
        (tester) async {
      app.main();
      await Storage.setUserToken('init');
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

    testWidgets(
        "User has never signed up, so see introduction screens, open Account Screen. The user is redirected to the Sign In Screen",
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

      // Go to "Account" screen and verity it  redirects the user to SignInScreen
      final account_navbar_item = find.text("Account");
      await tester.tap(account_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(SignInScreen), findsOneWidget);
    });
  });
}
