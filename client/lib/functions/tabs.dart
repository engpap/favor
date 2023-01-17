import 'package:flutter/cupertino.dart';
import 'package:project/screens/account.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/favor/favor2.dart'; //
import 'package:project/screens/feed/feed.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

/// Enumeration of the Tabs present in the BottomNavigationBar
enum TabsName { Home, Search, Favor, Leaderboard, Account }

/// List of Icons present in the BottomNavigationBar
extension TabsIcon on TabsName {
  Icon get icon {
    switch (this) {
      case TabsName.Home:
        {
          return const Icon(
            CupertinoIcons.home,
          );
        }
      case TabsName.Search:
        {
          return const Icon(
            CupertinoIcons.search,
          );
        }
      case TabsName.Favor:
        {
          return const Icon(
            CupertinoIcons.add_circled,
          );
        }
      case TabsName.Leaderboard:
        {
          return const Icon(
            CupertinoIcons.chart_bar,
          );
        }
      case TabsName.Account:
        {
          return const Icon(
            CupertinoIcons.profile_circled,
          );
        }
    }
  }

  static get values => null;
}

/// List of Icons present in the BottomNavigationBar
extension TabsScreen on TabsName {
  Widget get screen {
    switch (this) {
      case TabsName.Home:
        {
          return Feed_Screen();
        }
      case TabsName.Search:
        {
          return Text(""); //TODO
        }
      case TabsName.Favor:
        {
          return FavorScreen();
        }
      case TabsName.Leaderboard:
        {
          return Leaderboard_Screen();
        }
      case TabsName.Account:
        {
          return AccountScreen();
        }
    }
  }

  static get values => null;
}
