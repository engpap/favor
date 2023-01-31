import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/error_handling.dart';
import 'package:project/models/leaderboard.dart';
import 'dart:convert';
import 'package:project/constants/globalVars.dart';


class LeaderboardService {
  Future<Leaderboard?> getLeaderboard(
      {required BuildContext context,
      required String? userType,
      required String? location}) async {
    Leaderboard? leaderboard;

    if (userType == null ||
        userType.length == 0 ||
        location == null ||
        location.length == 0) return null;
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$uri/leaderboards?userType=${userType}&location=${location}'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
          });

      httpErrorHandle(
        response: response,
        context: context,
        showToastStatus: false,
        onSuccess: () {
          leaderboard = Leaderboard.fromJson(jsonDecode(response.body)['data']);
        },
      );
    } catch (error) {
      throw Exception(">>> getLeaderboard exception: " + error.toString());
    }
    return leaderboard;
  }
}
