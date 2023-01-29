import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project/functions/tabs.dart';
import '../main_test.dart' as app;

import 'package:project/screens/account/account.dart';
import 'package:project/screens/explore/explore.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/feed/feed_mobile.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/screens/signin/signin.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
        'In the first start of the app, we see introductions and then the homescreen',
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Wait for animation to end
      //await Future.delayed(Duration(seconds: 5)); //TODO: check if necessary
      //debugDumpApp();

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
        "User enters the app for the first time and navigate through the app using the navigation bottom bar",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 5)); //TODO: check if necessary
      // Wait for animation to end

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

      // Go to "Favor" screen and verity it is built
      // Find and tap on "New Favor" item in the bottom navigation bar
      final new_favor_navbar_item = find.text("New Favor");
      await tester.tap(new_favor_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(FavorScreen), findsOneWidget);

      // Go to "Leaderboard" screen and verity it is built
      final leaderboard_navbar_item = find.text("Leaderboard");
      await tester.tap(leaderboard_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(Leaderboard_Screen), findsOneWidget);

      // Go to "Account" screen and verity it is built
      final account_navbar_item = find.text("Account");
      await tester.tap(account_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(AccountScreen), findsOneWidget);
    });

    testWidgets(
        "User enters the app for the first time and navigate through the app using the navigation bottom bar",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 5)); //TODO: check if necessary
      // Wait for animation to end

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

      // Go to "Favor" screen and verity it is built
      // Find and tap on "New Favor" item in the bottom navigation bar
      final new_favor_navbar_item = find.text("New Favor");
      await tester.tap(new_favor_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(FavorScreen), findsOneWidget);

      // Go to "Leaderboard" screen and verity it is built
      final leaderboard_navbar_item = find.text("Leaderboard");
      await tester.tap(leaderboard_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(Leaderboard_Screen), findsOneWidget);

      // Go to "Account" screen and verity it is built
      final account_navbar_item = find.text("Account");
      await tester.tap(account_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(AccountScreen), findsOneWidget);
    });
    testWidgets(
        "Go to Home Screen, check if favor categories and carousel are correctly built",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Wait for animation to end
      //await Future.delayed(Duration(seconds: 5)); //TODO: check if necessary
      //debugDumpApp();

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

      expect(find.text("Recommended for you"), findsOneWidget);
      expect(find.text("Favor Categories"), findsOneWidget);
    });
/*
    testWidgets(
        "Go to Home Screen,  tap on a favor category and check if Explore Screen is shown",
        (tester) async {
      app.main();
      await tester.pumpAndSettle();
      // Wait for animation to end
      await Future.delayed(Duration(seconds: 5)); //TODO: check if necessary
      //debugDumpApp();

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

      final favor_category_0 = find.byKey(Key("favor_category_0"));
      await tester.tap(favor_category_0);
      expect(find.text("Favor Categories"), findsOneWidget);
    });*/

    // Find and tap on "New Favor" item in the bottom navigation bar

    /*
      dunno if possible to do beacuse you cannot access the api, THINK ABOUT ANOTHER TEST!
      // In the Favor Screen, find and tap the publish favor button
      final publish_favor_button = find.byKey(Key('publish_favor_button'));
      await tester.tap(publish_favor_button);
      await tester.pumpAndSettle();

      expect(find.byType(SignInScreen), findsOneWidget);
      ---------------------------------------------------------------------DUNNO 
      
      */

    // final addItemFinder =
    //     await find.byElementPredicate((element) => element.widget. == addItem);
    //await tester
    //final BottomNavigationBarItem addIconItem = items[2];

    /*final addIconItem = find
          .byType(BottomNavigationBarItem)
          .evaluate()
          .map((e) => print(element));*/
    //await tester.tap(addIconItem);

    //expect(find.byType(FavorScreen), findsOneWidget);

    /*
      var new_favor_icon;
      // Find and tap the add button in the HomeScreen.
      /*
      final bottomBarItems = find.byType(BottomNavigationBarItem);

      final home_screen_widget = find
          .byKey(Key("home_screen_widget"))
          .evaluate()
          .first
          .widget as UserMode;
      final cupertinoTabScaffold =
          home_screen_widget.child as CupertinoTabScaffold;
      final tabBar = cupertinoTabScaffold.tabBar;
      final items = tabBar.items;
      //final BottomNavigationBarItem addIconItem = items[2];
      final item2 = find.byType(BottomNavigationBarItem);
*/

      final bottomTabBar = find.byKey(Key("bottom_navigation_bar"));

      await tester.tapAt(tester.getCenter(bottomTabBar));
      await tester.pumpAndSettle();
      expect(find.byType(DetailScreen), findsOneWidget);
      
      final Finder publishButton = find.byKey(Key('publishButton'));
      await tester.tap(publishButton);

      final signInButton = find.byKey(Key("form_sign_in_container"));

      //await driver.
      //final bottomNavigationBarItem = find.by
      // await tester.tap(addIconItem);
      // await tester.tap(BottomNavigationBarItem);
      //BottomNavigationBarItem.visitChildElements((element) {
      //  new_favor_icon = (element as CupertinoTabScaffold).tabBar.items[2];
      //});

      // FOR ME:   until finding home_screen_widget it works

      //await tester.tap(new_favor_icon);

      //await tester.tap(addButton);

      // Emulate a tap on the publish favor button.

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the we are in the SignInScreen by checking the presence of the
      // SignUp button
      expect(find.byKey(Key('SignIn_loginButton')), findsOneWidget);
      */
  });
}
