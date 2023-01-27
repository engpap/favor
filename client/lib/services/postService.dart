import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/error_handling.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/helpers/storage.dart';
import 'dart:convert';

import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/home.dart';
import 'package:project/constants/globalVars.dart';
import 'package:project/models/post.dart';

import 'package:project/screens/favor/globals.dart' as globals_favor;
import 'package:project/functions/favorTime.dart' as favorTime;

class PostService {
  Future<void> publishProviderFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required availabilityStartTime,
      required availabilityEndTime,
      required description}) async {
    try {
      if (!UserMode_inherited.of(context).stateWidget.providerStatus_state)
        throw Exception(
            "Trying to publish a favor as Provider but userType is not Provider!");

      /*ProviderPost post = ProviderPost(
          userType: getUserMode(),
          taskCategory: taskCategory,
          location: location,
          availabilityStartTime: availabilityStartTime,
          availabilityEndTime: availabilityEndTime,
          description: description);*/

      http.Response response = await http.post(
        Uri.parse('$uri/posts/create'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': await Storage.getUserToken(),
        },
        body: jsonEncode({
          'userType': UserMode_inherited.of(context).stateWidget.getUserMode(),
          'taskCategory': taskCategory,
          'location': location,
          'availabilityStartTime': availabilityStartTime.toIso8601String(),
          'availabilityEndTime': availabilityEndTime.toIso8601String(),
          'description': description
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          // TODO: refresh home
          // ***

          // Reset Variables
          globals_favor.categoryTextController.clear();
          globals_favor.locationTextController.clear();
          globals_favor.boxDescriptionTextController.clear();
          globals_favor.availabilityStartTimeTextController.text =
              favorTime.formatter.format(DateTime.now());
          globals_favor.availabilityEndTimeTextController.text =
              favorTime.formatter.format(DateTime.now());
          globals_favor.favorStartTimeTextController.text =
              favorTime.formatter.format(DateTime.now());

          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => favorInformationPage_Screen(
                        post: ProviderPost.fromJson(jsonDecode(response.body)),
                        userType: 'provider',
                      )));
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
      if (!UserMode_inherited.of(context).stateWidget.callerStatus_state)
        throw Exception(
            "Trying to publish a favor as Caller but userType is not Caller!");
      /*CallerPost post = CallerPost(
          userType: getUserMode(),
          taskCategory: taskCategory,
          location: location,
          favorStartTime: favorStartTime,
          description: description);*/

      http.Response response = await http.post(
        Uri.parse('$uri/posts/create'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': await Storage.getUserToken(),
        },
        body: jsonEncode({
          'userType': UserMode_inherited.of(context).stateWidget.getUserMode(),
          'taskCategory': taskCategory,
          'location': location,
          'favorStartTime': favorStartTime.toIso8601String(),
          'description': description
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          // TODO: refresh home
          // ***

          // Reset Variables
          globals_favor.categoryTextController.clear();
          globals_favor.locationTextController.clear();
          globals_favor.boxDescriptionTextController.clear();
          globals_favor.availabilityStartTimeTextController.text =
              favorTime.formatter.format(DateTime.now());
          globals_favor.availabilityEndTimeTextController.text =
              favorTime.formatter.format(DateTime.now());
          globals_favor.favorStartTimeTextController.text =
              favorTime.formatter.format(DateTime.now());

          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => favorInformationPage_Screen(
                        post: CallerPost.fromJson(jsonDecode(response.body)),
                        userType: 'caller',
                      )));
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
      {required BuildContext context,
      required String searchQuery,
      required String userTypeToSearch}) async {
    List<Post> posts = [];
    try {
      print(
          ">>> getPostsBySearch: Searching ${userTypeToSearch} posts containing :" +
              searchQuery);
      http.Response response = await http.get(
          Uri.parse(
              '$uri/posts/search?searchQuery=${searchQuery}&userTypeToSearch=${userTypeToSearch}'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': await Storage.getUserToken(),
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
      throw Exception(">>> getPostsBySearch exception: " + error.toString());
    }
    return posts;
  }

  Future<void> bookFavor(
      {required BuildContext context,
      required Post? post,
      required String userType}) async {
    try {
      if (post?.userType ==
          //UserMode_inherited.of(context).stateWidget.getUserMode() TODO: check it
          userType) {
        showToast(context,
            "Cannot book favor if User Mode is the same of publisher!");
        return;
      }

      http.Response response = await http.post(
        Uri.parse('$uri/posts/${post?.id}/bookFavor'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': await Storage.getUserToken(),
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          // TODO: refresh home
          // ***

          /** OLD
           Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => Feed_Screen()));
          */
          Navigator.pop(context); //TODO: check
        },
      );
    } catch (error) {
      throw Exception(">>> bookFavor exception: " + error.toString());
    }
  }
}
