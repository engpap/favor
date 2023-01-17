import 'dart:convert';

import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String name;
  final String surname;
  final MemoryImage profilePicture;
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? token;
  final int? rankingPoints;
  final int? averageRatings;
  final String? bio;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.profilePicture,
    this.email,
    this.password,
    this.confirmPassword,
    this.token,
    this.rankingPoints,
    this.averageRatings,
    this.bio,
  });

  ///The following code has the purpose of JSON stringify the user object.
  User.fromMap(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        surname = json['surname'],
        profilePicture = MemoryImage(base64Decode(json['profilePicture'])),
        //Image.memory(base64Decode(json['profilePicture'])),
        email = json['email'],
        password = json['password'],
        confirmPassword = json['confirmPassword'],
        token = json['token'],
        rankingPoints =
            json['rankingPoints'] != null ? json['rankingPoints'] : 0,
        averageRatings =
            json['rankingPoints'] != null ? json['rankingPoints'] : 0,
        bio = json['bio'];

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
