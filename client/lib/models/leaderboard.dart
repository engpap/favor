import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:project/functions/jsonToDartFunctions.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/models/user.dart';

class Leaderboard {
  final String userType;
  final String location;
  final Map<User, int> leaderboard;

  Leaderboard({
    required this.userType,
    required this.location,
    required this.leaderboard,
  });

  static Leaderboard customFromMap(Map<String, dynamic> json) {
    return Leaderboard(
        userType: json['userType'],
        location: json['location'],
        leaderboard: convertIntoUserScoreMap(json['users']));
  }

  factory Leaderboard.fromJson(Map<String, dynamic> source) =>
      customFromMap(source);
}
