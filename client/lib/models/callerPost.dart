import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project/models/post.dart';

class CallerPost extends Post {
  final DateTime favorStartTime;

  CallerPost({
    super.id,
    super.creatorId,
    super.name,
    super.surname,
    super.email,
    super.profilePicture,
    super.createdAt,
    required super.userType,
    required super.taskCategory,
    required super.location,
    required this.favorStartTime,
    required super.description,
    required super.averageRatings,
    super.rankingPosition,
    super.rankingLocation,
    super.bio,
  });

  // FOR FEED AND INFORMATION PAGE
  static CallerPost customFromMap(Map<String, dynamic> json) {
    return CallerPost(
      id: json['_id'],
      creatorId: json['creatorId'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      profilePicture: Image.memory(base64Decode(json['profilePicture'])),
      createdAt: json['createdAt'],
      userType: json['userType'],
      taskCategory: json['taskCategory'],
      location: json['location'],
      favorStartTime: DateTime.parse(json['favorStartTime']),
      description: json['description'],
      averageRatings: json['averageRatings'].toInt(),
      rankingPosition: json['rankingPosition'],
      rankingLocation: json['rankingLocation'],
      bio: json['bio'],
    );
  }

  factory CallerPost.fromJson(Map<String, dynamic> source) =>
      customFromMap(source);

  DateTime getFavorStartTime() => this.favorStartTime;
  DateTime getAvailabilityStartTime() =>
      throw Exception("This method should not be called here");
  DateTime getAvailabilityEndTime() =>
      throw Exception("This method should not be called here");
}
