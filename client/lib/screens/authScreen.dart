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


/**
 * class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final AuthService authService = AuthService();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void signup() {
    authService.signup(
      firstName: 'firstName',
      lastName: 'lastName',
      email: 'wow',
      password: 'password',
      confirmPassword: 'password',
    );
  }

  @override
  Widget build(BuildContext context) {
    return (CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Demo'),
      ),
      child: Center(
        child: CupertinoButton.filled(
          onPressed: () {
            signup();
          },
          child: const Text('SignUp'),
        ),
      ),
    ));
  }
 */
