import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/providers/userProvider.dart';
import 'package:project/screens/welcome.dart';
import 'package:provider/provider.dart';

// import 'package:project/screens/auth.dart';
// import 'package:project/router.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          navLargeTitleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50.0,
            color: Colors.deepOrangeAccent,
          ),
          actionTextStyle: TextStyle(
              //color: Colors.black,
              ),
        ),
        //barBackgroundColor: Colors.deepOrangeAccent,
      ),
      home: WelcomeScreen(),
    );
  }
}
