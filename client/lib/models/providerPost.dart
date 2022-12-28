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
    super.bio,
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
      profilePicture: Image.memory(base64Decode(json['profilePicture'])),
      createdAt: json['createdAt'],
      userType: json['userType'],
      taskCategory: json['taskCategory'],
      location: json['location'],
      availabilityStartTime: DateTime.parse(json['availabilityStartTime']),
      availabilityEndTime: DateTime.parse(json['availabilityEndTime']),
      description: json['description'],
      averageStars: json['averageStars'],
      rankingPosition: json['rankingPosition'],
      rankingLocation: json['rankingLocation'],
      bio: json['bio'],
    );
  }

  factory ProviderPost.fromJson(Map<String, dynamic> source) =>
      customFromMap(source);

  DateTime getfavorStartTime() =>
      throw Exception("This method should not be called here");
  DateTime getavailabilityStartTime() => this.availabilityEndTime;
  DateTime getavailabilityEndTime() => this.availabilityEndTime;
}
