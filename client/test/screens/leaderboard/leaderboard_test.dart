import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import '../../utility_for_testing/utilities.dart';

void main() {
  testWidgets(
      'LeaderboardCard should return a CupertinoButton widget with correct color',
      (tester) async {
    var leaderboardCard = LeaderboardCard(
      personImage: MemoryImage(base64Decode(noProfilePicture64String)),
      personName: 'Mario',
      personSurname: 'Rossi',
      leaderboardPosition: 1,
      starsNumber: 3,
    );
    await tester.pumpWidget(getApp(leaderboardCard));

    final cupertinoButtonFinder = find.byType(CupertinoButton);
    final cupertinoButton =
        cupertinoButtonFinder.evaluate().first.widget as CupertinoButton;
    expect(cupertinoButton.color, equals(favorColors.IntroBg));
  });
}
