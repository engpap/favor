import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/signin/signin.dart';

class SignInScreen_T extends StatelessWidget {
  const SignInScreen_T({super.key});

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
              margin: EdgeInsets.only(
                  right: 9, left: 9, bottom: Responsive.height(5, context)),
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

            /// TWO BLOCKS: actual signIn & register or google
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// BLOCK: actual signIn
                SingleChildScrollView(
                  reverse: true,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      //TODO: use a global variable, not 370
                      maxWidth: 370,
                    ),
                    child: Column(children: [
                      /// DESCRIPTION
                      Container(
                        margin: EdgeInsets.only(
                            top: Responsive.height(1, context),
                            bottom: Responsive.height(3, context),
                            right: 9,
                            left: 9),
                        child: Text(
                          "Please enter your registration email and password.",
                          style: TextStyle(
                              color: favorColors.PrimaryBlue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SignIn_form(),

                      Divider(
                        height: Responsive.height(2, context),
                        color: Colors.transparent,
                      ),

                      SignIn_loginButton(),
                    ]),
                  ),
                ),

                /// BLOCK: register or google
                SingleChildScrollView(
                  reverse: true,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      //TODO: use a global variable, not 370
                      maxWidth: 370,
                    ),
                    child: Column(children: [
                      SignIn_googleButton(),
                      Divider(
                        height: Responsive.height(4, context),
                        color: Colors.transparent,
                      ),
                      Text(
                        "Not a member yet?",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Divider(
                        height: Responsive.height(1, context),
                        color: Colors.transparent,
                      ),
                      SignIn_signUpButton(),
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
