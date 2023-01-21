import 'dart:io' show Platform;
import 'package:project/constants/constants.dart';

class AuthHelper {
  String clientID() {
    if (Platform.isAndroid) {
      return GOOGLE_CLIENT_ID_WEB;
    } else if (Platform.isIOS) {
      return GOOGLE_CLIENT_ID_IOS;
    }
    throw Exception("This platform is not supported");
  }

  String AndroidClientId() {
    return GOOGLE_REDIRECT_URI_ANDROID;
  }

  String ClientSecret() {
    return GOOGLE_CLIENT_SECRET_WEB;
  }

  String redirectUrl() {
    if (Platform.isAndroid) {
      return GOOGLE_REDIRECT_URI_ANDROID;
    } else if (Platform.isIOS) {
      return GOOGLE_REDIRECT_URI_IOS;
    }
    throw Exception("This platform is not supported");
  }
}
