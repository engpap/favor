import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'globals.dart' as globals;

class favorInformationPage_Screen extends StatelessWidget {
  const favorInformationPage_Screen({super.key});

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
              child: ResponsiveLeayout(
                mobileBody: favorInformationPage_Screen_M(),
                //TODO do we need tablet?
                tabletBody: favorInformationPage_Screen_M(),
              ),
            )));
  }
}

class favorInformationPage_Screen_M extends StatelessWidget {
  const favorInformationPage_Screen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:[
          Container(
            margin: EdgeInsets.all(9),
            padding: EdgeInsets.only(left:18, right:18, top:9, bottom: 9), //
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
            child: favorInformationPage_favor(),
          ),

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
            child: favorInformationPage_person(),
          ),


        ]
      ),
    );
  }
}


class favorInformationPage_favor extends StatelessWidget {
  const favorInformationPage_favor({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            //HEADING
            SizedBox(
              width: Responsive.width(100, context),
              child: Text("${globals.heading}", 
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,
                  color: favorColors.PrimaryBlue,),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(height: Responsive.height(1, context), color: Colors.transparent,),
            //INFORMATION
            SizedBox(
              width: Responsive.width(90, context),
              child: Flexible(
                child: Text("${globals.information}", 
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Divider(height: Responsive.height(1, context), color: Colors.transparent,),
            // TIME
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      CupertinoIcons.time_solid, 
                      color: favorColors.PrimaryBlue,
                      size: 24, // 
                    ),
                  ),
                  Flexible(
                    child: Text("${globals.formatter.format(globals.startTime)} - ${globals.formatter.format(globals.endTime)}",
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: favorColors.PrimaryBlue,
                    ),),
                  ),
                ],
              ),
            ),
            Divider(height: Responsive.height(0, context), color: Colors.transparent,),
            // AREA
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /** 
                  Icon(
                    CupertinoIcons.location_solid, 
                    color: favorColors.PrimaryBlue,
                    size: 24, // 
                  ),
                  */
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0), // 8
                    child: Flexible(
                      child: Text(" ${globals.area}",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 15,
                        color: favorColors.PrimaryBlue,
                      ),), 
                    ),
                  ),
                ],
              ),
            ),
            //** 
            Divider(height: Responsive.height(1, context), color: Colors.transparent,),
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
                    borderRadius: BorderRadius.circular(10)
                  ),
            ),
            //*/
          ],
        ),
      ),
    );
  }
}

/** 
class favorInformationPage_favor_T extends StatelessWidget {
  const favorInformationPage_favor_T({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            //HEADING
            SizedBox(
              width: Responsive.width(100, context),
              child: Text("${globals.heading}", 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,
              ),
            ),
            Divider(height: Responsive.height(1, context), color: Colors.transparent,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //INFORMATION - left
                SizedBox(
                  width: Responsive.width(50, context),
                  child: Text("${globals.information}", 
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.left,
                  ),
                ),
                // right
                Container(
                  padding: EdgeInsets.only(left: Responsive.width(5, context)),
                  width: Responsive.width(40, context),
                  child: Column(
                    children: [
                      // MAP
                      // TODO: substitute with an interactive map
                      Container(
                        width: Responsive.width(100, context) ,
                        child: Image.asset('assets/images/Mappa_Milano.jpg'),
                        decoration: BoxDecoration(
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

                      Divider(height: Responsive.height(1, context), color: Colors.transparent,),

                      // AREA
                      Container(
                        //width: Responsive.width(40, context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(" ${globals.area}",
                              overflow: TextOverflow.fade,),
                            ),
                            /** 
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                CupertinoIcons.location_solid, 
                                color: favorColors.PrimaryBlue,
                                size: 26, // 
                              ),
                            ),
                            */
                          ],
                        ),
                      ),
                      
                      Divider(height: Responsive.height(1, context), color: Colors.transparent,),

                      // TIME
                      Container(
                        //width: Responsive.width(90, context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text("${globals.formatter.format(globals.startTime)} - ${globals.formatter.format(globals.endTime)}",
                              overflow: TextOverflow.fade,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                CupertinoIcons.time_solid, 
                                color: favorColors.PrimaryBlue,
                                size: 24, // 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            /**
            Container(
              width: Responsive.width(20, context),
              color: Colors.green,
              child: Column(
                children: [
                  // IMAGE
                  Container(
                  // width: Responsive.width(25, context), // TODO: 15 tablet 25 phone
                    //height: Responsive.width(25, context), // TODO: 15 tablet 25 phone
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage(""),
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
                ],
              ),
            ),
             */

            /** 
            //INFORMATION
            SizedBox(
              width: Responsive.width(100, context),
              child: Text("${globals.information}", 
                style: TextStyle(fontSize: 18), textAlign: TextAlign.left,
              ),
            ),
            */

            Divider(height: Responsive.height(1, context), color: Colors.transparent,),

          ],
        ),
      ),
    );
  }
}
*/

class favorInformationPage_person extends StatelessWidget {
  const favorInformationPage_person({super.key});
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
                  width: Responsive.width(25, context), // TODO: 15 tablet 25 phone
                  height: Responsive.width(25, context), // TODO: 15 tablet 25 phone
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/chris.jpg"),
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
                Container(
                  //color: Colors.blueAccent,
                  padding: EdgeInsets.only(left: Responsive.width(5, context),),
                  constraints: BoxConstraints(
                    minHeight: Responsive.width(25, context)
                  ),
                  width: Responsive.width(65, context), // TODO: tablet more than 63
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // NAME AND SURNAME
                      Text("${globals.headingPerson}", 
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
                        textAlign: TextAlign.left,
                      ),
                      // role
                      Text("${globals.rolePerson}", 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: favorColors.SecondaryBlue), 
                        textAlign: TextAlign.left,
                      ),
                      
                      Divider(height: Responsive.height(1.5, context), color: Colors.transparent,),
                    Text("${globals.totalRatings} RATINGS", 
                      style: TextStyle(fontSize: 14),),
                    Divider(height: Responsive.height(0.5, context), color: Colors.transparent,),
                    // STARS
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, size: 18, color: globals.starsColor[0]),
                        Icon(Icons.star, size: 18, color: globals.starsColor[0]),
                        Icon(Icons.star, size: 18, color: globals.starsColor[0]),
                        Icon(Icons.star, size: 18, color: globals.starsColor[0]),
                        Icon(Icons.star, size: 18, color: globals.starsColor[0]),
                      ],
                    ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(height: Responsive.height(1, context), color: Colors.transparent,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // CHAT BUTTON
                Container(
                  //color: Colors.amber,
                  width: Responsive.width(25, context), // TODO: 15 tablet 25 phone
                  child: Align(
                    child: Container(
                      width: Responsive.width(12, context), //TODO: 12 phone, 6 tablet
                      height: Responsive.width(12, context), //TODO: 12 phone, 6 tablet
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
                          //TODO: add server function and client response      
                        },
                      ),
                    ),
                  ),
                ),
                // INFORMATION
                Container(
                  //constraints: BoxConstraints(minHeight: Responsive.height(25, context)),
                  //color: Colors.pink,
                  width: Responsive.width(65, context),
                  //height: ,
                  padding: EdgeInsets.only(left: Responsive.width(5, context)),
                  child: Align(
                    //alignment: Alignment.bottomCenter,
                    child: Text("${globals.informationPerson}", 
                      style: TextStyle(fontSize: 18), textAlign: TextAlign.start,
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