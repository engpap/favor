import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:project/models/post.dart';

class ProviderPost extends Post {
  final DateTime availabilityStartTime;
  final DateTime availabilityEndTime;

  ProviderPost({
    super.id,
    super.creatorId,
    super.name,
    super.surname,
    super.profilePicture,
    super.createdAt,
    required super.userType,
    required super.taskCategory,
    required super.location,
    required this.availabilityStartTime,
    required this.availabilityEndTime,
    required super.description,
    super.averageStars,
    super.rankingPosition,
    super.rankingLocation,
  });

  Map<String, dynamic> toJson() => {
        'userType': userType,
        'taskCategory': taskCategory,
        'location': location,
        'availabilityStartTime': availabilityStartTime.toIso8601String(),
        'availabilityEndTime': availabilityEndTime.toIso8601String(),
        'description': description,
      };

  static ProviderPost customFromMap(Map<String, dynamic> json) {
    return ProviderPost(
      id: json['_id'],
      creatorId: json['creatorId'],
      name: json['name'],
      surname: json['surname'],
      profilePicture: Image.asset(
          "assets/images/default_profile_picture.png"), //TODO: change with dynamic image got from server
      createdAt: json['createdAt'],
      userType: json['userType'],
      taskCategory: json['taskCategory'],
      location: json['location'],
      availabilityStartTime: json['availabilityStartTime'],
      availabilityEndTime: json['availabilityEndTime'],
      description: json['description'],
      averageStars: json['averageStars'],
      rankingPosition: json['rankingPosition'],
      rankingLocation: json['rankingLocation'],
    );
  }

  factory ProviderPost.fromJson(String source) =>
      customFromMap(json.decode(source));
}
