import 'package:flutter/cupertino.dart';
import 'package:project/providers/userProvider.dart';
import 'package:provider/provider.dart';

import 'package:project/screens/introduction/introduction-1.dart';
import 'package:project/screens/home.dart';
import 'screens/favorInformationPage/favorInformationPage.dart';
import 'screens/feed/feed.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: Introduction1Screen(),
      //home: HomeScreen(),
      //home: favorInformationPage_Screen(),
      //home:Feed_Screen(),
    );
  }
}
