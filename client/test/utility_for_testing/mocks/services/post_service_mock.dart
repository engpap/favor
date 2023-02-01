import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:project/screens/home.dart';
import 'package:project/models/post.dart';
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
