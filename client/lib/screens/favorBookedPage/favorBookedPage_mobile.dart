import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/services/apis/google_calendar_api_wrapper.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/starsWidget.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/favorTime.dart' as favorTime;

class favorBookedPage_Screen_M extends StatelessWidget {
  favorBookedPage_Screen_M({
    super.key,
    required this.bookedFavor,
  });

  BookedFavor? bookedFavor;

  Post post = CallerPost(
      id: "id",
      creatorId: "creatorId",
      createdAt: "createdAt",
      name: "name",
      surname: "surname",
      profilePicture: null,
      userType: "userType",
      taskCategory: "taskCategory",
      location: "location",
      favorStartTime: DateTime.now(),
      description: "description",
      averageRatings: 2,
      rankingPosition: 1,
      rankingLocation: "rankingLocation",
      bio: "bio");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        margin: EdgeInsets.all(9),
        padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
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
        child: favorInformationPage_favor_M(post: post),
      ),
      CustomCard(
        child: favorInformationPage_person_M(post: post),
      ),
      Container(
        margin: EdgeInsets.all(9),
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
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
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Responsive.width(12, context),
                      width: 230,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        color: favorColors.PrimaryBlue,
                        borderRadius: BorderRadius.circular(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Icon(CupertinoIcons.check_mark),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text('Mark as Completed'),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          print('Pressed: _MarkAsCompletedButton');
                          //TODO:
                        },
                      ),
                    ),
                    Container(
                      height: Responsive.width(12, context),
                      width: 125,
                      child: CupertinoButton(
                        padding: EdgeInsets.all(0),
                        color: favorColors
                            .PrimaryBlue, //Color.fromARGB(255, 64, 129, 236),
                        borderRadius: BorderRadius.circular(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Icon(CupertinoIcons.chat_bubble_2),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text('Chat'),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          print('Pressed: _chatButton');
                          //TODO:
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
      Consumer<UserProvider>(
        builder: (context, myProvider, child) {
          if (myProvider.getGoogleClient() != null) {
            return AddToGoogleCalendarButton(post: post);
          } else
            return Container();
        },
      ),
    ]));
  }
}

class favorInformationPage_favor_M extends StatelessWidget {
  favorInformationPage_favor_M({
    super.key,
    required this.post,
  });

  Post? post;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            //HEADING
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
            //INFORMATION
            Container(
              width: Responsive.width(90, context),
              child: Text(
                post!.description,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
                overflow: TextOverflow.fade,
              ),
            ),
            Divider(
              height: Responsive.height(1, context),
              color: Colors.transparent,
            ),
            // TIME
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      CupertinoIcons.time,
                      color: favorColors.PrimaryBlue,
                      size: 24, //
                    ),
                  ),
                  Container(
                    child: Text(
                      (post is CallerPost)
                          ? "${favorTime.formatter.format(post!.getFavorStartTime())}"
                          : "${favorTime.formatter.format(post!.getAvailabilityStartTime())} - ${favorTime.formatter.format(post!.getAvailabilityEndTime())}",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: favorColors.PrimaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: Responsive.height(0, context),
              color: Colors.transparent,
            ),
            // LOCATION
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0), // 8
                    child: Container(
                      child: Text(
                        post!.location,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 15,
                          color: favorColors.PrimaryBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: Responsive.height(1, context),
              color: Colors.transparent,
            ),
            // MAP
            // TODO: substitute with an interactive map
            Container(
              width: Responsive.width(100, context),
              height: Responsive.width(40, context),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/Mappa_Milano.jpg"),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: favorColors.LightGrey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }
}

class favorInformationPage_person_M extends StatelessWidget {
  favorInformationPage_person_M({
    super.key,
    required this.post,
  });

  Post post;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                // IMAGE
                Container(
                  width: Responsive.width(25, context),
                  height: Responsive.width(25, context),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/chris.jpg"),
                      //image: image, TODO: post!.profilePicture
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
                // PERSONAL...
                Container(
                  padding: EdgeInsets.only(
                    left: Responsive.width(5, context),
                  ),
                  constraints:
                      BoxConstraints(minHeight: Responsive.width(25, context)),
                  width: Responsive.width(65, context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAME AND SURNAME
                      Text(
                        "${post.name} ${post.surname}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      // ROLE
                      Text(
                        post.userType,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: favorColors.SecondaryBlue),
                        textAlign: TextAlign.left,
                      ),
                      Divider(
                        height: Responsive.height(1.5, context),
                        color: Colors.transparent,
                      ),
                      // RANK
                      Text(
                        "${post.rankingPosition} in ${post.rankingLocation}",
                        style: TextStyle(fontSize: 14),
                      ),
                      Divider(
                        height: Responsive.height(0.5, context),
                        color: Colors.transparent,
                      ),
                      // STARS
                      StarsWidget(number: post.averageRatings),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: Responsive.height(1, context),
              color: Colors.transparent,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // BIO
                Container(
                  width: Responsive.width(65, context),
                  padding: EdgeInsets.only(left: Responsive.width(5, context)),
                  child: Align(
                    child: Text(
                      post.bio!,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddToGoogleCalendarButton extends StatelessWidget {
  final Post post;

  AddToGoogleCalendarButton({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(9),
      child: SafeArea(
        child: Center(
          child: // CALENDAR BUTTON
              Container(
            width: MediaQuery.of(context).size.width,
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
              color:
                  favorColors.PrimaryBlue, //Color.fromARGB(255, 64, 129, 236),
              borderRadius: BorderRadius.circular(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Icon(CupertinoIcons.add),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Add to Google Calendar'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Image(
                      image: AssetImage(
                          "assets/images/google/google_calendar_logo.png"),
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                print('Pressed: _calendarButton');
                await GoogleCalendarApiWrapper().insertEventInGoogleCalendar(
                  context,
                  post.taskCategory,
                  post.location,
                  post.getFavorStartTime(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
