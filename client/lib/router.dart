/// TODO code to be replaced/removed

import 'package:flutter/material.dart';
import 'package:project/screens/authScreen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
            body: Center(
          child: Text("This screen does not exists!"),
        )),
      );
  }
}
