import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:project/errors/error_handling.dart';
import 'package:project/models/user.dart';
import 'package:project/services/profileService.dart';
import 'package:http/http.dart' as http;
import '../dummy_models.dart';

class ProfileServiceMock extends Mock implements ProfileService {
  Future<User?> getMyUserProfile(BuildContext context) async {
    return dummy_user;
  }

  Future<User?> getUserProfileById(BuildContext context, String id) async {
    return dummy_user;
  }
}

class ProfileServiceMock_Unauthorized extends Mock implements ProfileService {
  Future<User?> getMyUserProfile(BuildContext context) async {
    var response = http.Response('{"message": "Unauthorized"}', 401);
    httpErrorHandle(response: response, context: context, onSuccess: () {});
  }

  Future<User?> getUserProfileById(BuildContext context, String id) async {
    return dummy_user;
  }
}
