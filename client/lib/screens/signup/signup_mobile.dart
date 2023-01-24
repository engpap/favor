import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/signup/signup.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/signup2/signup2.dart';

class SignUpScreen_M extends StatelessWidget {
  const SignUpScreen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
        child: SingleChildScrollView(
          reverse: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.fixedWidth(),
            ),
            child: Column(
              children: [
                // HEADING +  DESCRIPTION
                customHeadingDesc(
                  heading: "Create Account", 
                  description: "Please fill all informations below."
                ),
                // FORM
                Form_SignUp(),
                Divider(height: Responsive.height(2, context), color: Colors.transparent,),
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
