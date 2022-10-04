import 'package:flutter/cupertino.dart';
import 'package:project/screens/singup.dart';

// import 'package:project/screens/auth.dart';
// import 'package:project/router.dart';

void main() {
  runApp(const MyApp());
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
            color: CupertinoColors.activeOrange,
          ),
          actionTextStyle: TextStyle(
            color: Color(0xFFE84817),
          ),
        ),
      ),
      //home: HomeScreen(),
      home: SignUpScreen(),
    );
  }
}
