import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customHeadingDesc.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

class SignInScreen_M extends StatelessWidget {
  const SignInScreen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
        child: SingleChildScrollView(
          reverse: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
            ),
            child: Column(children: [
              // HEADING +  DESCRIPTION
                customHeadingDesc(
                  heading: "Welcome to Favor", 
                  description: "Please enter your registration email and password."
                ),
              // FORM
              Form_SignIn(),
              // BUTTON - continue
              Divider(
                height: Responsive.height(2, context),
                color: Colors.transparent,
              ),
              SignIn_loginButton(),
              // OR BUTTON - google
              Text(
                "or",
                style: TextStyle(color: favorColors.PrimaryBlue, fontSize: 16),
              ),
              SignIn_googleButton(),
              // OR BUTTON - register
              Divider(
                height: Responsive.height(7, context),
                color: Colors.transparent,
              ),
              Text(
                "Not a member yet?",
                style: TextStyle(color: favorColors.PrimaryBlue, fontSize: 16),
              ),
              // BUTTON
              SignIn_signUpButton(),
            ]),
          ),
        ),
      ),
    );
  }
}
