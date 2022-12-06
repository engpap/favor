import 'package:flutter/cupertino.dart';
import 'package:project/functions/tabs.dart';
import 'package:project/providers/getters.dart';
import 'package:project/providers/storage.dart';
import 'package:project/screens/account.dart';

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
          // INIZIO Controllo solo per il test dell'account page
          if (i == 2)
            return AccountScreen();
          else
            // FINE controllo
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  //backgroundColor: Color.fromARGB(160, 255, 109, 64),
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(TabsName.values[i].name),
                    //backgroundColor: Colors.deepOrangeAccent,
                  ),
                  child: Center(
                    child: CupertinoButton(
                      child: FutureBuilder<String?>(
                          future: Storage.getUserToken(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                  'Token got from server: ${snapshot.data!}');
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return CupertinoActivityIndicator(
                                animating: false, radius: 10);
                          }),
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
