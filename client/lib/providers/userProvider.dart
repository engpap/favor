import 'package:flutter/cupertino.dart';
import 'package:project/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    password: '',
    token: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void clearUser() {
    _user = User(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        token: '');
  }
}
