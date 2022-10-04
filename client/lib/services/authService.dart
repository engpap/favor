import 'package:project/constants/globalVars.dart';
import 'package:project/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  void signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      User user = User(
        id: '',
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      http.Response response = await http.post(
        Uri.parse('$uri/user/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
    } catch (error) {
      // TODO
      print("error");
    }
  }

  void signin({
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/user/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
    } catch (error) {
      // TODO
      print("error");
    }
  }
}
