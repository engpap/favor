import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/signup/signup.dart';

class SignUpScreen_T extends StatefulWidget {
  const SignUpScreen_T({super.key});

  @override
  State<SignUpScreen_T> createState() => _SignUpScreen_TState();
}

class _SignUpScreen_TState extends State<SignUpScreen_T> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// TITLE
            Container(
              width: Responsive.width(100, context),           
              margin: EdgeInsets.only(right: 9, left: 9, bottom: Responsive.height(5,context)),  
              child: Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    color: favorColors.PrimaryBlue,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
                ),
              ),
            ),
            /// TWO BLOCKS: register & signUpForm
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// BLOCK: register
                  SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      width: Responsive.fixedWidth(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        /// DESCRIPTION
                        Container(
                          margin: EdgeInsets.only(
                            top: Responsive.height(1, context),
                            bottom: Responsive.height(3, context),
                            right: 9,
                            left: 9),
                          child: Text(
                            "Please fill all informations on the right.",
                            style: TextStyle(
                              color: favorColors.PrimaryBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                          SignUp_registerButton(),
                          //Expanded(child: Container()),
                          Divider(height: Responsive.height(10, context), color: Colors.transparent,),
                          Text(
                            "Have an account?",
                            style: TextStyle(
                              color: Colors.black, 
                              fontSize: 20),
                          ),
                          SignUp_loginButton(),
                        ]),
                    ),
                  ),

                  /// BLOCK: register
                  SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      width: Responsive.fixedWidth(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          Form_SignUp(),
                        ]),
                    ),
                  ),
                  

                ],
              ),
            ],
          ),

      ),
    );
  }
}