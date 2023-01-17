import 'package:flutter/cupertino.dart';
import 'package:project/screens/account.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/favor/favor2.dart'; //
import 'package:project/screens/feed/feed.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';

/// Enumeration of the Tabs present in the BottomNavigationBar
enum TabsName { home, chat, favor, leaderboard, account }

/// List of Icons present in the BottomNavigationBar
extension TabsIcon on TabsName {
  Icon get icon {
    switch (this) {
      case TabsName.home:
        {
          return const Icon(
            CupertinoIcons.home,
            //color: Color(0xFFE84817),
          );
        }
      case TabsName.chat:
        {
          return const Icon(CupertinoIcons.chat_bubble_2);
        }
      case TabsName.favor:
        {
          return const Icon(CupertinoIcons.add_circled);
        }
      case TabsName.leaderboard:
        {
          return const Icon(CupertinoIcons.chart_bar);
        }
      case TabsName.account:
        {
          return const Icon(CupertinoIcons.profile_circled);
        }
    }
  }

  static get values => null;
}

/// List of Icons present in the BottomNavigationBar
extension TabsScreen on TabsName {
  Widget get screen {
    switch (this) {
      case TabsName.home:
        {
          return Feed_Screen();
        }
      case TabsName.chat:
        {
          return Text(""); //TODO
        }
      case TabsName.favor:
        {
          return FavorScreen();
        }
      case TabsName.leaderboard:
        {
          return Leaderboard_Screen();
        }
      case TabsName.account:
        {
          return AccountScreen();
        }
    }
  }

  static get values => null;
}
