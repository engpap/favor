import 'dart:io' show Platform;
import 'package:project/constants/constants.dart';

class AuthHelper {
  String clientID() {
    if (Platform.isAndroid) {
      return GOOGLE_CLIENT_ID_WEB;
    } else if (Platform.isIOS) {
      return GOOGLE_CLIENT_ID_IOS;
    }
    return '';
  }

  String redirectUrl() {
    if (Platform.isAndroid) {
      return GOOGLE_REDIRECT_URI_ANDROID;
    } else if (Platform.isIOS) {
      return GOOGLE_REDIRECT_URI_IOS;
    }
    return '';
  }
}
