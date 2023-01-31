import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/starsWidget.dart';
import 'package:project/screens/leaderboard/leaderboard_mobile.dart';
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
            backgroundColor: favorColors.IntroBg,
            child: SafeArea(
              child: ResponsiveLayout(
                mobileBody: Leaderboard_Screen_M(),
                tabletBody: Leaderboard_Screen_M(),
              ),
            )));
  }
}

class LeaderboardCard extends StatelessWidget {
  LeaderboardCard({
    super.key,
    required this.personImage,
    required this.personName,
    required this.personSurname,
    required this.leaderboardPosition,
    required this.starsNumber,
  });

  String personName;
  String personSurname;
  MemoryImage personImage;
  int leaderboardPosition;
  int? starsNumber;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        margin: EdgeInsets.only(left: 9, right: 9, top: 9), //
        width: Responsive.width(94, context),
        height: 60,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          color: favorColors.IntroBg,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // RANK
              (leaderboardPosition < 4)
                  // Thropy
                  ? Container(
                      width: Responsive.width(5, context),
                      decoration: BoxDecoration(
                        color: leaderboardPosition == 1
                            ? Colors.amber
                            : (leaderboardPosition == 2
                                ? Colors.grey
                                : Colors.brown),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(CupertinoIcons.wind_snow),
                    )
                  // Number
                  : Container(
                      width: Responsive.width(5, context),
                      child: Text(
                        " ${leaderboardPosition}",
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
                    image: personImage,
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
                  '${personName} ${personSurname}',
                  style: TextStyle(
                    fontSize: 18,
                    color: favorColors.PrimaryBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // STARS
              Container(
                  child: StarsWidget(
                size: 18,
                number: starsNumber,
              )),
            ],
          ),
          onPressed: () {/** */},
        ),
      ),
    );
  }
}
