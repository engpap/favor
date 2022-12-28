import 'dart:convert';

import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String? name;
  final String? surname;
  final Image? profilePicture;
  final String email;
  final String? password;
  final String? confirmPassword;
  final String token;
  final int? rankingPoints;
  final double? averageStars;

  User({
    required this.id,
    required this.name,
    required this.surname,
    this.profilePicture,
    required this.email,
    this.password,
    this.confirmPassword,
    required this.token,
    this.rankingPoints,
    this.averageStars,
  });

  ///The following code has the purpose of JSON stringify the user object.
  User.fromMap(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        surname = json['surname'],
        profilePicture = null,
        email = json['email'],
        password = json['password'],
        confirmPassword = json['confirmPassword'],
        token = json['token'],
        rankingPoints = json['rankingPoints'],
        averageStars = json['averageStars'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'surname': surname,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'token': token,
      };

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
