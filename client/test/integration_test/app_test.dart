import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project/functions/tabs.dart';

import 'package:project/main.dart' as app;
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/home.dart';
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
        "User enters the app for the first time and move to FavorScreen",
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

      // Find and tap on "New Favor" item in the bottom navigation bar
      final new_favor_navbar_item = find.text("New Favor");
      await tester.tap(new_favor_navbar_item);
      await tester.pumpAndSettle();
      expect(find.byType(FavorScreen), findsOneWidget);
    });
  });
}
