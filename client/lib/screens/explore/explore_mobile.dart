import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/screens/explore/search_favor_bar.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/services/constantsService.dart';
import 'package:project/services/leaderboardService.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

import '../feed/feed_mobile.dart';

class Explore_Screen_M extends StatelessWidget {
  const Explore_Screen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child:
          LayoutBuilder(//Otherwiese content would be under the bottom nav bar.
              builder: (BuildContext context, BoxConstraints constraints) {
        final double navBarHeight =
            50.0; //Default height based on documentation -> https://api.flutter.dev/flutter/cupertino/CupertinoTabBar/height.html
        final double availableHeight =
            constraints.biggest.height - navBarHeight;
        return CustomScrollView(slivers: [
          SearchFavorBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    height: availableHeight,
                    child: RecommendedFavorWidgetsList_Widget(
                      shrinkWrap: true,
                    ));
              },
              childCount: 1,
            ),
          ),
        ]);
      }),
    );
  }
}
