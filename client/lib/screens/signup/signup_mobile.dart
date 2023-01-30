import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customHeadingDesc.dart';
import 'package:project/screens/signup/signup.dart';
import 'package:project/functions/favorColors.dart' as favorColors;


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
              maxWidth: MediaQuery.of(context).size.width-20//Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
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
                  style: TextStyle(color: favorColors.PrimaryBlue, fontSize: 16),
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
