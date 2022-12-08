library globals;

import 'package:flutter/cupertino.dart';
import 'package:project/errors/errorConstants.dart';
import 'package:project/services/authService.dart';

// SIGN IN VARIABLES

final String PlaceholderEmail = "Email address";
final String PlaceholderPassword = "Password";


final TextEditingController textControllerEmail =
    TextEditingController(text: "");
final TextEditingController textControllerPassword =
    TextEditingController(text: "");



String StatusEmail = ErrorConstants.UNCHECKED_ERROR;
String StatusPassword = ErrorConstants.UNCHECKED_ERROR;


final AuthService authService = AuthService();