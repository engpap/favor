import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/services/profileService.dart';
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
    Future.delayed(const Duration(seconds: 0), () {
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => const SignInScreen()));
    });
    return null;
  }

  Future<User?> getUserProfileById(BuildContext context, String id) async {
    return dummy_user;
  }
}
