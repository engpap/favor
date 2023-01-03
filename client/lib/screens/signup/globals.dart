library globals;

import 'package:flutter/cupertino.dart';
import 'package:project/errors/error.dart';
import 'package:project/errors/errorConstants.dart';
import 'package:project/functions/stringExtensions.dart';
import 'package:project/services/authService.dart';

// SIGN UP VARIABLES
final String PlaceholderName = "Name";
final String PlaceholderSurname = "Surname";
final String PlaceholderEmail = "Email address";
final String PlaceholderPassword = "Password";
final String PlaceholderPasswordConfirm = "Confirm your password";

final TextEditingController textControllerName =
    TextEditingController(text: "");
final TextEditingController textControllerSurname =
    TextEditingController(text: "");
final TextEditingController textControllerEmail =
    TextEditingController(text: "");
final TextEditingController textControllerPassword =
    TextEditingController(text: "");
final TextEditingController textControllerPasswordConfirm =
    TextEditingController(text: "");

String StatusName = ErrorConstants.UNCHECKED_ERROR;
String StatusSurname = ErrorConstants.UNCHECKED_ERROR;
String StatusEmail = ErrorConstants.UNCHECKED_ERROR;
String StatusPassword = ErrorConstants.UNCHECKED_ERROR;
String StatusPasswordConfirm = ErrorConstants.UNCHECKED_ERROR;

final AuthService authService = AuthService();

// Update the status of the textsfields
UpdateFieldsStatus(ErrorMessage? response) {
  // check client side
  (textControllerName.toString().isWhitespace())
      ? StatusName = ErrorConstants.NAME_ERROR
      : StatusName = ErrorConstants.NO_ERROR;
  (textControllerSurname.toString().isWhitespace())
      ? StatusSurname = ErrorConstants.SURNAME_ERROR
      : StatusSurname = ErrorConstants.NO_ERROR;
  (textControllerEmail.toString().isValidEmail())
      ? StatusEmail = ErrorConstants.NO_ERROR
      : StatusEmail = ErrorConstants.EMAIL_ERROR;
  (textControllerPassword.toString().isValidPassword())
      ? StatusPassword = ErrorConstants.PASSWORD_ERROR
      : {};
  (textControllerPasswordConfirm.toString().isValidPassword())
      ? StatusPasswordConfirm = ErrorConstants.PASSWORD_ERROR
      : {};
  (textControllerPassword.text == textControllerPasswordConfirm.text)
      ? {
          StatusPasswordConfirm = ErrorConstants.NO_ERROR,
          StatusPassword = ErrorConstants.NO_ERROR
        }
      : {
          StatusPasswordConfirm = ErrorConstants.PASSWORD_ERROR,
          StatusPassword = ErrorConstants.PASSWORD_ERROR
        };

  //check server side
  if (response!.type.toString() == ErrorConstants.EMAIL_ERROR)
    StatusEmail = ErrorConstants.EMAIL_ERROR;
  else if (response.type.toString() == ErrorConstants.PASSWORD_ERROR) {
    StatusPassword = ErrorConstants.PASSWORD_ERROR;
    StatusPasswordConfirm = ErrorConstants.PASSWORD_ERROR;
  } else if (response.type.toString() == ErrorConstants.SERVER_ERROR) {
    //TODO far comparire un pop up
  }

  print(
      "response.message: ${response.message}\nresponse.type: ${response.type}");
  print(
      "StatusName: ${StatusName}\nStatusSurname: ${StatusSurname}\nStatusEmail: ${StatusEmail}\nStatusPassword: ${StatusPassword}\nStatusPasswordConfirm ${StatusPasswordConfirm}");
}

// return TRUE only if all StatusFields are set to valid
bool IsFieldsValid() {
  if (StatusName == ErrorConstants.NO_ERROR &&
      StatusSurname == ErrorConstants.NO_ERROR &&
      StatusEmail == ErrorConstants.NO_ERROR &&
      StatusPassword == ErrorConstants.NO_ERROR &&
      StatusPasswordConfirm == ErrorConstants.NO_ERROR)
    return true;
  else
    return false;
}
