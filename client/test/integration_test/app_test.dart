import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project/functions/tabs.dart';

import 'package:project/main.dart' as app;
import 'package:project/screens/home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
        'In the first start of the app, we see introductions and then the homescreen',
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
    });

    testWidgets(
        "If user tries to create a favor but it is not logged, then the app shows the Sign In Screen",
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

      final addIconItem = find.byWidget(TabsName.values[2].icon);
      await tester.tap(addIconItem);

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
  });
}
