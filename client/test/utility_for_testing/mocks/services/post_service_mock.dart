import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:project/errors/error_handling.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/helpers/storage.dart';
import 'dart:convert';

import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/feed/feed.dart';
import 'package:project/screens/home.dart';
import 'package:project/constants/globalVars.dart';
import 'package:project/models/post.dart';

import 'package:project/screens/favor/globals.dart' as globals_favor;
import 'package:project/functions/favorTime.dart' as favorTime;
import 'package:project/services/postService.dart';

import '../dummy_models.dart';

class PostServiceMock extends Mock implements PostService {
  Future<void> publishProviderFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required availabilityStartTime,
      required availabilityEndTime,
      required description}) async {}

  Future<void> publishCallerFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required favorStartTime,
      required description}) async {}

  Future<List<Post>> getPosts(BuildContext context, int pageNumber) async {
    return [dummy_caller_post, dummy_provider_post];
  }

  Future<List<Post>> getPostsBySearch(
      {required BuildContext context,
      required String searchQuery,
      required String userTypeToSearch}) async {
    return [dummy_caller_post, dummy_provider_post];
  }

  Future bookFavor(
      {required BuildContext context,
      required Post? post,
      required String userType}) async {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => HomeScreen()));
  }
}
