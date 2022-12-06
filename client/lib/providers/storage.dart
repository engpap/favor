import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static String _PlatformNotSupported = 'platform not supported';

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
}
