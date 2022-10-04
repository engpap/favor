import 'package:flutter/cupertino.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      child: Center(
        child: CupertinoButton(
          child: const Text("go homeScreen"),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
    );
  }
}
