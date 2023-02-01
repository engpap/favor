import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/admin.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/screens/signup2/signup2.dart';
import 'package:project/services/authService.dart';
import 'package:provider/provider.dart';
import '../dummy_models.dart';

/// Assumptions: Server works properly
class AuthServiceMock extends Mock implements AuthService {
  Future insertPersonalInfo({
    required context,
    required String gender,
    required String age,
    required String city,
    required String job,
    required String bio,
  }) {
    return Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => SignInScreen()));
  }

  Future<void> signup({
    required BuildContext context,
    required String name,
    required String surname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    Storage.setUserToken('valid_token');
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => SignUp2Screen()));
  }

  /// Hypothesis: user is not an admin
  Future<void> signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    Storage.setUserId("userId");
    Provider.of<UserProvider>(context, listen: false)
        .setUserByUserObject(dummy_user);
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => HomeScreen()),
    );
  }

  /// Hp: it is a first time user
  Future googleSignIn({required BuildContext context}) async {
    Storage.setUserId("userId");
    Storage.setUserToken("valid_token");
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const SignUp2Screen(),
        ));
  }

  void signout({required BuildContext context}) async {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => SignInScreen()));
  }
}

/// Assumptions: Server works properly
class AdminAuthServiceMock extends Mock implements AuthService {
  Future insertPersonalInfo({
    required context,
    required String gender,
    required String age,
    required String city,
    required String job,
    required String bio,
  }) async {}

  Future<void> signup({
    required BuildContext context,
    required String name,
    required String surname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {}

  /// Hypothesis: user is not an admin
  Future<void> signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => AdminScreen()),
    );
  }

  /// Hp: it is a first time user
  Future googleSignIn({required BuildContext context}) async {}

  void signout({required BuildContext context}) async {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => SignInScreen()));
  }
}
