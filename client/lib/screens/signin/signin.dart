import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/errors/errorConstants.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customField.dart';
import 'package:project/screens/home.dart';
import 'package:project/errors/error.dart';

import 'package:project/screens/signin/signin_mobile.dart';
import 'package:project/screens/signin/signin_tablet.dart';

import 'package:project/screens/responsiveLayout.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/signup/signup.dart';
import 'globals.dart' as globals;

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                  mobileBody: SignInScreen_M(),
                  tabletBody: SignInScreen_T(),
                ),
              )),
        ));
  }
}

/// COLUMN of 2 customField:
/// Email, Password
class SignIn_form extends StatelessWidget {
  const SignIn_form({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}

/// SIGNIN BUTTON
class SignIn_loginButton extends StatelessWidget {
  const SignIn_loginButton({super.key});

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
            "Continue",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            print('Pressed: SignIn_signUpButton');
            globals.authService.signin(
                context: context,
                email: globals.textControllerEmail.text,
                password: globals.textControllerPassword.text);
            // when you recive server response run:
            //TODO: check conditions in signinResponse
            /*signinResponse.then((value) {
              if (value.type == ErrorConstants.NO_ERROR) {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (context) => const HomeScreen()),
                );
              } else {
                print('IsFieldsValid = FALSE!');
              }
            );*/
          },
        ),
      ),
    );
  }
}

/// BUTTON google login
class SignIn_googleButton extends StatelessWidget {
  const SignIn_googleButton({super.key});

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
          //color: Colors.deepOrangeAccent,
          padding: EdgeInsets.zero,
          child: Image(
            image: AssetImage(
                "assets/images/google/btn_google_signin_light_normal_web@2x.png"),
          ),
          onPressed: () {
            // Console log
            print('Pressed: SignIn_googleButton');
            globals.authService.googleSignIn(context: context);
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
    );
  }
}

/// SIGNUP BUTTON - aka REGISTER
class SignIn_signUpButton extends StatelessWidget {
  const SignIn_signUpButton({super.key});

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
          child: const Text(
            "Register",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            print('Pressed: SignIn_signUpButton');
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
        ),
      ),
    );
  }
}
