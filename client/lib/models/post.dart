import 'dart:convert';

import 'package:flutter/cupertino.dart';

abstract class Post {
  final String? id;
  final String? creatorId;
  final String? name;
  final String? surname;
  final Image? profilePicture;
  final String? createdAt;
  final String userType;
  final String taskCategory;
  final String location;
  final String description;
  final double? averageStars;
  final int? rankingPosition;
  final String? rankingLocation;

  Post({
    this.id,
    this.creatorId,
    this.createdAt,
    this.name,
    this.surname,
    this.profilePicture,
    required this.userType,
    required this.taskCategory,
    required this.location,
    required this.description,
    this.averageStars,
    this.rankingPosition,
    this.rankingLocation,
  });

  static String getUserType(Map<String, dynamic> jsonString) {
    return jsonString['userType'];
  }
}
