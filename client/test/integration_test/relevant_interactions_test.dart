import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/functions/tabs.dart';
import 'package:project/screens/booked_favor_page/favorBookedPage.dart';
import 'package:project/screens/favor_information_page/favorInformationPage.dart';
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
}
  /*testWidgets("User signs in, they open a post and book it.", (tester) async {
    SharedPreferences.setMockInitialValues({'token': 'valid_token'});
    app.mainAuth();
    await tester.pumpAndSettle();

    /// Make sure that introduction screens are not shown when user has logged in before
    final gesture_detector_1 = find.byKey(Key("gesture_detector_intro1"));
    expect(gesture_detector_1, findsNothing);

    /// Find the first favor widget
    final favor_widget_more_button =
        find.byKey(Key("favor_widget_more_button")).first;
    await tester.ensureVisible(favor_widget_more_button);
    await tester.tap(favor_widget_more_button);
    //await pumpUntilFound(tester, find.byKey(Key("favor_information")));
    await tester.pumpAndSettle();

    final favor_information_page = find.byKey(Key("favor_information_page"));
    //await tester.ensureVisible(favor_information);
    expect(favor_information_page, findsOneWidget);

    // Verify that user is redirected to Feed when successfully book a favor
    await safeTapByKey(tester, "book_it_button");
    await tester.pumpAndSettle();
    expect(find.byType(Feed_Screen), findsOneWidget);
  });
  /*

  testWidgets("User signs in and clicks on favor category", (tester) async {
    await tester.runAsync(() async {
      await Storage.setUserToken('valid_token');
      app.main();
      await tester.pumpAndSettle();

      /// Make sure that introduction screens are not shown when user has logged in before
      final gesture_detector_1 = find.byKey(Key("gesture_detector_intro1"));
      expect(gesture_detector_1, findsNothing);

      /// Find the first favor widget
      final favor_category_0 = find
          .byKey(
            Key("favor_category_0"),
          )
          .first;
      await tester.ensureVisible(favor_category_0);
      await tester.pumpAndSettle();
      await tester.tap(favor_category_0);
      await tester.pumpAndSettle();
      expect(find.byType(Explore_Screen), findsOneWidget);

      /// Find the first favor widget
      final favor_widget_more_button = find
          .byKey(
            Key("favor_widget_more_button"),
          )
          .first;
      await tester.ensureVisible(favor_widget_more_button);
      await tester.pumpAndSettle();
      await tester.tap(favor_widget_more_button);
      await tester.pumpAndSettle();
      expect(find.byType(FavorInformationPageScreen), findsOneWidget);
    });
  });*/

  /*
  testWidgets("User signs in and clicks on booked favor", (tester) async {
    await tester.runAsync(() async {
      await Storage.setUserToken('valid_token');
      app.main();
      await tester.pumpAndSettle();

      /// Make sure that introduction screens are not shown when user has logged in before
      final gesture_detector_1 = find.byKey(Key("gesture_detector_intro1"));
      expect(gesture_detector_1, findsNothing);

      /// Find the first favor widget
      final BookedFavorWidget_button = find
          .byKey(
            Key("BookedFavorWidget_button"),
          )
          .first;
      await tester.ensureVisible(BookedFavorWidget_button);
      await tester.pumpAndSettle();
      await tester.tap(BookedFavorWidget_button);
      await tester.pumpAndSettle();
      expect(find.byType(BookedFavorPage_Screen), findsOneWidget);

      /// Find the MarkAsCompleted_button
      final MarkAsCompleted_button = find.byKey(
        Key('MarkAsCompleted_button'),
      );
      await tester.ensureVisible(MarkAsCompleted_button);
      await tester.pumpAndSettle();
      await tester.tap(MarkAsCompleted_button);
      await tester.pumpAndSettle();
      expect(find.byKey(Key("RatingPicker")), findsOneWidget);
    });
  });*/
}

/// Function that
Future safeTapByKey(WidgetTester tester, String key) async {
  await tester.ensureVisible(find.byKey(Key(key)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(key)));
}

Future<void> pumpForSeconds(WidgetTester tester, int seconds) async {
  bool timerDone = false;
  Timer(Duration(seconds: seconds), () => timerDone = true);
  while (timerDone != true) {
    await tester.pump();
  }
}

Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  bool timerDone = false;
  final timer =
      Timer(timeout, () => throw TimeoutException("Pump until has timed out"));
  while (timerDone != true) {
    await tester.pump();

    final found = tester.any(finder);
    if (found) {
      timerDone = true;
    }
  }
  timer.cancel();
}
*/