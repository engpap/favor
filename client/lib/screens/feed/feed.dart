import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/starsWidget.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/feed/feed_mobile.dart';
import 'package:project/screens/feed/feed_tablet.dart';
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
    required this.categoryImage,
    required this.categoryName,
  });

  //TODO: change assets with network image
  String categoryImage;
  String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          // IMAGE
          Container(
            width: Responsive.width(25, context),
            height: Responsive.width(25, context),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                //TODO: change assets with network image
                image: AssetImage(categoryImage),
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
          Text(
            categoryName,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class FavorReccomendationWidget extends StatelessWidget {
  FavorReccomendationWidget({
    super.key,
    required this.post,
  });

  Post? post;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      customHeight: 59,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FAVOR INFORMATION
          SizedBox(
            width: Responsive.width(55, context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //HEADING
                  Container(
                    child: Text(
                      post!.taskCategory,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: favorColors.PrimaryBlue,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Divider(
                    height: Responsive.height(1, context),
                    color: Colors.transparent,
                  ),
                  // AREA
                  Container(
                    child: Container(
                      //color: Colors.amber,
                      child: Text(
                        post!.location,
                        style: TextStyle(
                          fontSize: 16,
                          color: favorColors.PrimaryBlue,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Divider(
                    height: Responsive.height(1, context),
                    color: Colors.transparent,
                  ),
                  //INFORMATION
                  Container(
                    //color: Colors.pink,
                    child: Text(
                      post!.description,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Divider(
                    height: Responsive.height(2, context),
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
                            CupertinoIcons.time_solid,
                            color: favorColors.PrimaryBlue,
                            size: 24, //
                          ),
                        ),
                        //actual time
                        Container(
                          child: Text(
                            (post is CallerPost)
                              ? "${favorTime.formatter.format(post!.getFavorStartTime())}"
                              : "${favorTime.formatter.format(post!.getAvailabilityStartTime())} - ${favorTime.formatter.format(post!.getAvailabilityEndTime())}",
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
                ],
              ),
            ),
          ),

          // Person Information
          SizedBox(
            width: Responsive.width(33, context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // IMAGE
                  Container(
                    width: Responsive.width(20, context),
                    height: Responsive.width(20, context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/chris.jpg"),
                        //image: image, TODO: post!.profilePicture
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: favorColors.LightGrey,
                        width: 2.0,
                      ),
                      //borderRadius: BorderRadius.circular(10),
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
                  // Name and Surname
                  Container(
                    child: Text(
                      "${post!.name} ${post!.surname}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
                  Divider(
                    height: Responsive.height(1, context),
                    color: Colors.transparent,
                  ),
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
                  // STARS
                  StarsWidget(number: post!.averageStars),
                  Divider(
                    height: Responsive.height(1, context),
                    color: Colors.transparent,
                  ),
                  // MORE BUTTON
                  Container(
                    height: 26,
                    width: Responsive.width(100, context),
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
                        "More   >",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        print('Pressed: _moreButton');
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => favorInformationPage_Screen(post: post,)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FavorBookedWidget extends StatelessWidget {
  FavorBookedWidget({
    super.key,
    required this.categoryImage,
    required this.categoryName,
    //required this.post,
  });

  //TODO: change assets with network image
  String categoryImage; 
  String categoryName;
  //Post? post;
  String fieldsName = "IO ZONO IO";
  String personStatus = "provider";
  String time = "18.00";


  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomCard_2(
        child: Container(
          width: Responsive.width(45, context),
          height: Responsive.width(21, context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              Container(
                width: Responsive.width(10, context),
                height: Responsive.width(10, context),
                decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  //TODO: change assets with network image
                  image: AssetImage(categoryImage),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
                border: Border.all(
                  color: favorColors.LightGrey,
                  width: 2.0,
                ),
                //borderRadius: BorderRadius.circular(10),
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
              // FIELDS
              Container(
                width: Responsive.width(30, context),
                child: Column(
                  children: [
                    Text(categoryName),
                    Text(fieldsName),
                    Text(personStatus),
                    Text(time),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
