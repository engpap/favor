import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/services/leaderboardService.dart';

class Leaderboard_Screen_M extends StatefulWidget {
  const Leaderboard_Screen_M({super.key});

  @override
  State<Leaderboard_Screen_M> createState() => _Leaderboard_Screen_MState();
}

class _Leaderboard_Screen_MState extends State<Leaderboard_Screen_M> {
  late Future<Leaderboard?> leaderboard;

  @override
  void initState() {
    super.initState();
    leaderboard = LeaderboardService().getLeaderboard(
        context: context, userType: "caller", location: "loreto");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Leaderboard?>(
        future: leaderboard,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Column(children: [
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
            ]);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CupertinoActivityIndicator(animating: false, radius: 10);
        }));
  }
}
