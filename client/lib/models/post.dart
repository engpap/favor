import 'dart:convert';

abstract class Post {
  final String? id;
  final String? creatorId;
  final String? createdAt;
  final String userType;
  final String taskCategory;
  final String location;
  final String description;

  Post({
    this.id,
    this.creatorId,
    this.createdAt,
    required this.userType,
    required this.taskCategory,
    required this.location,
    required this.description,
  });
}
