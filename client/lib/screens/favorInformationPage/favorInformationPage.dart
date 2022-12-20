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
    return Container(
      child: Column(
        children:[
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,
              ),
            ),
            Divider(height: Responsive.height(1, context), color: Colors.transparent,),
            //INFORMATION
            SizedBox(
              width: Responsive.width(100, context),
              child: Text("${globals.information}", 
                style: TextStyle(fontSize: 18), textAlign: TextAlign.left,
              ),
            ),

            Divider(height: Responsive.height(1, context), color: Colors.transparent,),
            // Time
            Row(
              children: [
                Icon(
                  CupertinoIcons.time, 
                  color: favorColors.PrimaryBlue,
                  size: 18, // 
                ),
                Column(
                  children: [
                    Text(" ${globals.formatter.format(globals.startTime)} - ${globals.formatter.format(globals.endTime)}"),
                  ],
                ),
              ],
            ),
            // Area
            Row(
              children: [
                Icon(
                  CupertinoIcons.location_solid, 
                  color: favorColors.PrimaryBlue,
                  size: 18, // 
                ),
                Column(
                  children: [
                    Text(" ${globals.area}"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class favorInformationPage_person extends StatelessWidget {
  const favorInformationPage_person({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                // STARS
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 15, color: globals.starsColor[0]),
                    Icon(Icons.star, size: 15, color: globals.starsColor[0]),
                    Icon(Icons.star, size: 15, color: globals.starsColor[0]),
                    Icon(Icons.star, size: 15, color: globals.starsColor[0]),
                    Icon(Icons.star, size: 15, color: globals.starsColor[0]),
                  ],
                )
              ],
            ),



            Container(
              padding: EdgeInsets.all(9),
              constraints: BoxConstraints(
                minHeight: Responsive.width(25, context)
              ),
              width: Responsive.width(63, context), // TODO: tablet more than 63
              
              // card look
              /**
              decoration: BoxDecoration(
                color: favorColors.IntroBg,
                border: Border.all(
                  color: favorColors.Yellow,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10),), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              */

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAME AND SURNAME
                  Text("${globals.headingPerson}", 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,
                  ),
                  Divider(height: Responsive.height(1, context), color: Colors.transparent,),
                  // INFORMATION
                  Text("${globals.informationPerson}", 
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.left,
                  ),
                  // CHAT BUTTON
                  Container(
                    constraints: BoxConstraints(
                      minHeight: Responsive.width(20, context)
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}