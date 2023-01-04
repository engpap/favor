import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/errorHandling.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/favorCategories.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/providers/storage.dart';
import 'dart:convert';

import 'package:project/providers/userProvider.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/feed/feed.dart';
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

  Future<void> publishProviderFavor(
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

      /*ProviderPost post = ProviderPost(
          userType: getUserMode(),
          taskCategory: taskCategory,
          location: location,
          availabilityStartTime: availabilityStartTime,
          availabilityEndTime: availabilityEndTime,
          description: description);*/
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response response = await http.post(
        Uri.parse('$uri/posts/create'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'userType': getUserMode(),
          'taskCategory': taskCategory,
          'location': location,
          'availabilityStartTime': availabilityStartTime,
          'availabilityEndTime': availabilityEndTime,
          'description': description
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => favorInformationPage_Screen(
                      post: ProviderPost.fromJson(jsonDecode(response.body)))));
        },
      );
    } catch (error) {
      throw Exception(
          ">>> publishProviderFavor exception: " + error.toString());
    }
  }

  Future<void> publishCallerFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required favorStartTime,
      required description}) async {
    try {
      if (!isUserModeAsCaller())
        throw Exception(
            "Trying to publish a favor as Caller but userType is not Caller!");
      /*CallerPost post = CallerPost(
          userType: getUserMode(),
          taskCategory: taskCategory,
          location: location,
          favorStartTime: favorStartTime,
          description: description);*/

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response response = await http.post(
        Uri.parse('$uri/posts/create'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'userType': getUserMode(),
          'taskCategory': taskCategory,
          'location': location,
          'favorStartTime': favorStartTime,
          'description': description
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => favorInformationPage_Screen(
                      post: ProviderPost.fromJson(jsonDecode(response.body)))));
        },
      );
    } catch (error) {
      throw Exception(">>> publishCallerFavor exception: " + error.toString());
    }
  }

  Future<List<Post>> getPosts(BuildContext context, int pageNumber) async {
    List<Post> posts = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/posts?page=${pageNumber}'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      });

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body)['data'].length; i++) {
            if (Post.getUserTypeGivenJsonString(
                    jsonDecode(response.body)['data'][i]) ==
                'provider')
              posts.add(
                ProviderPost.fromJson(
                  jsonDecode(response.body)['data'][i],
                ),
              );
            else if (Post.getUserTypeGivenJsonString(
                    jsonDecode(response.body)['data'][i]) ==
                'caller')
              posts.add(
                CallerPost.fromJson(
                  jsonDecode(response.body)['data'][i],
                ),
              );
            else
              showToast(context,
                  'Failed to get favor due to wrong userType attribute!');
          }
        },
      );
    } catch (error) {
      throw Exception(">>> getPosts exception: " + error.toString());
    }
    return posts;
  }

  Future<List<Post>> getPostsBySearch(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Post> posts = [];
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/posts/search?searchQuery=${searchQuery}'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body)['data'].length; i++) {
            if (Post.getUserTypeGivenJsonString(
                    jsonDecode(response.body)['data']) ==
                'provider')
              posts.add(
                ProviderPost.fromJson(
                  jsonDecode(response.body)['data'][i],
                ),
              );
            else if (Post.getUserTypeGivenJsonString(
                    jsonDecode(response.body)['data']) ==
                'caller')
              posts.add(
                CallerPost.fromJson(
                  jsonDecode(response.body)['data'][i],
                ),
              );
            else
              showToast(context,
                  'Failed to get favor due to wrong userType attribute!');
          }
        },
      );
    } catch (error) {
      throw Exception(">>> getPostsBySearch exception: " + error.toString());
    }
    return posts;
  }

  Future<void> bookFavor({
    required BuildContext context,
    required Post? post,
  }) async {
    try {
      if (post?.userType == getUserMode())
        showToast(context,
            "Cannot book favor if User Mode is the same of publisher!");

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response response = await http.post(
        Uri.parse('$uri/posts/${post?.id}/bookFavor'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => Feed_Screen()));
        },
      );
    } catch (error) {
      throw Exception(">>> bookFavor exception: " + error.toString());
    }
  }
}
