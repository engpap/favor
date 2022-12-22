import 'dart:convert';
import 'package:project/models/post.dart';

class ProviderPost extends Post {
  final DateTime availabilityStartTime;
  final DateTime availabilityEndTime;

  ProviderPost({
    super.id,
    super.creatorId,
    super.createdAt,
    required super.userType,
    required super.taskCategory,
    required super.location,
    required this.availabilityStartTime,
    required this.availabilityEndTime,
    required super.description,
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
        createdAt: json['createdAt'],
        userType: json['userType'],
        taskCategory: json['taskCategory'],
        location: json['location'],
        availabilityStartTime: json['availabilityStartTime'],
        availabilityEndTime: json['availabilityEndTime'],
        description: json['description']);
  }

  factory ProviderPost.fromJson(String source) =>
      customFromMap(json.decode(source));
}
