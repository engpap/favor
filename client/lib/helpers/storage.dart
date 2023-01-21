import 'package:shared_preferences/shared_preferences.dart';

/// This class is a wrapper around the shared preferences library. It makes
/// easier to use the shared preferences library and its functions, without
/// having to write boilerplate code everytime.
class Storage {
  static String TOKEN_NOT_FOUND = 'token_not_found';

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
      return TOKEN_NOT_FOUND;
  }

  /// Return true if the token is not null, which means that the user has
  /// already signed up/in before.
  static Future<bool> isThereUserToken() async {
    //TODO: to test
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token') != null;
  }

  static Future setUserToken(String token) async {
    print(">>> Storing token in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
  }

  static Future invalidateToken() async {
    print(">>> Invalidating token in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', TOKEN_NOT_FOUND);
  }

  static Future<String?> getUserId() async {
    print(">>> Returning userId stored in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('id');
  }

  static Future setUserId(String userId) async {
    print(">>> Storing userId in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('userId', userId);
  }

  static Future removeUserId() async {
    print(">>> Removing userId in storage");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.remove('userId');
  }
}
