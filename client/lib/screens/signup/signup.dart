import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/errors/error.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/login.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/screens/signup/signup_mobile.dart';
import 'package:project/screens/signup/signup_tablet.dart';
import 'package:project/screens/components/customField.dart';

import 'globals.dart' as globals;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

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
          )
        ),
        child: CupertinoPageScaffold(
          backgroundColor: Colors.transparent,
          child: SafeArea(
            child: ResponsiveLeayout(
              mobileBody: SignUpScreen_M(),
              tabletBody: SignUpScreen_T(),
            ),
          )
        )
      )
    );
  }
}


/// COLUMN of 5 customField: 
/// Name, Surname, Email, Password, PasswordConfirm
class SignUp_form extends StatelessWidget {
  const SignUp_form({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /// NAME
          CustomField(
            prefixIcon: CupertinoIcons.profile_circled,
            placeholder: globals.PlaceholderName,
            textController: globals.textControllerName,
            status: globals.StatusName,
          ),
          Divider(
            height: 5,
          ),

          /// SURNAME
          CustomField(
            prefixIcon: CupertinoIcons.profile_circled,
            placeholder: globals.PlaceholderSurname,
            textController: globals.textControllerSurname,
            status: globals.StatusSurname,
          ),
          Divider(
            height: 5,
          ),

          /// EMAIL
          CustomField(
            prefixIcon: CupertinoIcons.mail_solid,
            placeholder: globals.PlaceholderEmail,
            textController: globals.textControllerEmail,
            status: globals.StatusEmail,
            textInputType: TextInputType.emailAddress,
          ),
          Divider(
            height: 5,
          ),

          /// PASSWORD
          CustomField(
            prefixIcon: CupertinoIcons.lock_circle_fill,
            placeholder: globals.PlaceholderPassword,
            textController: globals.textControllerPassword,
            status: globals.StatusPassword,
            obcureText: true,
          ),
          Divider(
            height: 5,
          ),

          /// PASSWORD CONFIRM
          CustomField(
            prefixIcon: CupertinoIcons.lock_circle_fill,
            placeholder: globals.PlaceholderPasswordConfirm,
            textController: globals.textControllerPasswordConfirm,
            status: globals.StatusPasswordConfirm,
            obcureText: true,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}


/// BUTTON register. 
/// checks information validity both client and server sides. 
/// if all good push HomeScreen()
class SignUp_registerButton extends StatelessWidget {
  const SignUp_registerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            print('run: authService.signup');
            // Send information to server and wait for response
            Future<ErrorMessage> signupResponse =
              globals.authService.signup(
                name: globals.textControllerName.text,
                surname: globals.textControllerSurname.text,
                email: globals.textControllerEmail.text,
                password: globals.textControllerPassword.text,
                confirmPassword: globals.textControllerPasswordConfirm.text,
            );
            // when you recive server response run:
            signupResponse.then((value) {
              // Update fields status in base of client check and the server response output 
              globals.UpdateFieldsStatus(value);
              // if fields are valid go to login screen, else stay in this page
              if (globals.IsFieldsValid()) {
                print('IsFieldsValid = TRUE: push HomeScreen()');
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const HomeScreen()),
                );
              } else {
                print('IsFieldsValid = FALSE!');
              }
            });
          },
        ),
      ),
    );
  }
}


/// BUTTON login.
/// push LoginScreen()
class SignUp_loginButton extends StatelessWidget {
  const SignUp_loginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}



/*
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
*/