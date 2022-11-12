import 'dart:convert';

class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String password;
  final String? confirmPassword;
  final String? token;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    this.confirmPassword,
    this.token,
  });

  ///The following code has the purpose of JSON stringify the user object.
  User.fromMap(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        surname = json['surname'],
        email = json['email'],
        password = json['password'],
        confirmPassword = json['confirmPassword'],
        token = json['token'];

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
