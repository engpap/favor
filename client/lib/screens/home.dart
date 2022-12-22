import 'package:project/screens/components/cupertinoNavigationBar_favor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/tabs.dart';
import 'package:project/providers/getters.dart';
import 'package:project/providers/storage.dart';
import 'package:project/screens/account.dart';
import 'package:project/screens/favor/favor.dart';

import 'package:project/functions/favorColors.dart' as favorColors;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            // HOME
            BottomNavigationBarItem(
              icon: TabsName.values[0].icon,
              label: TabsName.values[0].name,
            ),
            // CHAT
            BottomNavigationBarItem(
              icon: TabsName.values[1].icon,
              label: TabsName.values[1].name,
            ),
            // NEW FAVOR
            BottomNavigationBarItem(
              icon: TabsName.values[2].icon,
              label: TabsName.values[2].name,
            ),
            // LEADERBOARD
            BottomNavigationBarItem(
              icon: TabsName.values[3].icon,
              label: TabsName.values[3].name,
            ),
            // ACCOUNT
            BottomNavigationBarItem(
              icon: TabsName.values[4].icon,
              label: TabsName.values[4].name,
            ),
          ],
        ),
        // BUILD THE INSIDE SCREEN
        tabBuilder: (context, i) {
          return DetailScreen(
            topic: TabsName.values[i].screen,
            //navBar: TabsName.values[i].name,
          );

          // FINE controllo
          /*
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text(TabsName.values[i].name),
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
                            return DetailScreen0(
                                topic: TabsName.values[i].name);
                          }),
                        );
                      },
                    ),
                  ),
                );
              },
            );
            */
        });
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.topic,
    //required this.navBar,
  });

  final Widget topic;
  //final String navBar;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar_favor(
        border: Border(),
        backgroundColor: Colors.white,
        //trailing: Text("${navBar}"),
        middle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FavorNavImage(),
            UserMode(),
          ],
        ),
      ),
      child: topic,

    );
  }
}


bool providerStatus = true;
bool callerStatus = false;

/// ROW composed of 2 buttons. Press to change mode in Provider or Caller
class UserMode extends StatefulWidget {
  const UserMode({super.key});

  @override
  State<UserMode> createState() => _UserModeState();
}

class _UserModeState extends State<UserMode> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// PROVIDER
        Container(
          width: Responsive.width(40, context),
          height: 26,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            color: providerStatus ? favorColors.PrimaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(90),
            child: providerStatus 
            ? Text("Provider", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),) 
            : (Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Change to ", style: TextStyle(color: favorColors.PrimaryBlue, fontWeight: FontWeight.normal)), 
                  Text("Provider", style: TextStyle(color: favorColors.Yellow, fontWeight: FontWeight.bold)),
                ],)
              ),
            onPressed: () {
              setState(() {
                providerStatus = true;
                callerStatus = false;
              });
              print("UserMode: Provider");  
            }),
        ),

        /// CALLER
        Container(
          width: Responsive.width(40, context),
          height: 26,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            color: callerStatus ? favorColors.PrimaryBlue : Colors.transparent, 
            borderRadius: BorderRadius.circular(90),
            child: callerStatus 
              ? Text("Caller", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),) 
              : (Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Change to ", style: TextStyle(color: favorColors.PrimaryBlue, fontWeight: FontWeight.normal)), 
                  Text("Caller", style: TextStyle(color: favorColors.Yellow, fontWeight: FontWeight.bold)),
                ],)
              ), 
            onPressed: () {
              setState(() {
                providerStatus = false;
                callerStatus = true;
              });
              print("UserMode: Caller");            
            }
          ),
        ),
      ],
    );
  }
}


class FavorNavImage extends StatelessWidget {
  const FavorNavImage({super.key});

  @override
  Widget build(BuildContext context) {
    return // IMAGE
      Container(
        width: Responsive.width(25, context),
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage("assets/images/favor.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
      );
  }
}


/** 
class DetailScreen0 extends StatelessWidget {
  const DetailScreen0({super.key, required this.topic});

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
*/