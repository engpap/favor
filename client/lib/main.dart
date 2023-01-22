import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/loading/loading_page.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/introduction/introduction-1.dart';
import 'package:project/screens/home.dart';

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
  bool _isLoading = true;
  late Widget _widgetToBuild;

  @override
  void initState() {
    super.initState();
    _buildTheRightWidgetBasedOnPastInteractions();
  }

  /// If the user has never interacted with the application before, such as they
  ///  have never signed up, then the token will be null and the system will show
  /// the Introduction Screen.
  /// If the user has interacted in the past with the application, the token will
  /// not be null and the system will show the Home  Screen.
  _buildTheRightWidgetBasedOnPastInteractions() async {
    bool isThereUserToken = await Storage.isThereUserToken();
    if (!isThereUserToken) {
      _widgetToBuild = Introduction1Screen();
    } else
      _widgetToBuild = HomeScreen();

    /// For showing the logo for 3 seconds each time the app is created.
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? getCupertinoApp(LoadingPage())
        : getCupertinoApp(_widgetToBuild);
  }
}

/// Function for avoiding duplicated code
Widget getCupertinoApp(home) => CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: home,
    );
