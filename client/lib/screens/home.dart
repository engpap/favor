import 'package:project/screens/components/cupertinoNavigationBar_favor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/tabs.dart';

import 'package:project/functions/favorColors.dart' as favorColors;

// GLOBAL VARIABLES where is saved the UserMode
bool PROVIDERstatus = true; // initaial value
bool CALLERstatus = false;
bool ADMINstatus = false;

// GLOBAL FUNCTIONS to read the UserMode
bool isUserModeAsProvider() {
  return PROVIDERstatus && !CALLERstatus;
}

bool isUserModeAsCaller() {
  return CALLERstatus && !PROVIDERstatus;
}

String getUserMode() {
  if (PROVIDERstatus) {
    print("UserMode: Provider");
    return 'provider';
  } else if (CALLERstatus) {
    print("UserMode: Caller");
    return 'caller';
  } else if (ADMINstatus) {
    print("UserMode: Admin");
    return 'admin';
  } else {
    throw Exception("No UserMode set, this situation should not occur");
  }
}

/// Class used to controll the UserMode
/// it's a StatefulWidget that wraps an InheritedWidget in order to get both functionalities
class UserMode extends StatefulWidget {
  const UserMode({super.key, required this.child});
  final Widget child;

  @override
  State<UserMode> createState() => _UserModeState();
}

class _UserModeState extends State<UserMode> {
  bool providerStatus_state = PROVIDERstatus;
  bool callerStatus_state = CALLERstatus;
  bool adminStatus_state = ADMINstatus;

  void setUserMode_provider() {
    setState(() {
      // internal variables
      providerStatus_state = true;
      callerStatus_state = false;
      adminStatus_state = false;
      // global variables
      PROVIDERstatus = true;
      CALLERstatus = false;
      ADMINstatus = false;
    });
  }

  void setUserMode_caller() {
    setState(() {
      // internal variables
      providerStatus_state = false;
      callerStatus_state = true;
      adminStatus_state = false;
      // global variables
      PROVIDERstatus = false;
      CALLERstatus = true;
      ADMINstatus = false;
    });
  }

  void setUserMode_admin() {
    setState(() {
      // internal variables
      providerStatus_state = false;
      callerStatus_state = false;
      adminStatus_state = true;
      // global variables
      PROVIDERstatus = false;
      CALLERstatus = false;
      ADMINstatus = true;
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
  final _UserModeState stateWidget;

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
      admin != oldWidget.admin; //|| stateWidget != oldWidget.stateWidget;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UserMode(
      key: UniqueKey(),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: favorColors.PrimaryBlue,
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
        backgroundColor: Colors
            .white, //TODO: change image background in order to change also this one. now set Colors.white to match
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
