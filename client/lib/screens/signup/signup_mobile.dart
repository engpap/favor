import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/signup/signup.dart';

class SignUpScreen_M extends StatelessWidget {
  const SignUpScreen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              //TODO: use a global variable, not 370 
              maxWidth: 370,
            ),
            child: Column(
              children: [
                /// PAGE TITLE
                Container(
                  width: Responsive.width(100, context), 
                  margin: EdgeInsets.only(right: 9, left: 9),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      color: favorColors.PrimaryBlue,
                      fontSize: 37,
                      fontWeight: FontWeight.bold),
                  ),
                ),
                /// DESCRIPTION
                Container(
                  width: Responsive.width(100, context),
                  margin: EdgeInsets.only(
                    top: Responsive.height(1, context),
                    bottom: Responsive.height(3, context),
                    right: 9,
                    left: 9),
                  child: Text(
                    "Please fill all informations below.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: favorColors.PrimaryBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  ),
                ),

                SignUp_form(),
                Divider(height: Responsive.height(7, context), color: Colors.transparent,),
                SignUp_registerButton(),
                Divider(height: Responsive.height(2, context), color: Colors.transparent,),

                Text(
                  "Have an account?",
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 16),
                ),
                Divider(height: Responsive.height(1, context), color: Colors.transparent,),

                SignUp_loginButton(),
              ]),
          ),
        ),
      ),
    );
  }
}
