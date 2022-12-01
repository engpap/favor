import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    surname: '',
    email: '',
    password: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setGoogleUser(GoogleSignInAccount user) {
    _user = User(
        id: user.id,
        name: user.displayName,
        surname: '', // TODO: split name
        email: user.email,
        token: '' //TODO: insert google tokn
        );
    notifyListeners();
  }

  void clearUser() {
    _user =
        User(id: '', name: '', surname: '', email: '', password: '', token: '');
  }
}
