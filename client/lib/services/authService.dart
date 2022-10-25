import 'package:flutter/cupertino.dart';
import 'package:project/constants/globalVars.dart';
import 'package:project/errors/errorConstants.dart';
import 'package:project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:project/providers/userProvider.dart';
import 'package:project/errors/error.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<ErrorMessage> signup({
    required String name,
    required String surname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        surname: surname,
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

      if (response.statusCode == 400 ||
          response.statusCode == 404 ||
          response.statusCode == 500)
        return ErrorMessage(jsonDecode(response.body)['errorType'],
            jsonDecode(response.body)['message']);
      else
        return ErrorMessage(ErrorConstants.NO_ERROR, 'noError');
    } catch (error) {
      return ErrorMessage(ErrorConstants.CLIENT_ERROR, 'Client error');
    }
  }

  Future<ErrorMessage> signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      //To save data recevied from the server in the client storage.
      final _prefs = await SharedPreferences.getInstance();

      http.Response response = await http.post(
        Uri.parse('$uri/user/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(response.body);
        await _prefs.setString('id', jsonDecode(response.body)['_id']);
        await _prefs.setString('token', jsonDecode(response.body)['token']);
        return ErrorMessage(ErrorConstants.NO_ERROR, 'noError');
      } else {
        return ErrorMessage(jsonDecode(response.body)['errorType'],
            jsonDecode(response.body)['message']);
      }
    } catch (error) {
      return ErrorMessage(ErrorConstants.CLIENT_ERROR, 'Client error');
    }
  }

  void signout({required BuildContext context}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('id');
    _prefs.remove('token');
    Provider.of<UserProvider>(context, listen: false).clearUser();
  }
}
