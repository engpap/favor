import 'package:flutter/cupertino.dart';

abstract class Post {
  final String? id;
  final String? creatorId;
  final String? name;
  final String? surname;
  final String? email;
  final Image? profilePicture;
  final String? createdAt;
  final String userType;
  final String taskCategory;
  final String location;
  final String description;
  final int averageRatings;
  final int? rankingPosition;
  final String? rankingLocation;
  final String? bio;

  Post({
    this.id,
    this.creatorId,
    this.createdAt,
    this.name,
    this.surname,
    this.email,
    this.profilePicture,
    required this.userType,
    required this.taskCategory,
    required this.location,
    required this.description,
    required this.averageRatings,
    this.rankingPosition,
    this.rankingLocation,
    this.bio,
  });

  static String getUserTypeGivenJsonString(Map<String, dynamic> jsonString) {
    return jsonString['userType'];
  }

  DateTime getFavorStartTime();
  DateTime getAvailabilityStartTime();
  DateTime getAvailabilityEndTime();
}
