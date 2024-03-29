import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

/// Custom Toast will not work on android 11 and above,
/// it will only use msg and toastLength remaining all properties are ignored.
void showToast(BuildContext context, String text) {
  Fluttertoast.showToast(
    msg: text,
    fontSize: 18,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: favorColors.Yellow,
    textColor: favorColors.PrimaryBlue,
  );
}
