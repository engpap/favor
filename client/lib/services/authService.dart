import 'package:project/constants/globalVars.dart';
import 'package:project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:project/services/errors/error.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

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

  Future<ErrorMessage> signin({
    required String email,
    required String password,
  }) async {
    try {
      //To save data recevied from the server in the client storage.
      final prefs = await SharedPreferences.getInstance();

      http.Response response = await http.post(
        Uri.parse('$uri/user/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 201) {
        //await prefs.setString('x-auth-token', jsonDecode(response.body)['token']);
        await prefs.setString('name', jsonDecode(response.body)['name']);
      }
      return ErrorMessage(jsonDecode(response.body)['errorType'],
          jsonDecode(response.body)['message']);
    } catch (error) {
      return ErrorMessage('client', 'Client error');
    }
  }
}
