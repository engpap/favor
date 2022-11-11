import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';

import 'login.dart';
import 'singup.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg_music_02.jpg"),
          fit: BoxFit.cover,
          opacity: 1,
          colorFilter: const ColorFilter.mode(
            Colors.deepOrangeAccent,
            BlendMode.modulate,
          ),
        )),
        child: CupertinoPageScaffold(
          backgroundColor: Colors.transparent,
          child: SafeArea(
            child: Container(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// PAGE TITLE
                      Container(
                        margin: EdgeInsets.only(
                            top: Responsive.height(10, context),
                            right: 9,
                            left: 9),
                        child: const Text(
                          "Welcome",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      /// SUBTITLE
                      Container(
                        margin: EdgeInsets.only(
                            bottom: Responsive.height(5, context),
                            right: 9,
                            left: 9),
                        child: const Text(
                          "Join our community!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Divider(
                        height: Responsive.height(22, context),
                      ),

                      // SignUp button
                      Container(
                        margin: EdgeInsets.only(
                            top: Responsive.height(5, context),
                            right: 9,
                            left: 9,
                            bottom: 9),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: Responsive.width(65, context),
                          child: CupertinoButton(
                            color: Colors.deepOrangeAccent,
                            child: const Text(
                              "Get started",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              print(
                                  'Pressed: SignUp button -> push SignUpScreen');
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                          ),
                        ),
                      ),

                      Divider(
                        height: Responsive.height(15, context),
                      ),
                      Text(
                        "Have an account?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Divider(),

                      // Login button
                      Container(
                        margin: EdgeInsets.only(
                            top: 9, right: 9, left: 9, bottom: 9),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: Responsive.width(50, context),
                          child: CupertinoButton(
                            padding: EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                            color: Colors.orangeAccent,
                            child: const Text("Log in",
                                style: TextStyle(fontSize: 18)),
                            onPressed: () {
                              print(
                                  'Pressed: Login button -> push LoginScreen');
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
