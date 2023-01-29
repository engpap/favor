import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/services/leaderboardService.dart';

import '../dummy_models.dart';

class LeaderboardServiceMock extends Mock implements LeaderboardService {
  Future<Leaderboard?> getLeaderboard(
      {required BuildContext context,
      required String? userType,
      required String? location}) async {
    Leaderboard? leaderboard;

    return Leaderboard(
        userType: "caller",
        location: "LORETO",
        leaderboard: {dummy_user: 45, dummy_user_2: 34});
  }
}
