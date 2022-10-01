import 'package:flutter/cupertino.dart';
import 'package:project/services/tabs.dart';

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: TabsName.values[0].icon,
              label: TabsName.values[0].name,
            ),
            BottomNavigationBarItem(
              icon: TabsName.values[1].icon,
              label: TabsName.values[1].name,
            ),
            BottomNavigationBarItem(
              icon: TabsName.values[2].icon,
              label: TabsName.values[2].name,
            ),
          ],
          // TODO: substitute this list with a for each
          /* TabsName.values.forEach((element) {
              BottomNavigationBarItem(
              icon: TabsName.values[element].icon,
              label: TabsName.values[element].name,
            )
          }) */
        ),
        tabBuilder: (context, i) {
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text(TabsName.values[i].name),
                ),
                child: Center(
                  child: CupertinoButton(
                    child: Text(
                      "This is tab ${TabsName.values[i].name}!",
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .actionTextStyle
                          .copyWith(fontSize: 32),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) {
                          return DetailScreen(topic: TabsName.values[i].name);
                        }),
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.topic});

  final String topic;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Details "),
      ),
      child: Center(
        child: Text(
          "Details for $topic",
          style: CupertinoTheme.of(context).textTheme.navActionTextStyle,
        ),
      ),
    );
  }
}
