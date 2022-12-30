import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/functions/showToast.dart';
import 'package:project/screens/signin/signin.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  if (response.statusCode >= 200 && response.statusCode < 300)
    onSuccess();
  else if (response.statusCode == 401) {
    showToast(context, jsonDecode(response.body)['message']);
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const SignInScreen()));
  } else if (response.statusCode >= 400)
    showToast(context, jsonDecode(response.body)['message']);
  else
    showToast(context, response.body);
}
