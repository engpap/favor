import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/services/authService.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _textControllerFirstName =
      TextEditingController();
  final TextEditingController _textControllerLastName = TextEditingController();
  final TextEditingController _textControllerEmail = TextEditingController();
  final TextEditingController _textControllerPassword = TextEditingController();
  final TextEditingController _textControllerConfirmPassword =
      TextEditingController();

  final AuthService _authService = AuthService();

  // variabili temporanee per test
  Color? signupColor = Colors.red;
  // Color? signupColor = Colors.green;

  // TODO rivedere tutti i margin, e impostarli relativi

  void signup() {
    _authService.signup(
      firstName: _textControllerFirstName.text,
      lastName: _textControllerLastName.text,
      email: _textControllerEmail.text,
      password: _textControllerPassword.text,
      confirmPassword: _textControllerConfirmPassword.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      //backgroundColor: CupertinoColors.lightBackgroundGray,
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_music_02.jpg"),
                fit: BoxFit.cover,
                opacity: 1,
                colorFilter: const ColorFilter.mode(
                    Colors.deepOrangeAccent, BlendMode.modulate))),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(top: 90.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(top: 9, right: 9, left: 9, bottom: 29),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              // GO HOMESCREEN
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: CupertinoButton(
                  // TODO rivedere hover, colore, dimensione
                  color: Colors.deepOrangeAccent,
                  child: const Text("HomeScreen"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                ),
              ),

              // RED BOX
              Container(
                margin: const EdgeInsets.only(
                    top: 160.0, bottom: 20, left: 10, right: 320),
                color: signupColor,
                width: 48.0,
                height: 48.0,
              ),

              // TEXT FIELDS Name, Surname, Email, Password, PasswordConfirm
              Container(
                  margin: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CupertinoTextField(
                    controller: _textControllerFirstName,
                    placeholder: 'First name',
                  )),
              Container(
                  margin: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CupertinoTextField(
                    controller: _textControllerLastName,
                    placeholder: 'Second name',
                  )),
              Container(
                  margin: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CupertinoTextField(
                    controller: _textControllerEmail,
                    placeholder: 'Email address',
                  )),
              Container(
                  margin: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CupertinoTextField(
                    controller: _textControllerPassword,
                    placeholder: 'Password',
                  )),
              Container(
                  margin: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CupertinoTextField(
                    controller: _textControllerConfirmPassword,
                    placeholder: 'Confirm password',
                  )),

              // button push al server
              Container(
                margin: EdgeInsets.only(top: 29, right: 9, left: 9, bottom: 19),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: CupertinoButton(
                  // TODO rivedere hover, colore, dimensione
                  color: Colors.deepOrangeAccent,
                  child: const Text("Sign Up"),
                  onPressed: () {
                    signup();
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

/// TODO shadow class
/* 
class ShadowLogin extends BoxDecoration{
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
} 
*/
