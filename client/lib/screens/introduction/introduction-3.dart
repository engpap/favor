import 'package:flutter/cupertino.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

import 'introduction-1.dart';
import 'introduction-2.dart';

class Introduction3Screen extends StatelessWidget {
  const Introduction3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: CupertinoPageScaffold(
            backgroundColor: favorColors.IntroBg,
            child: SafeArea(
              child: ResponsiveLeayout(
                mobileBody: Introduction3Screen_M_T(),
                tabletBody: Introduction3Screen_M_T(),
              ),
            )));
  }
}

class Introduction3Screen_M_T extends StatelessWidget {
  const Introduction3Screen_M_T({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // ACTUAL PAGE
          Expanded(
              child: GestureDetector(
            key: Key("gesture_detector_intro3"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => HomeScreen()),
                /// HomeScreen is pushed so the users can see how the app looks like and eventually sign up.
              );
            },
            child: Container(
              width: Responsive.width(100, context),
              child: Image(
                image: AssetImage("assets/images/intro3.png"),
              ),
            ),
          )),
          // NAVIGATION BAR
          IntroNavBar(),
        ],
      ),
    );
  }
}

/// BOTTOM NAVIGATION BAR
class IntroNavBar extends StatelessWidget {
  const IntroNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 1,
        child: CupertinoButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => const Introduction1Screen()),
            );
          },
          child: Icon(
            CupertinoIcons.circle_fill,
            size: 25,
            color: Color.fromARGB(255, 217, 217, 217),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: CupertinoButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => const Introduction2Screen()),
            );
          },
          child: Icon(
            CupertinoIcons.circle_fill,
            size: 25,
            color: Color.fromARGB(255, 217, 217, 217),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: CupertinoButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                  builder: (context) => const Introduction3Screen()),
            );
          },
          child: Icon(
            CupertinoIcons.circle_fill,
            size: 40,
            color: favorColors.Yellow,
          ),
        ),
      ),
    ]);
  }
}
