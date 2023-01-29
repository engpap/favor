import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/utilities.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/components/favor_PickerMenu.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:provider/provider.dart';

class Leaderboard_Screen_M extends StatefulWidget {
  const Leaderboard_Screen_M({super.key});

  @override
  State<Leaderboard_Screen_M> createState() => _Leaderboard_Screen_MState();
}

class _Leaderboard_Screen_MState extends State<Leaderboard_Screen_M> {
  late Future<FavorConstants> favorConstants;
  Future<Leaderboard?>? leaderboard = null;

  final TextEditingController userTypesTextEditingController =
      TextEditingController();
  final TextEditingController locationsTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    locationsTextEditingController.addListener(() {
      getLeaderboard();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    favorConstants = Provider.of<AppProvider>(context).getFavorConstants();
  }

  Future<Leaderboard?> getLeaderboard() {
    return leaderboard = Provider.of<AppProvider>(context, listen: false)
        .getLeaderboard(
            context: context,
            userType: UserMode_inherited.of(context).stateWidget.getUserMode(),
            location: locationsTextEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Center(
          // REFRESH
          child: RefreshIndicator(
            color: favorColors.PrimaryBlue,
            backgroundColor: Colors.white,
            onRefresh: () async {
              getLeaderboard();
              setState(() {});
              return;
            },
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              // SEARCH BAR
              Container(
                  margin: EdgeInsets.all(9), child: buildLadderBar(context)),
              // ITEMS
              // used this method just to rebuild when a userMode change
              UserMode_inherited.of(context).stateWidget.isUserModeAs_caller()
                  ? buildLadder(context)
                  : buildLadder(context),
            ]),
          ),
        ));
  }

  // SEARCH BAR
  Widget buildLadderBar(BuildContext context) {
    return FutureBuilder<FavorConstants>(
        future: favorConstants,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                child: Favor_pickerMenu(
              contentList: snapshot.data!.locations
                  .map((e) => Utilities.capitalizeFirstWordsLetter(e))
                  .toList(),
              placeholder: "Select an Area --->",
              heading: "",
              prefixIcon: CupertinoIcons.location_solid,
              textController: locationsTextEditingController,
            ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CupertinoActivityIndicator(animating: false, radius: 10);
        }));
  }

  // ITEMS
  Widget buildLadder(BuildContext context) {
    getLeaderboard();
    return Expanded(
      child: FutureBuilder<Leaderboard?>(
          future: leaderboard,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.leaderboard.length,
                    itemBuilder: (context, itemIndex) {
                      return LeaderboardCard(
                        personName: snapshot.data!.leaderboard.keys
                            .toList()[itemIndex]
                            .name,
                        personSurname: snapshot.data!.leaderboard.keys
                            .toList()[itemIndex]
                            .surname,
                        leaderboardPosition: itemIndex + 1,
                        personImage: snapshot.data!.leaderboard.keys
                            .toList()[itemIndex]
                            .profilePicture,
                        starsNumber: snapshot.data!.leaderboard[snapshot
                            .data!.leaderboard.keys
                            .toList()[itemIndex]],
                      );
                    })
              ]);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // Because don't load without an input
            return Center(child: Text("waiting for your input"));
          })),
    );
  }
}
