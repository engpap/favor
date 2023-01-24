import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customHeadingDesc.dart';
import 'package:project/screens/signup/signup.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// TWO BLOCKS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1st BLOCK
                    SingleChildScrollView(
                      reverse: true,
                      child: Container(
                        width: Responsive.fixedWidth(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // HEADING + DESCRIPTION
                            customHeadingDesc(
                              heading: "Create Account", 
                              description: "Please fill all informations on the right."
                            ),
                            // BUTTON
                            SignUp_registerButton(),
                            Divider(
                            height: Responsive.height(6, context),
                            color: Colors.transparent,
                            ),
                            // BUTTON
                            Center(
                              child: Text(
                                "Have an account?",
                                style: TextStyle(color: favorColors.PrimaryBlue, fontSize: 20),
                              ),
                            ),
                            SignUp_loginButton(),
                          ]),
                      ),
                    ),
                    // 2nd BLOCK
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
      ),
    );
  }
}