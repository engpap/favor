import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/providers/userProvider.dart';
import 'package:project/screens/favor/favor2.dart';
import 'package:provider/provider.dart';

import 'package:project/screens/introduction/introduction-1.dart';
import 'package:project/screens/home.dart';
import 'screens/favorInformationPage/favorInformationPage.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return const CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: Introduction1Screen(),
      //home: FavorForm_caller(),
      //home: HomeScreen(),
      //home: favorInformationPage_Screen(),
    );
  }
}
