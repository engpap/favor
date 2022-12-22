import 'dart:convert';

class Post {
  final String? id;
  final String? creatorId;
  final String? createdAt;
  final String userType;
  final String taskCategory;
  final String location;
  final DateTime favorStartTime;
  final DateTime favorEndTime;
  final String description;

  Post({
    this.id,
    this.creatorId,
    this.createdAt,
    required this.userType,
    required this.taskCategory,
    required this.location,
    required this.favorStartTime,
    required this.favorEndTime,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'userType': userType,
        'taskCategory': taskCategory,
        'location': location,
        'favorStartTime': favorStartTime.toIso8601String(),
        'favorEndTime': favorEndTime.toIso8601String(),
        'description': description,
      };

  Post.fromMap(Map<String, dynamic> json)
      : id = json['_id'],
        creatorId = json['creatorId'],
        createdAt = json['createdAt'],
        userType = json['userType'],
        taskCategory = json['taskCategory'],
        location = json['location'],
        favorStartTime = json['favorStartTime'],
        favorEndTime = json['favorEndTime'],
        description = json['description'];

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
