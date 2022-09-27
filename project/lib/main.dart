import 'package:flutter/cupertino.dart';
import 'package:project/screens/auth.dart';
import 'package:project/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'MyApp',
      //onGenerateRoute will be called everytime pushName is used
      onGenerateRoute: (settings) => generateRoute(settings),
      //home: const AuthScreen(),
      home: const MyHomePage(title: 'Hello  world!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Demo'),
      ),
      child: Center(
        child: Text("Hi"),
      ),
    ));
  }
}
