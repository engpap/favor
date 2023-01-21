import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/models/leaderboard.dart';

import 'package:project/screens/components/starsWidget.dart';
import 'package:project/screens/explore/explore_mobile.dart';
import 'package:project/screens/explore/explore_tablet.dart';

import 'package:project/screens/leaderboard/leaderboard_mobile.dart';
import 'package:project/screens/leaderboard/leaderboard_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';

class Explore_Screen extends StatelessWidget {
  const Explore_Screen({super.key});

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
            //backgroundColor: favorColors.IntroBg,
            child: SafeArea(
          child: ResponsiveLeayout(
            mobileBody: Explore_Screen_M(),
            tabletBody: Explore_Screen_T(),
          ),
        )));
  }
}
