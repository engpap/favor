import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/services/authService.dart';

import 'home.dart';
import 'singup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String _PlaceholderEmail = "Email address";
  final String _PlaceholderPassword = "Password";

  final TextEditingController _textControllerEmail =
      TextEditingController(text: "");
  final TextEditingController _textControllerPassword =
      TextEditingController(text: "");

  final int _textMaxLength = 30;
  final int _textMaxLines = 1;

  final AuthService _authService = AuthService();

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
                            bottom: Responsive.height(5, context),
                            right: 9,
                            left: 9),
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Divider(
                        height: Responsive.height(5, context),
                      ),

                      /// EMAIL
                      Container(
                          margin: EdgeInsets.only(left: 9, right: 9),
                          child: CupertinoTextField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            padding: EdgeInsets.only(top: 9, bottom: 9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            cursorColor: Colors.amber,
                            cursorWidth: 3,
                            cursorRadius: Radius.circular(10),
                            // specific attributes
                            prefix: CupertinoButton(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 0),
                              child: Icon(
                                CupertinoIcons.mail_solid,
                                color: Colors.amber,
                              ),
                              onPressed: null,
                            ),
                            suffix: CupertinoButton(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 0),
                              child: Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: Colors.amber,
                              ),
                              onPressed: () => _textControllerEmail.clear(),
                            ),
                            maxLength: _textMaxLength,
                            maxLines: _textMaxLines,
                            placeholder: _PlaceholderEmail,
                            controller: _textControllerEmail,
                            onSubmitted: (value) => print(
                                'Submitted [_textControllerEmail.text]: $value'),
                          )),

                      /// space
                      Divider(),

                      /// PASSWORD
                      Container(
                          margin: EdgeInsets.only(left: 9, right: 9),
                          child: CupertinoTextField(
                            textInputAction: TextInputAction.next,
                            padding: EdgeInsets.only(top: 9, bottom: 9),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            cursorColor: Colors.amber,
                            cursorWidth: 3,
                            cursorRadius: Radius.circular(10),
                            // specific attributes
                            prefix: CupertinoButton(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 0),
                              child: Icon(
                                CupertinoIcons.lock_circle_fill,
                                color: Colors.amber,
                              ),
                              onPressed: null,
                            ),
                            suffix: CupertinoButton(
                              padding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 0),
                              child: Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: Colors.amber,
                              ),
                              onPressed: () => _textControllerPassword.clear(),
                            ),
                            obscureText: true,
                            maxLength: _textMaxLength,
                            maxLines: _textMaxLines,
                            placeholder: _PlaceholderPassword,
                            controller: _textControllerPassword,
                            onSubmitted: (value) => print(
                                'Submitted [_textControllerPassword.text]: $value'),
                          )),

                      Divider(
                        height: Responsive.height(5, context),
                      ),

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
                          width: Responsive.width(65, context),
                          child: CupertinoButton(
                            color: Colors.deepOrangeAccent,
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              print('Pressed: Login button -> push HomeScreen');
                              _authService.signin(
                                context: context,
                                email: _textControllerEmail.text,
                                password: _textControllerPassword.text,
                              );
                              //se no errori push
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const HomeScreen()),
                              );
                            },
                          ),
                        ),
                      ),

                      Divider(
                        height: Responsive.height(15, context),
                      ),
                      Text(
                        "Not a member?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Divider(),

                      // SignUpScreen button
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
                            child: const Text("Get started",
                                style: TextStyle(fontSize: 18)),
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
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
