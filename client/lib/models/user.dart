import 'dart:convert';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? confirmPassword;
  final String? token;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.confirmPassword,
    this.token,
  });

  ///The following code has the purpose of JSON stringify the user object.
  User.fromMap(Map<String, dynamic> json)
      : id = json['_id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        password = json['password'],
        confirmPassword = json['confirmPassword'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'token': token,
      };

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
