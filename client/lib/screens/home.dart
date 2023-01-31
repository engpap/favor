import 'package:project/screens/components/cupertinoNavigationBar_favor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/tabs.dart' as FavorTab;
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/responsiveLayout.dart';

/// Class used to controll the UserMode
/// it's a StatefulWidget that wraps an InheritedWidget in order to get both functionalities
class UserMode extends StatefulWidget {
  const UserMode({super.key, required this.child});
  final Widget child;

  @override
  State<UserMode> createState() => UserModeState();
}

@visibleForTesting
class UserModeState extends State<UserMode> {
  bool providerStatus_state = true;
  bool callerStatus_state = false;
  bool adminStatus_state = false;

  void setUserMode_provider() {
    setState(() {
      // internal variables
      providerStatus_state = true;
      callerStatus_state = false;
      adminStatus_state = false;
    });
  }

  void setUserMode_caller() {
    setState(() {
      // internal variables
      providerStatus_state = false;
      callerStatus_state = true;
      adminStatus_state = false;
    });
  }

  void setUserMode_admin() {
    setState(() {
      // internal variables
      providerStatus_state = false;
      callerStatus_state = false;
      adminStatus_state = true;
    });
  }

  bool isUserModeAs_provider() {
    return providerStatus_state && !callerStatus_state && !adminStatus_state;
  }

  bool isUserModeAs_caller() {
    return callerStatus_state && !providerStatus_state && !adminStatus_state;
  }

  bool isUserModeAs_admin() {
    return adminStatus_state && !providerStatus_state && !callerStatus_state;
  }

  String getUserMode() {
    if (providerStatus_state) {
      print("UserMode: Provider");
      return 'provider';
    } else if (callerStatus_state) {
      print("UserMode: Caller");
      return 'caller';
    } else if (adminStatus_state) {
      print("UserMode: Admin");
      return 'admin';
    } else {
      throw Exception("No UserMode set, this situation should not occur");
    }
  }

  String getOppositeUserMode() {
    if (providerStatus_state) {
      print("UserMode: Provider");
      return 'caller';
    } else if (callerStatus_state) {
      print("UserMode: Caller");
      return 'provider';
    } else if (adminStatus_state) {
      print("UserMode: Admin");
      print(">>> getOppositeUserMode: Returning empty String");
      // In this case, we return an empty string, since there is not opposite status of admin!
      return '';
    } else {
      throw Exception("No UserMode set, this situation should not occur");
    }
  }

  @override
  Widget build(BuildContext context) => UserMode_inherited(
        child: widget.child,
        provider: providerStatus_state,
        caller: callerStatus_state,
        admin: adminStatus_state,
        stateWidget: this,
      );
}

class UserMode_inherited extends InheritedWidget {
  const UserMode_inherited({
    super.key,
    required super.child,
    required this.provider,
    required this.caller,
    required this.admin,
    required this.stateWidget,
  });

  final bool provider;
  final bool caller;
  final bool admin;
  final UserModeState stateWidget;

  static UserMode_inherited? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserMode_inherited>();
  }

  static UserMode_inherited of(BuildContext context) {
    final UserMode_inherited? result = maybeOf(context);
    assert(result != null, 'No UserMode_inherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(UserMode_inherited oldWidget) =>
      provider != oldWidget.provider ||
      caller != oldWidget.caller ||
      admin != oldWidget.admin;
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CupertinoTabController tabController = FavorTab.tabController;

  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: buildHome(context),
      tabletBody: buildHome(context),
    );
  }

  @override
  Widget buildHome(BuildContext context) {
    return UserMode(
      key: UniqueKey(),
      child: CupertinoTabScaffold(
          controller: tabController,
          tabBar: CupertinoTabBar(
            key: Key("cupertino_tab_bar"),
            activeColor: favorColors.PrimaryBlue,
            items: [
              // HOME
              BottomNavigationBarItem(
                icon: FavorTab.TabsName.values[0].icon,
                label: FavorTab.TabsName.values[0].name,
              ),
              // CHAT
              BottomNavigationBarItem(
                icon: FavorTab.TabsName.values[1].icon,
                label: FavorTab.TabsName.values[1].name,
              ),
              // NEW FAVOR
              BottomNavigationBarItem(
                icon: FavorTab.TabsName.values[2].icon,
                label:
                    "New Favor", //OLD VALUE: TabsName.values[2].name, TODO: cambiarlo
              ),
              // LEADERBOARD
              BottomNavigationBarItem(
                icon: FavorTab.TabsName.values[3].icon,
                label: FavorTab.TabsName.values[3].name,
              ),
              // ACCOUNT
              BottomNavigationBarItem(
                icon: FavorTab.TabsName.values[4].icon,
                label: FavorTab.TabsName.values[4].name,
              ),
            ],
          ),
          // BUILD THE INSIDE SCREEN
          tabBuilder: (context, i) {
            return DetailScreen(
              topic: FavorTab.TabsName.values[i].screen,
            );
          }),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    super.key,
    required this.topic,
  });

  final Widget topic;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar_favor(
        border: Border(),
        backgroundColor: Colors.white,
        middle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FavorNavImage(),
            NavUserMode(),
          ],
        ),
      ),
      child: topic,
    );
  }
}

/// ROW composed of 2 buttons. Press to change UserMode in Provider or Caller
class NavUserMode extends StatefulWidget {
  const NavUserMode({super.key});

  @override
  State<NavUserMode> createState() => _NavUserModeState();
}

class _NavUserModeState extends State<NavUserMode> {
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
              color: UserMode_inherited.of(context)
                      .stateWidget
                      .isUserModeAs_provider()
                  ? favorColors.PrimaryBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(90),
              child: UserMode_inherited.of(context)
                      .stateWidget
                      .isUserModeAs_provider()
                  ? Text(
                      "Provider",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : (Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Change to ",
                            style: TextStyle(
                                color: favorColors.PrimaryBlue,
                                fontWeight: FontWeight.normal)),
                        Text("Provider",
                            style: TextStyle(
                                color: favorColors.Yellow,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
              onPressed: () {
                setState(() {
                  UserMode_inherited.of(context)
                      .stateWidget
                      .setUserMode_provider();
                });
              }),
        ),

        /// CALLER
        Container(
          width: Responsive.width(40, context),
          height: 26,
          child: CupertinoButton(
              padding: EdgeInsets.zero,
              color: UserMode_inherited.of(context)
                      .stateWidget
                      .isUserModeAs_caller()
                  ? favorColors.PrimaryBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(90),
              child: UserMode_inherited.of(context)
                      .stateWidget
                      .isUserModeAs_caller()
                  ? Text(
                      "Caller",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : (Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Change to ",
                            style: TextStyle(
                                color: favorColors.PrimaryBlue,
                                fontWeight: FontWeight.normal)),
                        Text("Caller",
                            style: TextStyle(
                                color: favorColors.Yellow,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
              onPressed: () {
                setState(() {
                  UserMode_inherited.of(context)
                      .stateWidget
                      .setUserMode_caller();
                });
              }),
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
