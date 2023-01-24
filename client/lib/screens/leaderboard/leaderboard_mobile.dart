import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/responsive.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/services/constantsService.dart';
import 'package:project/services/leaderboardService.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/components/favor_PickerMenu.dart';

class Leaderboard_Screen_M extends StatefulWidget {
  final CreateStateFn? createStateFn;
  const Leaderboard_Screen_M({Key? key, this.createStateFn}) : super(key: key);

  @override
  State<Leaderboard_Screen_M> createState() =>
      createStateFn?.call() ?? Leaderboard_Screen_MState();
}

typedef CreateStateFn = Leaderboard_Screen_MState Function();

@visibleForTesting
class Leaderboard_Screen_MState extends State<Leaderboard_Screen_M> {
  late Future<FavorConstants> favorConstants;
  late Future<Leaderboard?> leaderboard;

  final TextEditingController userTypesTextEditingController =
      TextEditingController();
  final TextEditingController locationsTextEditingController =
      TextEditingController();

  String? dropdownValue = null;

  bool leaderboardRequested = false;

  //SliverAppBar props
  bool _pinned = false;
  bool _snap = true;
  bool _floating = true; //So when scrolling back up, the form reopens itself

  @override
  void initState() {
    super.initState();
    favorConstants = ConstantsService().getFavorConstants();
    leaderboard = getLeaderboard();
    userTypesTextEditingController.addListener(() {
      getLeaderboard();
    });
    locationsTextEditingController.addListener(() {
      getLeaderboard();
    });
  }

  Future<Leaderboard?> getLeaderboard() {
    return leaderboard = LeaderboardService().getLeaderboard(
        context: context,
        userType: userTypesTextEditingController.text,
        location: locationsTextEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FavorConstants>(
        future: favorConstants,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return CupertinoPageScaffold(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                      pinned: _pinned,
                      snap: _snap,
                      floating: _floating,
                      expandedHeight: 208.0,
                      elevation:
                          0.0, //Otherwise, transparent would be a "dark" transparent!
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(
                              10), // set the radius to make the app bar rounded
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                              width: Responsive.width(100, context),
                              color: Colors.transparent,
                              child: Column(children: [
                                /// INPUT FORM
                                Container(
                                    margin: EdgeInsets.all(9),
                                    padding: EdgeInsets.all(9),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 0.5,
                                          blurRadius: 5,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                      color: favorColors.IntroBg,
                                      border: Border.all(
                                          color: favorColors.LightGrey,
                                          width: 1.0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(children: [
                                      Favor_pickerMenu(
                                        contentList: snapshot.data!.userTypes
                                            .getRange(0, 2)
                                            .map((e) => Utilities
                                                .capitalizeFirstWordsLetter(e))
                                            .toList(), //Otherwise also "admin" whould be shown.
                                        placeholder: "Ex. Provider",
                                        heading: "Select Provider o Caller",
                                        prefixIcon: CupertinoIcons.person,
                                        textController:
                                            userTypesTextEditingController,
                                      ),
                                      Favor_pickerMenu(
                                        contentList: snapshot.data!.locations
                                            .map((e) => Utilities
                                                .capitalizeFirstWordsLetter(e))
                                            .toList(),
                                        placeholder: "Ex. Loreto",
                                        heading: "Select location",
                                        prefixIcon:
                                            CupertinoIcons.location_solid,
                                        textController:
                                            locationsTextEditingController,
                                      ),
                                    ]))
                              ])))),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return FutureBuilder<Leaderboard?>(
                            future: leaderboard,
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(children: [
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data!.leaderboard.length,
                                      itemBuilder: (context, itemIndex) {
                                        return LeaderboardCard(
                                          personName: snapshot
                                              .data!.leaderboard.keys
                                              .toList()[itemIndex]
                                              .name,
                                          personSurname: snapshot
                                              .data!.leaderboard.keys
                                              .toList()[itemIndex]
                                              .surname,
                                          leaderboardPosition: itemIndex + 1,
                                          personImage: snapshot
                                              .data!.leaderboard.keys
                                              .toList()[itemIndex]
                                              .profilePicture,
                                          starsNumber: snapshot
                                                  .data!.leaderboard[
                                              snapshot.data!.leaderboard.keys
                                                  .toList()[itemIndex]],
                                        );
                                      })
                                ]);
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return CupertinoActivityIndicator(
                                  animating: false, radius: 10);
                            }));
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CupertinoActivityIndicator(animating: false, radius: 10);
        }));
  }
}
