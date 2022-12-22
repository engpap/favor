import 'dart:convert';

import 'package:project/models/post.dart';

class CallerPost extends Post {
  final DateTime favorStartTime;

  CallerPost({
    super.id,
    super.creatorId,
    super.createdAt,
    required super.userType,
    required super.taskCategory,
    required super.location,
    required this.favorStartTime,
    required super.description,
  });

  Map<String, dynamic> toJson() => {
        'userType': userType,
        'taskCategory': taskCategory,
        'location': location,
        'favorStartTime': favorStartTime.toIso8601String(),
        'description': description,
      };

  static CallerPost customFromMap(Map<String, dynamic> json) {
    return CallerPost(
        id: json['_id'],
        creatorId: json['creatorId'],
        createdAt: json['createdAt'],
        userType: json['userType'],
        taskCategory: json['taskCategory'],
        location: json['location'],
        favorStartTime: json['favorStartTime'],
        description: json['description']);
  }

  factory CallerPost.fromJson(String source) =>
      customFromMap(json.decode(source));
}
