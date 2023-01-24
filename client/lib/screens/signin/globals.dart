library globals;

import 'package:flutter/cupertino.dart';
import 'package:project/services/authService.dart';

/// SIGN IN VARIABLES
/// EMAIL
final String LabelEmail = "Email address";
final TextEditingController textControllerEmail = TextEditingController(text: "");
/// PASSWORD
final String LabelPassword = "Password";
final TextEditingController textControllerPassword = TextEditingController(text: "");
/// AUTHENTICATOR
final AuthService authService = AuthService();