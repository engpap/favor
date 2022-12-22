import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:project/constants/globalVars.dart';
import 'package:project/models/post.dart';
import 'package:project/models/favorConstants.dart';

class PostService {
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

  Future<Post> publishProviderFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required favorStartTime,
      required favorEndTime,
      required description}) async {
    try {
      Post post = Post(
          userType: 'PROVIDER',
          taskCategory: taskCategory,
          location: location,
          favorStartTime: favorStartTime,
          favorEndTime: favorEndTime,
          description: description);

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response response = await http.post(
        Uri.parse('$uri/posts/create'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 201)
        return Post.fromJson(jsonDecode(response.body));
      else
        throw Exception('Failed to create favor! Error message: ' +
            jsonDecode(response.body)['message']);
    } catch (error) {
      throw Exception('Failed to create favor! Error: ' + error.toString());
    }
  }
}
