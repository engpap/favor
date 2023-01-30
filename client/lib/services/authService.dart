import 'package:flutter/cupertino.dart';
import 'package:project/constants/globalVars.dart';
import 'package:project/helpers/auth_helper.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/storage.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/admin.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/screens/signup2/signup2.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/errors/error_handling.dart';

class AuthService {
  Future insertPersonalInfo({
    required context,
    required String gender,
    required String age,
    required String city,
    required String job,
    required String bio,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/user/insertPersonalInfo'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': await Storage.getUserToken(),
        },
        body: jsonEncode({
          'gender': gender,
          'age': age,
          'city': city,
          'job': job,
          'profilePicture': noProfilePicture64String,
          'bio': bio,
        }),
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => SignInScreen()));
        },
      );
    } catch (error) {
      throw Exception(">>> insertPersonalInfo exception: " + error.toString());
    }
  }

  Future<void> signup({
    required BuildContext context,
    required String name,
    required String surname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/user/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'surname': surname,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Storage.setUserToken(jsonDecode(response.body)['token']);
          Navigator.pushReplacement(context,
              CupertinoPageRoute(builder: (context) => SignUp2Screen()));
        },
      );
    } catch (error) {
      throw Exception(">>> signup exception: " + error.toString());
    }
  }

  Future<void> signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/user/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Storage.setUserToken(jsonDecode(response.body)['token']);

          // If it is an admin then set the userId in the storage as "adminId"
          // and push the user to the AdminScreen.
          if (jsonDecode(response.body)['admin'] == true) {
            Storage.setUserId('adminId');
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                      AdminScreen()), //TODO: here should be inserted ADMIN SCREEN
            );
          } else
          // If it is not an admin then set the userId in the storage
          // and push the user to the HomeScreen.
          {
            Storage.setUserId(jsonDecode(response.body)['_id']);
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
      );
    } catch (error) {
      throw Exception(">>> signin exception: " + error.toString());
    }
  }

  // ref https://github.com/flutter/flutter/issues/33261

  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: AuthHelper().clientID(),
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'openid',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/calendar',
    ],
  );

  Future googleSignIn({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        final googleAuth = await user.authentication;

        http.Response response = await http.post(
          Uri.parse('$uri/user/continue'),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
          },
          body: jsonEncode({
            'name': user.displayName,
            'surname': '',
            'email': user.email,
            'tokenId': googleAuth.idToken,
          }),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          Storage.setUserId(jsonDecode(response.body)['_id']);
          Storage.setUserToken(jsonDecode(response.body)['token']);

          // If response.statusCode is 201, then it means it is a new user
          if (response.statusCode == 201)
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (context) => const SignUp2Screen()));
          else
            // If response.statusCode is 200, then it means it is an
            // already registered user
            Navigator.pushReplacement(context,
                CupertinoPageRoute(builder: (context) => HomeScreen()));
        } else {
          httpErrorHandle(
              response: response, context: context, onSuccess: () {});
        }
      } else {
        throw Exception(
            ">>> googleSignIn not working properly. It may be an error from Google");
      }
    } catch (error) {
      throw Exception(">>> googleSignIn exception: " + error.toString());
    }
  }

  //TODO: initAuth from https://medium.com/codex/how-to-build-a-google-sign-in-in-flutter-without-firebase-5d0d379b2f64

  void signout({required BuildContext context}) async {
    Storage.removeUserId();
    Storage.invalidateToken();
    Provider.of<UserProvider>(context, listen: false).clearUser();
    try {
      _googleSignIn.signOut();
    } catch (error) {
      print("Not signed out as google user");
    }
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => SignInScreen()));
  }
}
