import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/callerPost.dart';
import 'package:project/models/providerPost.dart';
import 'dart:convert';

import 'package:project/providers/userProvider.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin.dart';
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

  Future<Post?> publishProviderFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required availabilityStartTime,
      required availabilityEndTime,
      required description}) async {
    try {
      if (!isUserModeAsProvider())
        throw Exception(
            "Trying to publish a favor as Provider but userType is not Provider!");

      ProviderPost post = ProviderPost(
          userType: getUserMode(),
          taskCategory: taskCategory,
          location: location,
          availabilityStartTime: availabilityStartTime,
          availabilityEndTime: availabilityEndTime,
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
        return ProviderPost.fromJson(jsonDecode(response.body));
      else if (response.statusCode == 400) {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const SignInScreen()));
        return null;
      } else
        throw Exception('Failed to create favor! Error message: ' +
            jsonDecode(response.body)['message']);
    } catch (error) {
      throw Exception('Failed to create favor! Error: ' + error.toString());
    }
  }

  Future<Post?> publishCallerFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required favorStartTime,
      required description}) async {
    try {
      if (!isUserModeAsCaller())
        throw Exception(
            "Trying to publish a favor as Caller but userType is not Caller!");
      CallerPost post = CallerPost(
          userType: getUserMode(),
          taskCategory: taskCategory,
          location: location,
          favorStartTime: favorStartTime,
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
        return CallerPost.fromJson(jsonDecode(response.body));
      else if (response.statusCode == 400) {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const SignInScreen()));
        return null;
      } else
        throw Exception('Failed to create favor! Error message: ' +
            jsonDecode(response.body)['message']);
    } catch (error) {
      throw Exception('Failed to create favor! Error: ' + error.toString());
    }
  }

  Future<List<Post>> getPosts(
      {required BuildContext context, required int pageNumber}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Post> posts = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/posts?page=${pageNumber}'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      if (response.statusCode == 200) {
        for (int i = 0; i < jsonDecode(response.body).length; i++) {
          if (Post.getUserType(response.body) == 'provider')
            posts.add(
              ProviderPost.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          else if (Post.getUserType(response.body) == 'caller')
            posts.add(
              CallerPost.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          else
            throw Exception(
                'Failed to get favor due to wrong userType attribute!');
        }
      } else
        throw Exception('Failed to get favors! Server error message: ' +
            jsonDecode(response.body)['message']);
    } catch (error) {
      throw Exception(error.toString());
    }
    return posts;
  }

  Future<Post> getPost(
      {required BuildContext context, required String id}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Post post;
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/posts/${id}'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      if (response.statusCode == 200) {
        if (Post.getUserType(response.body) == 'provider')
          post = ProviderPost.fromJson(
            jsonEncode(jsonDecode(response.body)),
          );
        else if (Post.getUserType(response.body) == 'caller')
          post = CallerPost.fromJson(jsonEncode(jsonDecode(response.body)));
        else
          throw Exception(
              'Failed to get favor due to wrong userType attribute!');
      } else
        throw Exception('Failed to get favors! Server error message: ' +
            jsonDecode(response.body)['message']);
    } catch (error) {
      throw Exception(error.toString());
    }
    return post;
  }
}
