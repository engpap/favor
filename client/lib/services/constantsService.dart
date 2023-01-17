import 'package:http/http.dart' as http;
import 'package:project/models/favorCategories.dart';
import 'package:project/models/favorConstants.dart';

import 'package:project/models/profileConstants.dart';

import 'dart:convert';

import 'package:project/constants/globalVars.dart';

class ConstantsService {
  Future<ProfileConstants> getProfileConstants() async {
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/user/getProfileConstants'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      });
      if (response.statusCode == 200)
        return ProfileConstants.fromJson(jsonDecode(response.body));
      else
        throw Exception('Failed to get favor constants! Error message: ' +
            jsonDecode(response.body)['message']);
    } catch (error) {
      throw Exception(
          'Failed to get favor contstants! Error: ' + error.toString());
    }
  }

  Future<FavorCategories> getFavorCategories() async {
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/posts/getFavorCategories'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      });
      if (response.statusCode == 200)
        return FavorCategories.fromJson(jsonDecode(response.body));
      else
        throw Exception('Failed to get favor constants! Error message: ' +
            jsonDecode(response.body)['message']);
    } catch (error) {
      throw Exception(
          'Failed to get favor contstants! Error: ' + error.toString());
    }
  }

  Future<FavorConstants> getFavorConstants() async {
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/posts/getFavorConstants'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      });
      if (response.statusCode == 200)
        return FavorConstants.fromJson(jsonDecode(response.body));
      else
        throw Exception('Failed to get favor constants! Error message: ' +
            jsonDecode(response.body)['message']);
    } catch (error) {
      throw Exception(
          'Failed to get favor contstants! Error: ' + error.toString());
    }
  }
}
