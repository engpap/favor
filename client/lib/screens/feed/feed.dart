import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/feed/feed_mobile.dart';
import 'package:project/screens/feed/feed_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';

import '../favorInformationPage/globals.dart' as globals_fip;


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
                tabletBody: Feed_Screen_T(),
              ),
            )));
  }
}


class FavorCategoryWidget extends StatelessWidget {
  const FavorCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // IMAGE
        Container(
          width: Responsive.width(25, context),
          height: Responsive.width(25, context),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage("assets/images/bg_music_01.jpg"),
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
        Divider(height: Responsive.height(0.5, context), color: Colors.transparent,),
        Text("${1} favor", 
          style: TextStyle(fontSize: 16),),
      ],
    );
  }
}

class FavorReccomendationWidget extends StatelessWidget {
  FavorReccomendationWidget({super.key});

  //TODO: renderle variabili di input
  String heading = globals_fip.heading;
  String area = globals_fip.area;
  String information = globals_fip.information;
  String time = "${globals_fip.formatter.format(globals_fip.startTime)} - ${globals_fip.formatter.format(globals_fip.endTime)}";

  String personImage = "assets/images/chris.jpg";
  String personName = globals_fip.headingPerson;
  String personRole = globals_fip.rolePerson;
  String personRating = "${globals_fip.totalRatings} RATINGS";
  List <Color> starsColor = globals_fip.starsColor;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      customHeight: 64,
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
                    child: Text("${heading}", 
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: favorColors.PrimaryBlue,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Divider(height: Responsive.height(1, context), color: Colors.transparent,),
                  // AREA
                  Container(
                    child: Container(
                      //color: Colors.amber,
                      child: Text("${area}",
                      style: TextStyle(
                        fontSize: 16,
                        color: favorColors.PrimaryBlue,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ), 
                    ),
                  ),
                  Divider(height: Responsive.height(1, context), color: Colors.transparent,),
                  //INFORMATION
                  Container(
                    //color: Colors.pink,
                    child: Text("${information}", 
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Divider(height: Responsive.height(2, context), color: Colors.transparent,),
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
                          child: Text("${time}",
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
                        image: AssetImage(personImage),
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
                  // Name
                  Container(
                    child: Text(personName, 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // ROLE
                  Container(
                    child: Text(personRole, 
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: favorColors.SecondaryBlue
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Divider(height: Responsive.height(1, context), color: Colors.transparent,),
                  // RATING
                  Container( 
                    child: Text(personRating, 
                      style: TextStyle(
                        fontSize: 14,

                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // STARS
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 18, color: starsColor[0]),
                      Icon(Icons.star, size: 18, color: starsColor[1]),
                      Icon(Icons.star, size: 18, color: starsColor[2]),
                      Icon(Icons.star, size: 18, color: starsColor[3]),
                      Icon(Icons.star, size: 18, color: starsColor[4]),
                    ],
                  ),
                  Divider(height: Responsive.height(1, context), color: Colors.transparent,),
                  // MORE BUTTON
                  Container(
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
                      padding: EdgeInsets.all(9),
                      color: favorColors.PrimaryBlue,
                      borderRadius: BorderRadius.circular(90),
                      child: Text("More"),
                      onPressed: () {
                        print('Pressed: _moreButton');
                        //TODO: add server function and client response 
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const favorInformationPage_Screen()),
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

// TODO: REMOVE
/*
class FavorReccomendationWidget extends StatelessWidget {
  const FavorReccomendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // IMAGE
        Container(
          width: Responsive.width(100, context),
          height: Responsive.width(35, context),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage("assets/images/bg_music_01.jpg"),
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
        Divider(height: Responsive.height(0.5, context), color: Colors.transparent,),
        Text("${1} favor", 
          style: TextStyle(fontSize: 16),),
      ],
    );
  }
}
*/

