import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/errors/error.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/screens/components/customField.dart';

import 'package:project/screens/signin/signin.dart';
import 'package:project/screens/signup/signup_mobile.dart';
import 'package:project/screens/signup/signup_tablet.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'globals.dart' as globals;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(

            //BCKGROUND GRADIENT IMAGE
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/bg_blue_gradient.jpg"),
              fit: BoxFit.cover,
              opacity: 1,
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.softLight,
              ),
            )),
            child: CupertinoPageScaffold(
                // .withAlpha(180) is used to add transparency, in order to see the bg-image
                backgroundColor: favorColors.IntroBg.withAlpha(180),
                child: SafeArea(
                  child: ResponsiveLeayout(
                    mobileBody: SignUpScreen_M(),
                    tabletBody: SignUpScreen_T(),
                  ),
                ))));
  }
}

/// COLUMN of 5 customField:
/// Name, Surname, Email, Password, PasswordConfirm
class SignUp_form extends StatelessWidget {
  const SignUp_form({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /// NAME
          CustomField(
            prefixIcon: CupertinoIcons.profile_circled,
            placeholder: globals.PlaceholderName,
            textController: globals.textControllerName,
            status: globals.StatusName,
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),

          /// SURNAME
          CustomField(
            prefixIcon: CupertinoIcons.profile_circled,
            placeholder: globals.PlaceholderSurname,
            textController: globals.textControllerSurname,
            status: globals.StatusSurname,
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),

          /// EMAIL
          CustomField(
            prefixIcon: CupertinoIcons.mail_solid,
            placeholder: globals.PlaceholderEmail,
            textController: globals.textControllerEmail,
            status: globals.StatusEmail,
            textInputType: TextInputType.emailAddress,
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),

          /// PASSWORD
          CustomField(
            prefixIcon: CupertinoIcons.lock_circle_fill,
            placeholder: globals.PlaceholderPassword,
            textController: globals.textControllerPassword,
            status: globals.StatusPassword,
            obcureText: true,
          ),
          Divider(
            height: 5,
            color: Colors.transparent,
          ),

          /// PASSWORD CONFIRM
          CustomField(
            prefixIcon: CupertinoIcons.lock_circle_fill,
            placeholder: globals.PlaceholderPasswordConfirm,
            textController: globals.textControllerPasswordConfirm,
            status: globals.StatusPasswordConfirm,
            obcureText: true,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}

/// BUTTON register.
/// checks information validity both client and server sides.
/// if all good push HomeScreen()
class SignUp_registerButton extends StatelessWidget {
  const SignUp_registerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 9, right: 9, left: 9, bottom: 9),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: SizedBox(
        width: Responsive.width(65, context),
        child: CupertinoButton(
          color: favorColors.PrimaryBlue,
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            // Console log
            print('Pressed: SignUp_registerButton');
            print('run: authService.signup');
            // Send information to server and wait for response
            Future<ErrorMessage> signupResponse = globals.authService.signup(
              name: globals.textControllerName.text,
              surname: globals.textControllerSurname.text,
              email: globals.textControllerEmail.text,
              password: globals.textControllerPassword.text,
              confirmPassword: globals.textControllerPasswordConfirm.text,
            );
            // when you recive server response run:
            signupResponse.then((value) {
              // Update fields status in base of client check and the server response output
              globals.UpdateFieldsStatus(value);
              // if fields are valid go to signin screen, else stay in this page
              if (globals.IsFieldsValid()) {
                print('IsFieldsValid = TRUE: push SingInScreen()');
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const SignInScreen()),
                );
              } else {
                print('IsFieldsValid = FALSE!');
              }
            });
          },
        ),
      ),
    );
  }
}

/// SIGNIN BUTTON
class SignUp_loginButton extends StatelessWidget {
  const SignUp_loginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 9, right: 9, left: 9, bottom: 9),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: SizedBox(
        width: Responsive.width(65, context),
        child: CupertinoButton(
          color: favorColors.SecondaryBlue,
          child: const Text("Sign In",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          onPressed: () {
            print('Pressed: SignUp_loginButton');
            Navigator.pop(
              context,
              CupertinoPageRoute(builder: (context) => const SignInScreen()),
            );
          },
        ),
      ),
    );
  }
}