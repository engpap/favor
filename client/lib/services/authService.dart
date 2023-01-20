import 'package:flutter/cupertino.dart';
import 'package:project/constants/globalVars.dart';
import 'package:project/errors/errorConstants.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/helpers/authHelper.dart';
import 'package:project/models/profileConstants.dart';
import 'package:project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:project/providers/storage.dart';
import 'package:project/providers/userProvider.dart';
import 'package:project/errors/error.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/errors/errorHandling.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class AuthService {
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
          'confirmPassword': confirmPassword
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
      /*
      if (response.statusCode == 400 ||
          response.statusCode == 404 ||
          response.statusCode == 500)
        return ErrorMessage(jsonDecode(response.body)['errorType'],
            jsonDecode(response.body)['message']);
      else
        return ErrorMessage(ErrorConstants.NO_ERROR, 'noError');
        */
    } catch (error) {
      throw Exception(">>> signup exception: " + error.toString());
      //showToast(context, error.toString());
      //return ErrorMessage(ErrorConstants.CLIENT_ERROR, 'Client error');
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

      /*
      if (response.statusCode == 201 || response.statusCode == 200) {
        Provider.of<UserProvider>(context, listen: false)
            .setUser(response.body);
        Storage.setUserToken(jsonDecode(response.body)['token']);
        Storage.setUserId(jsonDecode(response.body)['_id']);
        return ErrorMessage(ErrorConstants.NO_ERROR, 'noError');
      } else {
        return ErrorMessage(jsonDecode(response.body)['errorType'],
            jsonDecode(response.body)['message']);
      }*/
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          Storage.setUserToken(jsonDecode(response.body)['token']);
          Storage.setUserId(jsonDecode(response.body)['_id']);
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (context) => const HomeScreen()),
          );
        },
      );
    } catch (error) {
      throw Exception(">>> signin exception: " + error.toString());
      //showToast(context, error.toString());
      //return ErrorMessage(ErrorConstants.CLIENT_ERROR, 'Client error');
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

  Future<ErrorMessage> googleSignIn({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        final googleAuth = await user.authentication;

        // For google calendar
        var httpClient = (await _googleSignIn.authenticatedClient())!;
        Provider.of<UserProvider>(context, listen: false)
            .setGoogleClient(httpClient);
        //Provider.of<UserProvider>(context, listen: false)
        //    .setGoogleClient(httpClient);
        //print(googleAuth.idToken);
        //print(googleAuth.accessToken);
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
            //photoUrl: user.
          }),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          Storage.setUserId(jsonDecode(response.body)['_id']);
          Storage.setUserToken(jsonDecode(response.body)['token']);
          return ErrorMessage(ErrorConstants.NO_ERROR, 'noError');
        } else
          return ErrorMessage(jsonDecode(response.body)['errorType'],
              jsonDecode(response.body)['message']);
      } else {
        return ErrorMessage(ErrorConstants.CLIENT_ERROR,
            'Retrieved a null user object from "Continue with Google" API');
      }
    } catch (error) {
      return ErrorMessage(ErrorConstants.CLIENT_ERROR,
          'Client error for "Continue with Google"');
    }
  }

  //TODO: initAuth from https://medium.com/codex/how-to-build-a-google-sign-in-in-flutter-without-firebase-5d0d379b2f64

  void signout({required BuildContext context}) async {
    Storage.removeUserId();
    Storage.removeToken();
    Provider.of<UserProvider>(context, listen: false).clearUser();
  }
}
