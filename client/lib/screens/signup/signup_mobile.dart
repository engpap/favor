import 'package:flutter/material.dart';
import 'package:project/screens/signup/signup.dart';
import 'package:project/functions/responsive.dart';

class SignUpScreen_M extends StatefulWidget {
  const SignUpScreen_M({super.key});

  @override
  State<SignUpScreen_M> createState() => _SignUpScreen_MState();
}

class _SignUpScreen_MState extends State<SignUpScreen_M> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
        const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              //TODO: use a global variable, not 370 
              maxWidth: 370,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// PAGE TITLE
                Container(
                  margin: EdgeInsets.only(
                    top: Responsive.height(2, context),
                    bottom: Responsive.height(5, context),
                    right: 9,
                    left: 9),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                  ),
                ),

                SignUp_form(),
                Divider(height: Responsive.height(5, context),),
                SignUp_registerButton(),
                Divider(height: 50,),
                Text(
                  "Have an account?",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 16),
                ),
                SignUp_loginButton(),
              ]),
          ),
        ),
      ),
    );
  }
}
