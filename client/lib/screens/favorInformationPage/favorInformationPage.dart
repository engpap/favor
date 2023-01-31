import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/models/post.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage_mobile.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage_tablet.dart';
import 'package:project/screens/milan.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/screens/components/starsWidget.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/favorTime.dart' as favorTime;
import 'package:provider/provider.dart';

class FavorInformationPageScreen extends StatelessWidget {
  FavorInformationPageScreen({
    super.key,
    required this.post,
    required this.userType,
  });

  Post? post;
  String userType;

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
              child: ResponsiveLayout(
                mobileBody: favorInformationPage_Screen_M(
                    post: post, userType: userType),
                tabletBody: favorInformationPage_Screen_T(
                    post: post, userType: userType),
              ),
            )));
  }
}

class FavorInformation extends StatelessWidget {
  FavorInformation({
    super.key,
    required this.post,
  });

  Post? post;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key("favor_information"),
      children: [
        // HEADING - TASKCATEGORY
        SizedBox(
          width: Responsive.width(100, context),
          child: Text(
            post!.taskCategory,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: favorColors.PrimaryBlue,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),
        // DESCRIPTION
        Container(
          width: Responsive.width(90, context),
          child: Text(
            post!.description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
            overflow: TextOverflow.fade,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // TIME
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ICON
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  CupertinoIcons.time,
                  color: Colors.black45,
                  size: 24, //
                ),
              ),
              SizedBox(
                width: 8,
              ),
              // VALUE
              Expanded(
                child: Container(
                  child: Text(
                    (post is CallerPost)
                        ? "From: ${favorTime.formatter.format(post!.getFavorStartTime())}"
                        : "From: ${favorTime.formatter.format(post!.getAvailabilityStartTime())}\nTo: ${favorTime.formatter.format(post!.getAvailabilityEndTime())}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // LOCATION
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ICON
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.black45,
                  //scolor: favorColors.PrimaryBlue,
                  size: 24, //
                ),
              ),
              SizedBox(
                width: 8,
              ),
              // VALUE
              Container(
                child: Container(
                  child: Text(
                    post!.location,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FavorPerson extends StatelessWidget {
  FavorPerson({
    super.key,
    required this.post,
  });

  Post? post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1st ROW - HEADING
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Expanded(
              child: Container(
                width: Responsive.widthFixOver(80, 20, context),
                height: Responsive.widthFixOver(80, 20, context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    //image: AssetImage("assets/images/chris.jpg"),
                    image: post!.profilePicture!.image,
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
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME AND SURNAME
                Text(
                  "${post!.name} ${post!.surname}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                  textAlign: TextAlign.left,
                ),
                // ROLE
                Text(
                  post!.userType,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: favorColors.SecondaryBlue),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                // STARS
                StarsWidget(number: post!.averageRatings),
                SizedBox(
                  height: 5,
                ),
                // RANK
                post!.rankingPosition != 0
                    ? Text(
                        "Ranked as ${post!.rankingPosition}º in ${post!.rankingLocation}",
                        style: TextStyle(
                            fontSize: 14, overflow: TextOverflow.clip),
                      )
                    : Text(
                        "Never done a favor in ${post!.rankingLocation}",
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.clip,
                      )
              ],
            ),
          ],
        ),
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),
        // 2nd ROW - BIO
        Container(
          width: Responsive.width(90, context),
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bio",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                post!.bio!,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),
        // 3rd ROW - CONTACT
        Container(
          width: Responsive.width(90, context),
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                post!.email!,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.fade,
              ),
              Text(
                "+39 347 4567890", // TODO: post!.bio!,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FavorBook extends StatelessWidget {
  FavorBook({
    super.key,
    required this.post,
    required this.userType,
  });

  Post? post;
  String userType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9, right: 9),
      width: Responsive.widthFixOver(350, 70, context),
      height: Responsive.widthFixOver(45, 15, context),
      child: CupertinoButton(
        key: Key("book_it_button"),
        padding: EdgeInsets.all(0),
        color: favorColors.PrimaryBlue,
        borderRadius: BorderRadius.circular(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Icon(CupertinoIcons.bookmark),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 30),
                alignment: Alignment.center,
                child: Text(
                  'Book it',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          print('Pressed: _bookButton');
          Provider.of<AppProvider>(context, listen: false)
              .bookFavor(context: context, post: post, userType: userType);
        },
      ),
    );
  }

  // TODO: NOT USED - but don't remove yet
  Widget chatButton(BuildContext context) {
    return Column(
      children: [
        // CHAT BUTTON
        Container(
          width: Responsive.width(25, context),
          child: Align(
            child: Container(
              width: Responsive.width(12, context),
              height: Responsive.width(12, context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
              child: CupertinoButton(
                padding: EdgeInsets.all(0),
                color: favorColors.PrimaryBlue,
                borderRadius: BorderRadius.circular(90),
                child: Icon(CupertinoIcons.chat_bubble_2),
                onPressed: () {
                  print('Pressed: _chatButton');
                },
              ),
            ),
          ),
        ),
        Divider(
          height: Responsive.height(0.5, context),
          color: Colors.transparent,
        ),
        Text(
          "chat",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
