library globals;

import 'package:flutter/cupertino.dart';
import 'package:project/services/authService.dart';

// SIGN UP2 VARIABLES
final TextEditingController ageContoller = TextEditingController(text: "");
final TextEditingController genderContoller = TextEditingController(text: "");
final TextEditingController residenceContoller =
    TextEditingController(text: "");
final TextEditingController jobContoller = TextEditingController(text: "");
final TextEditingController bioContoller = TextEditingController(text: "");

final AuthService authService = AuthService();