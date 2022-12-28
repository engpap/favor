import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';

import 'package:project/screens/components/starsWidget.dart';

import 'package:project/screens/leaderboard/leaderboard_mobile.dart';
import 'package:project/screens/leaderboard/leaderboard_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';

class Leaderboard_Screen extends StatelessWidget {
  const Leaderboard_Screen({super.key});

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
            mobileBody: Leaderboard_Screen_M(),
            tabletBody: Leaderboard_Screen_T(),
          ),
        )));
  }
}

class LeaderboardCard extends StatelessWidget {
  LeaderboardCard({
    super.key,
    this.personImage = "assets/images/default_profile_picture.jpg",
    required this.personName,
    required this.rankPosition,
    required this.starNumber,
  });

  String personName;
  String personImage;
  int rankPosition;
  double starNumber;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 4), //
        width: Responsive.width(90, context),
        height: 26,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          //color: providerStatus ? favorColors.PrimaryBlue : Colors.transparent,
          color: favorColors.IntroBg,
          borderRadius: BorderRadius.circular(90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // RANK
              
              (rankPosition < 4) 
              // Thropy
              ? Container(
                width: Responsive.width(5, context),
                decoration: BoxDecoration(
                  color: rankPosition == 1 ? Colors.amber : (rankPosition == 2 ? Colors.grey : Colors.brown),
                  shape: BoxShape.circle,
                 ),
                child: Icon(CupertinoIcons.wind_snow),
              )               
              // Number
              : Container(
                width: Responsive.width(5, context),
                //margin: EdgeInsets.only(left: 9),
                child: Text(
                  " ${rankPosition}",
                  style: TextStyle(
                    fontSize: 16,
                    color: favorColors.PrimaryBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // IMAGE
              Container(
                width: Responsive.width(10, context),
                height: Responsive.width(10, context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(personImage),
                    fit: BoxFit.contain,
                  ),
                  border: Border.all(
                    color: favorColors.LightGrey,
                    width: 2.0,
                  ),
                ),
              ),
              // NAME
              Container(
                width: Responsive.width(35, context),
                child: Text(
                  personName,
                  style: TextStyle(
                    fontSize: 16,
                    color: favorColors.PrimaryBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // STARS
              Container(
                child: StarsWidget(
                  size: 16,
                  number: starNumber,
                )
              ),
            ],
          ),
          onPressed: () {/** */},
        ),
      ),
    );
  }
}
