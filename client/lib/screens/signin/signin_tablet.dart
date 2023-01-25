import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customHeadingDesc.dart';
import 'package:project/screens/signin/signin.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

class SignInScreen_T extends StatelessWidget {
  const SignInScreen_T({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// TITLE
              Container(
                width: Responsive.width(100, context),
                margin: EdgeInsets.only(right: 9, left: 9,),
                child: Center(
                  child: Text(
                    "Welcome to Favor",
                    style: TextStyle(
                        color: favorColors.PrimaryBlue,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
        
              /// TWO BLOCKS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 1st BLOCK
                  SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      width: Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
                      child: Column(children: [
                        // heading + DESCRIPTION
                          customHeadingDesc(
                            heading: "", 
                            description: "Please enter your registration email and password."
                          ),
                        // FORM
                        Form_SignIn(),
                        // BUTTON
                        Divider(
                          height: Responsive.height(2, context),
                          color: Colors.transparent,
                        ),
                        SignIn_loginButton(),
                      ]),
                    ),
                  ),
                  // 2nd BLOCK
                  SingleChildScrollView(
                    reverse: true,
                    child: Container(
                      width: Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // BUTTON - google
                          SignIn_googleButton(),
                          Divider(
                            height: Responsive.height(4, context),
                            color: Colors.transparent,
                          ),
                          // BUTTON - signin
                          Center(
                            child: Text(
                              "Not a member yet?",
                              style: TextStyle(color: favorColors.PrimaryBlue, fontSize: 20),
                            ),
                          ),
                          SignIn_signUpButton(),
                        ]
                      ),
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
