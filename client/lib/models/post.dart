import 'dart:convert';

class Post {
  final String? id;
  final String? creatorId;
  final String? createdAt;
  final String userType;
  final String taskCategory;
  final String location;
  final DateTime taskStartTime;
  final DateTime taskEndTime;
  final String description;

  Post({
    this.id,
    this.creatorId,
    this.createdAt,
    required this.userType,
    required this.taskCategory,
    required this.location,
    required this.taskStartTime,
    required this.taskEndTime,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'userType': userType,
        'taskCategory': taskCategory,
        'location': location,
        'taskStartTime': taskStartTime.toIso8601String(),
        'taskEndTime': taskEndTime.toIso8601String(),
        'description': description,
      };

  Post.fromMap(Map<String, dynamic> json)
      : id = json['_id'],
        creatorId = json['creatorId'],
        createdAt = json['createdAt'],
        userType = json['userType'],
        taskCategory = json['taskCategory'],
        location = json['location'],
        taskStartTime = json['taskStartTime'],
        taskEndTime = json['taskEndTime'],
        description = json['description'];

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
