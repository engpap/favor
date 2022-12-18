import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:project/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:project/constants/globalVars.dart';
import 'package:project/models/post.dart';

class PostService {
  Future<Post> publishProviderFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required taskStartTime,
      required taskEndTime,
      required description}) async {
    try {
      Post post = Post(
          userType: 'PROVIDER',
          taskCategory: taskCategory,
          location: location,
          taskStartTime: taskStartTime,
          taskEndTime: taskEndTime,
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
