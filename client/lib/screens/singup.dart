import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/services/authService.dart';
import 'package:project/errors/error.dart';
import 'package:project/screens/components/customField.dart';

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

  String _StatusName = "undefined";
  String _StatusSurname = "undefined";
  String _StatusEmail = "undefined";
  String _StatusPassword = "undefined";
  String _StatusPasswordConfirm = "undefined";

  final AuthService _authService = AuthService();

  //TODO spostare tutte queste funzioni fuori dal widget e generalizzarle

  // Update the status of the textsfields
  UpdateFieldsStatus(ErrorMessage response) {
    // check client side
    // TODO : riscrivere meglio questi controlli, con tutti i casi necessari
    (_textControllerName == "") ? _StatusName = "error" : _StatusName = "valid";
    (_textControllerSurname == "")
        ? _StatusSurname = "error"
        : _StatusSurname = "valid";
    //cambiare assulutamente questo controllo
    (_textControllerEmail == "")
        ? _StatusEmail = "error"
        : _StatusEmail = "valid";
    (_textControllerPassword == "")
        ? _StatusPassword = "error"
        : _StatusPassword = "undefined";
    (_textControllerPasswordConfirm == "")
        ? _StatusPasswordConfirm = "error"
        : _StatusPasswordConfirm = "undefined";
    (_textControllerPassword.text == _textControllerPasswordConfirm.text)
        ? {_StatusPasswordConfirm = "valid", _StatusPassword = "valid"}
        : {_StatusPasswordConfirm = "error", _StatusPassword = "error"};

    //check server side
    switch (response.type) {
      case "email":
        {
          _StatusEmail = "error";
        }
        break;
      case "password":
        {
          _StatusPassword = "error";
          _StatusPasswordConfirm = "error";
        }
        break;
    }
    print(
        "response.message: ${response.message}\nresponse.type: ${response.type}");
    print(
        "_StatusName: $_StatusName\n_StatusSurname: $_StatusSurname\n_StatusEmail: $_StatusEmail\n_StatusPassword: $_StatusPassword\n_StatusPasswordConfirm $_StatusPasswordConfirm");
  }

  // return TRUE only if all _StatusFields are set to valid
  bool IsFieldsValid() {
    if (_StatusName == "valid" &&
        _StatusSurname == "valid" &&
        _StatusEmail == "valid" &&
        _StatusPassword == "valid" &&
        _StatusPasswordConfirm == "valid")
      return true;
    else
      return false;
  }

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

                      /// NAME
                      CustomField(
                        prefixIcon: CupertinoIcons.profile_circled,
                        placeholder: _PlaceholderName,
                        textController: _textControllerName,
                        status: _StatusName,
                      ),
                      Divider(
                        height: 5,
                      ),

                      /// SURNAME
                      CustomField(
                        prefixIcon: CupertinoIcons.profile_circled,
                        placeholder: _PlaceholderSurname,
                        textController: _textControllerSurname,
                        status: _StatusSurname,
                      ),
                      Divider(
                        height: 5,
                      ),

                      /// EMAIL
                      CustomField(
                        prefixIcon: CupertinoIcons.mail_solid,
                        placeholder: _PlaceholderEmail,
                        textController: _textControllerEmail,
                        status: _StatusEmail,
                        textInputType: TextInputType.emailAddress,
                      ),
                      Divider(
                        height: 5,
                      ),

                      /// PASSWORD
                      CustomField(
                        prefixIcon: CupertinoIcons.lock_circle_fill,
                        placeholder: _PlaceholderPassword,
                        textController: _textControllerPassword,
                        status: _StatusPassword,
                        obcureText: true,
                      ),
                      Divider(
                        height: 5,
                      ),

                      /// PASSWORD CONFIRM
                      CustomField(
                        prefixIcon: CupertinoIcons.lock_circle_fill,
                        placeholder: _PlaceholderPasswordConfirm,
                        textController: _textControllerPasswordConfirm,
                        status: _StatusPasswordConfirm,
                        obcureText: true,
                        textInputAction: TextInputAction.done,
                      ),

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
                              print('run: _authService.signup');
                              // Send information to server and wait for response
                              Future<ErrorMessage> signupResponse =
                                  _authService.signup(
                                name: _textControllerName.text,
                                surname: _textControllerSurname.text,
                                email: _textControllerEmail.text,
                                password: _textControllerPassword.text,
                                confirmPassword:
                                    _textControllerPasswordConfirm.text,
                              );
                              // when you recive server response run:
                              signupResponse.then((value) {
                                // Update fields status in base of the server response output
                                UpdateFieldsStatus(value);
                                // if fields are valid go to login screen, else stay in this page
                                if (IsFieldsValid()) {
                                  print(
                                      'IsFieldsValid = TRUE: push HomeScreen()');
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                  );
                                } else {
                                  print('IsFieldsValid = FALSE!');
                                }
                              });
                            },
                          ),
                        ),
                      ),

                      // Continue with Google
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
                              "Continue with Google",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              // Console log
                              print('Pressed: Continue with Google button');
                              print('run: ...');
                              _authService.googleSignIn(context: context);
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
