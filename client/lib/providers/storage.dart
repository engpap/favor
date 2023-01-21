import 'package:shared_preferences/shared_preferences.dart';

/// This class is a wrapper around the shared preferences library. It makes
/// easier to use the shared preferences library and its functions, without
/// having to write boilerplate code everytime.
class Storage {
  /// Return the user's token saved in the shared preferences.
  /// If the token does not exist in the shared preferences (it's null),
  /// then return an invalid token string. In this last case, no exception
  /// are thrown in order to wait for a server response that will cause the
  /// application open the sign in screen.
  static Future<String> getUserToken() async {
    print(">>> Returning token stored in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('token') != null)
      return _prefs.getString('token') as String;
    else
      return 'token_not_found';
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
