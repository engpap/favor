import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/components/starsWidget.dart';
import 'package:project/screens/responsiveLayout.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:provider/provider.dart';

class AccountScreen_T extends StatefulWidget {
  const AccountScreen_T({super.key});

  @override
  State<AccountScreen_T> createState() => _AccountScreen_TState();
}

class _AccountScreen_TState extends State<AccountScreen_T> {
  late Future<User?> _user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<AppProvider>(context, listen: false)
        .getMyUserProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
            key: Key("account_tablet"),
            width: Responsive.width(100, context),
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LEFT BLOCK
                SingleChildScrollView(
                  child: Container(
                    width: Responsive.homeColumnWidth(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        SizedBox(
                          height: 10,
                        ),
                        // RETRIVE USER DATA - then build
                        FutureBuilder<User?>(
                            future: _user,
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // IMAGE
                                      Container(
                                        width: Responsive.widthFixOver(
                                            120, 30, context),
                                        height: Responsive.widthFixOver(
                                            120, 30, context),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            //image: AssetImage("assets/images/chris.jpg"),
                                            image: Image.memory(snapshot
                                                    .data!.profilePicture.bytes)
                                                .image,
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                            color: favorColors.LightGrey,
                                            width: 1.0,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              spreadRadius: 0.5,
                                              blurRadius: 5,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // NAME AND SURNAME
                                      Text(
                                        key: Key("name_surname_text"),
                                        "${snapshot.data!.name} ${snapshot.data!.surname}",
                                        style: TextStyle(
                                          fontSize: Responsive.widthFixOver(
                                              30, 10, context),
                                          fontWeight: FontWeight.bold,
                                          color: favorColors.PrimaryBlue,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      // EMAIL
                                      Text(
                                        key: Key("email_text"),
                                        snapshot.data!.email!,
                                        style: TextStyle(
                                            fontSize: Responsive.widthFixOver(
                                                18, 5, context)),
                                        overflow: TextOverflow.fade,
                                      ),
                                      //
                                      SizedBox(
                                        height: 15,
                                      ),
                                      // STARS
                                      StarsWidget(
                                        number: snapshot.data!.averageRatings,
                                        size: Responsive.widthFixOver(
                                            35, 10, context),
                                      ),
                                    ],
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // WHILE WAITING USER DATA
                              return CupertinoActivityIndicator(
                                  animating: false, radius: 20);
                            })),
                        //
                        SizedBox(
                          height: 65,
                        ),
                        // LOG OUT
                        buildLogOut(context),
                      ],
                    ),
                  ),
                ),
                // RIGHT BLOCK
                SingleChildScrollView(
                  child: Container(
                    width: Responsive.homeColumnWidth(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //
                        SizedBox(
                          height: 10,
                        ),
                        // RETRIVE USER DATA - then build
                        FutureBuilder<User?>(
                            future: _user,
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // BIO
                                    Text(
                                      "My Bio",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      key: Key("bio_text"),
                                      snapshot.data!.bio!,
                                      style: TextStyle(fontSize: 18),
                                      overflow: TextOverflow.fade,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // PERSONAL SIGN
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // AGE
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Age",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                key: Key("age_text"),
                                                snapshot.data!.age!.toString(),
                                                style: TextStyle(fontSize: 18),
                                                overflow: TextOverflow.fade,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // JOB
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Job",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                key: Key("job_text"),
                                                snapshot.data!.job!,
                                                style: TextStyle(fontSize: 18),
                                                overflow: TextOverflow.fade,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // City
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "City",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                key: Key("city_text"),
                                                snapshot.data!.city!,
                                                style: TextStyle(fontSize: 18),
                                                overflow: TextOverflow.fade,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //
                                    SizedBox(
                                      height: 65,
                                    ),
                                    // CONTACT
                                    Text(
                                      "Other contacts",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "+39 347 4567890", // TODO: post!.bio!,
                                      style: TextStyle(fontSize: 18),
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // WHILE WAITING USER DATA
                              return CupertinoActivityIndicator(
                                  animating: false, radius: 20);
                            })),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  // LOG OUT
  Widget buildLogOut(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: favorColors.IntroBg,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(90),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: CupertinoButton(
          key: Key("log_out_button"),
          child: Text("Log Out"),
          onPressed: (() {
            Provider.of<AppProvider>(context, listen: false)
                .signout(context: context);
          })),
    );
  }
}
