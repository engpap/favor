import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';

class Leaderboard_Screen_M extends StatelessWidget {
  const Leaderboard_Screen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LeaderboardCard(
          personName: "Maria",
          rankPosition: 1,
          personImage: "assets/images/chris.jpg",
          starNumber: 5,
        ),
       LeaderboardCard(
          personName: "Marco",
          rankPosition: 2,
          starNumber: 3,
        ),
        LeaderboardCard(
          personName: "Andrea",
          rankPosition: 3,
          starNumber: 0,
        ),
        LeaderboardCard(
          personName: "Camilla",
          rankPosition: 4,
          starNumber: 2,
        ),
      ]
    )
    ;
  }
}