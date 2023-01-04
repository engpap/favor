import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/errorHandling.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/favorCategories.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/providers/storage.dart';
import 'dart:convert';

import 'package:project/providers/userProvider.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/feed/feed.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:provider/provider.dart';
import 'package:project/constants/globalVars.dart';
import 'package:project/models/post.dart';
import 'package:project/models/favorConstants.dart';

class LeaderboardService {
  Future<Leaderboard?> getLeaderboard(
      {required BuildContext context,
      required String userType,
      required String location}) async {
    Leaderboard? leaderboard;
    try {
      http.Response response = await http.get(
          Uri.parse(
              '$uri/leaderboards?userType=${userType}&location=${location}'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
          });

      leaderboard = Leaderboard.fromJson(jsonDecode(response.body)['data']);

      httpErrorHandle(response: response, context: context, onSuccess: () {});
    } catch (error) {
      throw Exception(">>> getLeaderboard exception: " + error.toString());
      //showToast(context, error.toString());
    }
    return leaderboard;
  }
}
