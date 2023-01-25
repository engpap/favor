import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/screens/leaderboard/leaderboard_mobile.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/leaderboard/leaderboard_tablet.dart';
import '../../utility_for_testing/mocks/models/mock_favor_constants.dart';
import '../../utility_for_testing/mocks/models/mock_leaderboard.dart';
import '../../utility_for_testing/mocks/screens/mock_leaderboard_mobile.dart';
import '../../utility_for_testing/mocks/services/mock_leaderboard_service.dart';
import '../../utility_for_testing/utilities.dart';

void main() {
  /*
  TODO: to make it work
  testWidgets('_Leaderboard_Screen_MState should return a FutureBuilder widget',
      (tester) async {
    await tester.pumpWidget(getApp(Leaderboard_Screen_M()));
    await tester.pumpAndSettle();

    final futureBuilderFinder = find.byType(FutureBuilder);
    expect(futureBuilderFinder, findsOneWidget);
  });*/
/*
  testWidgets(
      'getLeaderboard is called when location is inserted in the textfields',
      (tester) async {
    final mockState = MockLeaderboardScreenMState();
    final createStateFn = () => mockState;

    var leaderboardScreenMContext;

    await tester.pumpWidget(
      CupertinoApp(
        home: Builder(
          builder: (context) {
            leaderboardScreenMContext = context;
            return Leaderboard_Screen_M(
                key: UniqueKey(), createStateFn: createStateFn);
          },
        ),
      ),
    );

    mockState.locationsTextEditingController.text = "new";

    mockState.userTypesTextEditingController.addListener(() {});
    mockState.locationsTextEditingController.addListener(() {});

    final leaderboardService = MockLeaderboardService();
    verify(leaderboardService.getLeaderboard(
        context: leaderboardScreenMContext,
        userType: 'userType',
        location: 'new'));
  });*/
}
