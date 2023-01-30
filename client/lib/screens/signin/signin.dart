import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/stringExtensions.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/customFieldMat.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/signin/signin_mobile.dart';
import 'package:project/screens/signin/signin_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/screens/signup/signup.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:provider/provider.dart';
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
            //BACKGROUND GRADIENT IMAGE
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
            //PAGE
            child: CupertinoPageScaffold(
                // .withAlpha(180) is used to add transparency, in order to see the bg-image
                backgroundColor: favorColors.IntroBg.withAlpha(180),
                child: SafeArea(
                  child: ResponsiveLeayout(
                    mobileBody: SignInScreen_M(),
                    tabletBody: SignInScreen_T(),
                  ),
                ))));
  }
}

/// SIGNIN FORM
class Form_SignIn extends StatefulWidget {
  const Form_SignIn({super.key});

  @override
  State<Form_SignIn> createState() => _Form_SignInState();
}

class _Form_SignInState extends State<Form_SignIn> {
  final formKey_signin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key("form_sign_in_container"),
      child: Material(
          color: Colors.transparent,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey_signin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// EMAIL
                CustomCard(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: CustomFieldMat(
                    prefixIcon: CupertinoIcons.mail_solid,
                    labelText: globals.LabelEmail,
                    textEditingController: globals.textControllerEmail,
                    textInputType: TextInputType.emailAddress,
                    customValidator: (value) {
                      if (value!.length < 1 || !value.isValidEmail()) {
                        return LabelSpace().whiteSpace() +
                            "This mail is not valid";
                      }
                      if (value.length > 50) {
                        return LabelSpace().whiteSpace() + "This is too long";
                      } else {
                        return null;
                      }
                    },
                    isSuffixClear: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                /// PASSWORD
                CustomCard(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: CustomFieldMat(
                    prefixIcon: CupertinoIcons.lock_circle_fill,
                    labelText: globals.LabelPassword,
                    textEditingController: globals.textControllerPassword,
                    obcureText: true,
                    customValidator: (value) {
                      if (value!.length < 1 || !value.isValidPassword()) {
                        return LabelSpace().whiteSpace() +
                            "This password is not valid.";
                      }
                      if (value.length > 50) {
                        return LabelSpace().whiteSpace() + "max 50 chars";
                      } else {
                        return null;
                      }
                    },
                    isSuffixClear: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}

/// SIGNIN BUTTON
class SignIn_loginButton extends StatelessWidget {
  const SignIn_loginButton({key: const Key('SignIn_loginButton')});

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
            Provider.of<AppProvider>(context, listen: false).signin(
                context: context,
                email: globals.textControllerEmail.text,
                password: globals.textControllerPassword.text);
          },
        ),
      ),
    );
  }
}

/// BUTTON - google
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
          padding: EdgeInsets.zero,
          child: Image(
            image: AssetImage(
                "assets/images/google/btn_google_signin_light_normal_web@2x.png"),
          ),
          onPressed: () {
            // Console log
            print('Pressed: SignIn_googleButton');
           Provider.of<AppProvider>(context, listen: false).googleSignIn(context: context);
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
