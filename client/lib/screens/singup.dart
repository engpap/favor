import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _textController1 =
      TextEditingController(text: "name");
  final TextEditingController _textController2 =
      TextEditingController(text: "surname");
  final TextEditingController _textController3 =
      TextEditingController(text: "email");
  final TextEditingController _textController4 =
      TextEditingController(text: "password");
  final TextEditingController _textController5 =
      TextEditingController(text: "Confirm password");
  Color? signupColor = Colors.red[600];
  // Color? signupColor = Colors.green[600];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CupertinoButton(
              child: const Text("go homeScreen"),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            CupertinoTextField(
              controller: _textController1,
            ),
            CupertinoTextField(
              controller: _textController2,
            ),
            CupertinoTextField(
              controller: _textController3,
            ),
            CupertinoTextField(
              controller: _textController4,
            ),
            CupertinoTextField(
              controller: _textController5,
            ),
            CupertinoButton(
              child: const Text("push al server"),
              onPressed: () {
                // TODO push al server
              },
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              color: signupColor,
              width: 48.0,
              height: 48.0,
            ),
          ]),
        ),
      ),
    );
  }
}