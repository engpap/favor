import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/booked_favor_page/favorBookedPage.dart';
import 'package:project/screens/explore/providerExplore.dart';
import 'package:provider/provider.dart';

import '../../main_test.dart';
import '../../utility_for_testing/mocks/dummy_models.dart';
import '../../utility_for_testing/mocks/mock_build_context.dart';
import '../../utility_for_testing/mocks/services/admin_service_mock.dart';
import '../../utility_for_testing/mocks/services/apis/google_calendar_api_wrapper_mock.dart';
import '../../utility_for_testing/mocks/services/auth_service_mock.dart';
import '../../utility_for_testing/mocks/services/constants_service_mock.dart';
import '../../utility_for_testing/mocks/services/favor_service_mock.dart';
import '../../utility_for_testing/mocks/services/leaderboard_service_mock.dart';
import '../../utility_for_testing/mocks/services/post_service_mock.dart';
import '../../utility_for_testing/mocks/services/profile_service_mock.dart';

void main() {
  testWidgets('Test MarkAsCompletedButton and rating process',
      (WidgetTester tester) async {
    await tester.pumpWidget(getWidgetToTest(
      BookedFavorPage_Screen(bookedFavor: dummy_bookedFavor1),
    ));

    //Verify the initial state
    expect(find.byKey(Key('MarkAsCompleted_button')), findsOneWidget);

    // Simulate button press
    await tester.tap(find.byKey(Key('MarkAsCompleted_button')));
    await tester.pumpAndSettle();

    // Verify that the rating picker was displayed
    expect(find.byType(CupertinoActionSheet), findsOneWidget);
    expect(find.byKey(Key('RatingPicker')), findsOneWidget);
    expect(find.byType(RatingBar), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);

    // Simulate rating submission
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Verify the final state
    // After rating, the rating bar disappers.
    expect(find.byType(RatingBar), findsNothing);
  });
}
