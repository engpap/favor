import 'package:flutter/cupertino.dart';
import 'package:project/providers/userProvider.dart';
import 'package:provider/provider.dart';

import 'package:project/screens/introduction/introduction-1.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of the application.
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: Introduction1Screen(),
    );
  }
}
