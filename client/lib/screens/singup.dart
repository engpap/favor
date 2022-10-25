import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/services/authService.dart';
import 'package:project/errors/error.dart';

import 'home.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final String _PlaceholderName = "Name";
  final String _PlaceholderSurname = "Surname";
  final String _PlaceholderEmail = "Email address";
  final String _PlaceholderPassword = "Password";
  final String _PlaceholderPasswordConfirm = "Confirm your password";

  final TextEditingController _textControllerName =
      TextEditingController(text: "");
  final TextEditingController _textControllerSurname =
      TextEditingController(text: "");
  final TextEditingController _textControllerEmail =
      TextEditingController(text: "");
  final TextEditingController _textControllerPassword =
      TextEditingController(text: "");
  final TextEditingController _textControllerPasswordConfirm =
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
            //Color.fromARGB(100, 0, 0, 0),
            //BlendMode.darken,
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
                          "Create Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      /// NAME
                      Container(
                          margin: EdgeInsets.only(left: 9, right: 9),
                          child: CupertinoTextField(
                            textInputAction: TextInputAction.next,
                            //keyboardType: TextInputType.emailAddress,
                            padding: EdgeInsets.only(top: 9, bottom: 9),
                            decoration: BoxDecoration(
                              color: (_textControllerName.text == "error")
                                  ? Colors.red
                                  : Colors.white,
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
                                CupertinoIcons.profile_circled,
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
                              onPressed: () => _textControllerName.clear(),
                            ),
                            //obscureText: false,
                            //obscuringCharacter: "*",
                            maxLength: _textMaxLength,
                            maxLines: _textMaxLines,
                            placeholder: _PlaceholderName,
                            controller: _textControllerName,
                            //onChanged: (_nameValue) => setState(() => this._nameValue = _nameValue),
                            onSubmitted: (value) => print(
                                'Submitted [_textControllerName.text]: $value'),
                          )),

                      // TODO: completare con gli errori corretti. Creare style dell'errore
                      if (_textControllerName.text == "error")
                        Text(
                          "Messaggio d'errore",
                          style: TextStyle(color: Colors.white),
                        ),

                      Divider(),

                      /// SURNAME
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
                                CupertinoIcons.profile_circled,
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
                              onPressed: () => _textControllerSurname.clear(),
                            ),
                            maxLength: _textMaxLength,
                            maxLines: _textMaxLines,
                            placeholder: _PlaceholderSurname,
                            controller: _textControllerSurname,
                            onSubmitted: (value) => print(
                                'Submitted [_textControllerSurname.text]: $value'),
                          )),

                      /// space
                      Divider(),

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

                      /// space
                      Divider(),

                      /// PASSWORD CONFIRM
                      Container(
                          margin: EdgeInsets.only(left: 9, right: 9),
                          child: CupertinoTextField(
                            textInputAction: TextInputAction.done,
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
                              onPressed: () =>
                                  _textControllerPasswordConfirm.clear(),
                            ),
                            obscureText: true,
                            maxLength: _textMaxLength,
                            maxLines: _textMaxLines,
                            placeholder: _PlaceholderPasswordConfirm,
                            controller: _textControllerPasswordConfirm,
                            onSubmitted: (value) => print(
                                'Submitted [_textControllerPasswordConfirm.text]: $value'),
                          )),

                      Divider(height: Responsive.height(5, context)),

                      // Register button
                      // now: print "Submitted Register button" and push HomeScreen
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
                              "Register",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              // Console log
                              print('Pressed: Register button');

                              // check valide fields

                              // send information to server

                              Future<ErrorMessage> signupResponse =
                                  _authService.signup(
                                firstName: _textControllerName.text,
                                lastName: _textControllerSurname.text,
                                email: _textControllerEmail.text,
                                password: _textControllerPassword.text,
                                confirmPassword:
                                    _textControllerPasswordConfirm.text,
                              );

                              //print(signupResponse.type);

                              /* funzione per controllare i diversi tipi di errore ricevuti.
                            checkResponse(signupResponse){
                              if (signupResponse.type == "pippo"){
                              }
                            };    
                            */

                              print('run: _authService.signup');
                              // push homepage
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
                        height: 50,
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
                            child: const Text("Log in"),
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
