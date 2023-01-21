import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/favor/favor2.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/screens/leaderboard/leaderboard_mobile.dart';
import 'package:project/screens/loading/loading_page.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/introduction/introduction-1.dart';
import 'package:project/screens/home.dart';
import 'screens/favorInformationPage/favorInformationPage.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Widget>? widgetToBuild;

  @override
  void initState() {
    super.initState();
    widgetToBuild = buildTheRightWidgetBasedOnPastInteractions();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: widgetToBuild,
      builder: ((context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return CupertinoApp(
            localizationsDelegates: [
              DefaultMaterialLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            home: LoadingPage(snapshot.data!),
          );
        } else if (snapshot.hasError) {
          return CupertinoApp(localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ], home: Text("Error"));
        }
        return CupertinoApp(
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: CupertinoActivityIndicator(),
        );
      }),
    );
  }
}

/// If the user has never interacted with the application before, such as they
///  have never signed up, then the token will be null and the system will show
/// the Introduction Screen.
/// If the user has interacted in the past with the application, the token will
/// not be null and the system will show the Home  Screen.
Future<Widget> buildTheRightWidgetBasedOnPastInteractions() async {
  bool isThereUserToken = await Storage.isThereUserToken();
  if (!isThereUserToken) {
    return Introduction1Screen();
  } else
    return HomeScreen();
}
