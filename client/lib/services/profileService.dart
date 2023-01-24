import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/error_handling.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/models/bookedFavor.dart';
import 'dart:convert';
import 'package:project/constants/globalVars.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class ProfileService {
  Future<User?> getMyUserProfile(BuildContext context) async {
    User? user;
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/user/getMyUserProfile'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'x-auth-token': await Storage.getUserToken(),
      });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            user = User.fromMap(jsonDecode(response.body));
          });
    } catch (error) {
      throw Exception(">>> getMyUserProfile exception: " + error.toString());
    }
    return user;
  }
}