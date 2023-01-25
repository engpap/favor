import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/responsive.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/starsWidget.dart';
import 'package:project/screens/favorBookedPage/favorBookedPage.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/feed/feed_mobile.dart';
import 'package:project/screens/feed/feed_tablet.dart';
import 'package:project/screens/feed/feed_utilities.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/favorTime.dart' as favorTime;

class Feed_Screen extends StatelessWidget {
  const Feed_Screen({super.key});

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
            //backgroundColor: favorColors.IntroBg,
            child: SafeArea(
          child: ResponsiveLeayout(
            mobileBody: Feed_Screen_M(),
            tabletBody: Feed_Screen_M(),
          ),
        )));
  }
}

class FavorCategoryWidget extends StatelessWidget {
  FavorCategoryWidget({
    super.key,
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // IMAGE
          Container(
            height: Responsive.heightFixOver(80, 22, context),
            width: Responsive.heightFixOver(80, 22, context),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: FeedUtilities.getFavorCategoryImage(categoryName),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                color: favorColors.LightGrey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
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
          Divider(
            height: Responsive.height(0.5, context),
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class FavorWidget extends StatelessWidget {
  FavorWidget({
    super.key,
    required this.post,
  });

  Post? post;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      customWidth: Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1st ROW - HEADING
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/chris.jpg"),
                    //image: post!.profilePicture!.image,
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: favorColors.LightGrey,
                    width: 1.0,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAME + SURNAME
                  Container(
                    child: Text(
                      "${post!.name} ${post!.surname}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                          color: favorColors.PrimaryBlue),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      // ROLE
                      Container(
                        child: Text(
                          post!.userType,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: favorColors.SecondaryBlue),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 5,),
                      // STARS
                      StarsWidget(number: post!.averageRatings, size: 12,),
                    ],
                  ),
                  
                ],
              ),
              // to fill the space in between
              Expanded(child: Container()),
              // TASK CATEGORY
              Container(
                padding: EdgeInsets.only(right: 9),
                child: Text(
                  post!.taskCategory,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // 2nd ROW - favor's description
          SizedBox(height: 10,),
          // DESCRIPTION
          Container(
            padding: EdgeInsets.only(left: 51, right: 9),
            child: Text(
              post!.description,
              style: TextStyle(
                fontSize: 18,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // 3rd ROW - favor's time
          SizedBox(height: 10,),
          // TIME
          Container(
            padding: EdgeInsets.only(right: 9, left: 9),
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
                    //scolor: favorColors.PrimaryBlue,
                    size: 24, //
                  ),
                ),
                SizedBox(width: 8,),
                // VALUE
                Container(
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
              ],
            ),
          ),
          // 4th ROW - favor's location
          SizedBox(height: 10,),
          // LOCATION
          Container(
            padding: EdgeInsets.only(right: 9, left: 9),
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
                SizedBox(width: 8,),
                // VALUE
                  Container(
                    child: Container(
                      child: Text(
                        post!.location,
                        style: TextStyle(
                          fontSize: 15,
                          color:Colors.black45,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // 5th ROW - more button
          SizedBox(height: 10,),
          Row(
            children: [
              // MORE BUTTON
              Container(
                padding: EdgeInsets.only(left: 45),
                height: 32,
                width: 200,
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
                  child: Text(
                    "More...",
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    print('Pressed: _moreButton');
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => favorInformationPage_Screen(
                                post: post,
                              )),
                    );
                  },
                ),
              ),
              // to fill the space in between
              Expanded(child: Container()),
            ],
          ),
          SizedBox(height: 10,),
          /**
          // RANK
          Container(
            child: Text(
              "${post!.rankingPosition} in ${post!.rankingLocation}",
              style: TextStyle(
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          */
        ],
      ),
    );
  }
}

class BookedFavorWidget extends StatelessWidget {
  BookedFavorWidget({
    super.key,
    required this.categoryName,
    required this.booked,
  });

  //TODO: change assets with network image
  String categoryName;

  String time = "18.00";

  BookedFavor booked;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomCard(
        padding: EdgeInsets.all(0),
        //margin: EdgeInsets.all(0),
        child: Container(
          //color: Colors.pink,
          width: Responsive.width(50, context),
          //height: Responsive.width(10, context),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(favorColors.IntroBg),
                foregroundColor:
                    MaterialStateProperty.all<Color>(favorColors.PrimaryBlue),
                overlayColor:
                    MaterialStateProperty.all<Color>(favorColors.SecondaryBlue),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
              ),
              onPressed: () {
                // TODO: AGGIUNGERE PUSH AD UNA NUOVA PAGINA ***
                print('Pressed: BookedFavor');
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => favorBookedPage_Screen(
                            bookedFavor: BOOKED, //TODO: cambiare riferimento
                          )),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  SizedBox(
                    width: Responsive.width(20, context),
                    height: Responsive.width(100, context),
                    child: Container(
                      width: Responsive.width(100, context),
                      //height: Responsive.width(100, context),
                      decoration: BoxDecoration(
                        //color: Colors.amber,
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          //TODO: change assets with network image
                          image:
                              FeedUtilities.getFavorCategoryImage(categoryName),
                          fit: BoxFit.cover,
                          opacity: 0.1,
                        ),
                        border: Border.all(
                          color: favorColors.LightGrey,
                          width: 0.0,
                        ),
                        //borderRadius: BorderRadius.circular(10),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
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
                  // FIELDS
                  Container(
                    //color: Colors.green,
                    width: Responsive.width(29, context),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // NAME SURNAME
                          Text(
                            '${booked.post.name} ${booked.post.surname}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // TASK CATEGORY
                          Text(
                            categoryName, // Text(booked.post.taskCategory,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                                //icon clock
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    CupertinoIcons.time,
                                    color: favorColors.PrimaryBlue,
                                    size: 24, //
                                  ),
                                ),
                                //actual time
                                Container(
                                  child: Text(
                                    Utilities.getHoursAndMinutes(
                                        booked.bookedAt),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: favorColors.PrimaryBlue,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: APPENA POSSIBILE REMOVE THIS
BookedFavor BOOKED = new BookedFavor(
    id: "id",
    bookedAt: DateTime(0),
    providerId: "providerId",
    callerId: "callerId",
    post: new CallerPost(
        id: "id",
        creatorId: "creatorId",
        createdAt: "createdAt",
        name: "name",
        surname: "surname",
        profilePicture: null,
        userType: "userType",
        taskCategory: "taskCategory",
        location: "location",
        favorStartTime: DateTime(0),
        description: "description",
        averageRatings: 2,
        rankingPosition: 1,
        rankingLocation: "rankingLocation",
        bio: "bio"));

// SEARCH BAR TODO: serve o va rimossa?
class SearchFavor extends StatelessWidget {
  SearchFavor({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9, right: 9),
      height: Responsive.height(1, context),
      child: CupertinoTextField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: favorColors.PrimaryBlue,
        ),
        //textInputAction: widget.textInputAction, //widget
        //keyboardType: widget.textInputType, //widget
        padding: EdgeInsets.only(top: 9, bottom: 9),
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
        cursorColor: favorColors.SecondaryBlue,
        cursorWidth: 2,
        cursorRadius: Radius.circular(10),
        // prefix button
        prefix: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.search,
            color: favorColors.PrimaryBlue,
          ),
          onPressed: null,
        ),
        // clear button
        suffix: CupertinoButton(
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          child: Icon(
            CupertinoIcons.xmark_circle_fill,
            color: favorColors.Yellow.withOpacity(0.8),
          ),
          onPressed: () => textController.clear(),
        ),
        maxLength: 30, // reasonable value
        maxLines: 1, // reasonable value
        placeholder: "Search favor",
        placeholderStyle: TextStyle(
          color: favorColors.SecondaryBlue,
          fontWeight: FontWeight.normal,
        ),
        controller: textController,
        onSubmitted: (value) => print('Submitted [${textController}]: $value'),
      ),
    );
  }
}
