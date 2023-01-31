import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/components/starsWidget.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:provider/provider.dart';

class AccountScreen_M extends StatefulWidget {
  const AccountScreen_M({super.key});

  @override
  State<AccountScreen_M> createState() => _AccountScreen_MState();
}

class _AccountScreen_MState extends State<AccountScreen_M> {
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
            width: Responsive.widthFixOver(370, 100, context),
            padding: EdgeInsets.only(left: 8, right: 8),
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
                            key: Key("column_account_mobile"),
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // IMAGE
                              Container(
                                width:
                                    Responsive.widthFixOver(120, 30, context),
                                height:
                                    Responsive.widthFixOver(120, 30, context),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    //image: AssetImage("assets/images/chris.jpg"),
                                    image: Image.memory(
                                            snapshot.data!.profilePicture.bytes)
                                        .image,
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: favorColors.LightGrey,
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
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
                                "${snapshot.data!.name} ${snapshot.data!.surname}",
                                style: TextStyle(
                                  fontSize:
                                      Responsive.widthFixOver(30, 10, context),
                                  fontWeight: FontWeight.bold,
                                  color: favorColors.PrimaryBlue,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              // EMAIL
                              Text(
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
                                size: Responsive.widthFixOver(35, 10, context),
                              ),
                              //
                              SizedBox(
                                height: 35,
                              ),
                              // BIO
                              Text(
                                "My Bio",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
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
                                        snapshot.data!.age!.toString(),
                                        style: TextStyle(fontSize: 18),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ],
                                  )),
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
                                "+39 347 4567890", // TODO: post!.phone!
                                style: TextStyle(fontSize: 18),
                                overflow: TextOverflow.fade,
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
                  height: 45,
                ),
                // LOG OUT
                buildLogOut(context),
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
          color: favorColors.PrimaryBlue,
          child: Text(
            "Log Out",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: (() {
            Provider.of<AppProvider>(context, listen: false)
                .signout(context: context);
          })),
    );
  }
}
