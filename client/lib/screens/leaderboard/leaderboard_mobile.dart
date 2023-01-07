import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/services/leaderboardService.dart';
import 'globals.dart' as globals;
import 'package:project/functions/favorColors.dart' as favorColors;

class Leaderboard_Screen_M extends StatefulWidget {
  const Leaderboard_Screen_M({super.key});

  @override
  State<Leaderboard_Screen_M> createState() => _Leaderboard_Screen_MState();
}

class _Leaderboard_Screen_MState extends State<Leaderboard_Screen_M> {
  String? _selectedUserType = null;
  String? _selectedLocation = null;
  String? dropdownValue = null;
  //List<String> _userTypes = <String>["Providers", "Callers"];
  List<String> _locations = <String>["Loreto", "Lambrate"];
  List<Text> _userTypes = [Text("Provider"), Text("Caller")];

  //SliverAppBar props
  bool _pinned = false;
  bool _snap = true;
  bool _floating = true; //So when scrolling back up, the form reopens itself

  late Future<Leaderboard?> leaderboard;

  @override
  void initState() {
    super.initState();
    _selectedUserType = '';
    _selectedLocation = '';
    leaderboard = LeaderboardService().getLeaderboard(
        context: context, userType: "caller", location: "loreto");
  }

  @override
  Widget build(BuildContext context) {
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
                        /// FORM
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
                              color: favorColors.Yellow,
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
                                contentList:
                                    _userTypes, //snapshot.data!.favorCategories,
                                placeholder:
                                    "Ex. Provider", //globals.categoryPlaceholder,
                                heading:
                                    "Select Provider o Caller", //globals.categoryHeading,
                                prefixIcon: CupertinoIcons
                                    .location_solid, //globals.categoryPrefixIcon,
                                textController: TextEditingController(text: ""),
                                flag: 1, //if possible remove this
                              ),
                              Favor_pickerMenu(
                                contentList:
                                    _userTypes, //snapshot.data!.favorCategories,
                                placeholder:
                                    "Ex. Loreto", //globals.categoryPlaceholder,
                                heading:
                                    "Select location", //globals.categoryHeading,
                                prefixIcon: CupertinoIcons
                                    .location_solid, //globals.categoryPrefixIcon,
                                textController: TextEditingController(text: ""),
                                flag: 1, //if possible remove this
                              ),
                            ]))
                      ])))),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
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
                ]);
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            width: Responsive.width(100, context),
            color: Colors.white,
            child: Column(
              children: [
                /// FORM
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
                        contentList:
                            _userTypes, //snapshot.data!.favorCategories,
                        placeholder:
                            "Ex. Provider", //globals.categoryPlaceholder,
                        heading:
                            "Select Provider o Caller", //globals.categoryHeading,
                        prefixIcon: CupertinoIcons
                            .location_solid, //globals.categoryPrefixIcon,
                        textController: TextEditingController(text: ""),
                        flag: 1, //if possible remove this
                      ),
                      Favor_pickerMenu(
                        contentList:
                            _userTypes, //snapshot.data!.favorCategories,
                        placeholder:
                            "Ex. Provider", //globals.categoryPlaceholder,
                        heading:
                            "Select Provider o Caller", //globals.categoryHeading,
                        prefixIcon: CupertinoIcons
                            .location_solid, //globals.categoryPrefixIcon,
                        textController: TextEditingController(text: ""),
                        flag: 1, //if possible remove this
                      ),
                    ])),

                /*Container(
                    height: 50.0,
                    width: 150.0,
                    child: DropdownButtonFormField(
                      //menuMaxHeight: Responsive.height(20, context),
                      value: dropdownValue,
                      items: _userTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                  ),
                  Container(
                      height: 50.0,
                      width: 150.0,
                      child: DropdownButtonFormField(
                        //menuMaxHeight: Responsive.height(20, context),
                        value: dropdownValue,
                        items: _locations
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            _selectedLocation = value!;
                          });
                        },
                      )),*/
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
              ],
            )));
  }
  /*
      Expanded(
          child: CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 32.0,
        onSelectedItemChanged: (int index) {
          setState(() {
            _selectedUserType = _userTypes[index];
          });
        },
        children: _userTypes.map((userType) {
          return Text(userType);
        }).toList(),*/
*/
  /*

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
  }*/
}


/**
 * TODO:
 * CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              background: FlutterLogo(),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
 */