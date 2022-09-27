import 'package:flutter/cupertino.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/authScreen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("Auth page");
  }
}
