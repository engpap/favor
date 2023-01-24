import 'package:flutter/cupertino.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

import 'introduction-2.dart';
import 'introduction-3.dart';


class Introduction1Screen extends StatelessWidget {
  const Introduction1Screen({super.key});

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
            mobileBody: Introduction1Screen_M_T(),
            tabletBody: Introduction1Screen_M_T(),
          ),
        )
      )
    );
  }
}

//USED BOTH MOBILE AND TABLET
class Introduction1Screen_M_T extends StatelessWidget {
  const Introduction1Screen_M_T({super.key});

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
                    builder: (context) => const Introduction2Screen()),
                );
              },          
              child: Container(
                width: Responsive.width(100, context),
                child: Image(
                  image: AssetImage("assets/images/intro1.png"),
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


/// BOTTOM NAVIGATION BAR
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
              size: 40,
              color: favorColors.PrimaryBlue,
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
              size: 25,
              color: Color.fromARGB(255, 217, 217, 217),
            ),
          ),
        ), 
      ]
    );
  }
}