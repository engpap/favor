import 'package:flutter/cupertino.dart';

/// Enumeration of the Tabs present in the BottomNavigationBar
enum TabsName { home, search, settings }

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
      case TabsName.search:
        {
          return const Icon(CupertinoIcons.search);
        }
      case TabsName.settings:
        {
          return const Icon(CupertinoIcons.settings);
        }
    }
  }

  static get values => null;
}
