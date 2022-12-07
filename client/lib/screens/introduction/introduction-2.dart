import 'package:flutter/cupertino.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

import 'introduction-1.dart';
import 'introduction-3.dart';


class Introduction2Screen extends StatelessWidget {
  const Introduction2Screen({super.key});

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
            mobileBody: Introduction2Screen_M(),
            //TODO do we need tablet?
            tabletBody: Introduction2Screen_M(),
          ),
        )
      )
    );
  }
}


class Introduction2Screen_M extends StatelessWidget {
  const Introduction2Screen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // ACTUAL PAGE
          Expanded(
            child: GestureDetector(   
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Introduction3Screen()),
                );
              },          
              child: Container(
                width: Responsive.width(100, context),
                child: Image(
                  image: AssetImage("assets/images/intro2.png"),
                ),
              ),
            )
          ),
          // NAVIGATION BAR
          IntroNavBar(),
        ],
      ),
    );
  }
}

//TODO do we need this?
class Introduction2Screen_T extends StatelessWidget {
  const Introduction2Screen_T({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class IntroNavBar extends StatelessWidget {
  const IntroNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
              size: 40,
              color: favorColors.SecondaryBlue,
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
              size: 25,
              color: Color.fromARGB(255, 217, 217, 217),
            ),
          ),
        ), 
      ]
    );
  }
}