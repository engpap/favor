import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  //static String _PlatformNotSupported = 'platform not supported';

  /*
  static Future<String?> getUserToken() async {
    if (Platform.isAndroid) {
      print(">>> Returning token stored in storage");
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      return _prefs.getString('token');
    } else if (Platform.isIOS) {
      return _PlatformNotSupported;
    } else {
      return _PlatformNotSupported;
    }
  }
  */
  static Future<String?> getUserToken() async {
    print(">>> Returning token stored in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  static void setUserToken(String token) async {
    print(">>> Storing token in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('token', token);
  }

  static void removeToken() async {
    print(">>> Removing token in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('token');
  }

  static Future<String?> getUserId() async {
    print(">>> Returning userId stored in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('id');
  }

  static void setUserId(String userId) async {
    print(">>> Storing userId in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('userId', userId);
  }

  static void removeUserId() async {
    print(">>> Removing userId in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('userId');
  }
}
