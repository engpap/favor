import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/models/post.dart';
import 'globals.dart' as globals;

class favorInformationPage_Screen_T extends StatelessWidget {
  favorInformationPage_Screen_T({
    super.key,
    required this.post,  
  });

  Post? post;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT SCREEN
        SingleChildScrollView(
          reverse: true,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.fixedWidth(),),
            child: Column(
              children: [
                Text(post!.taskCategory), //DELETE
                // FAVOR INFORMATION
                Container(
                  margin: EdgeInsets.all(9),
                  padding: EdgeInsets.only(left:18, right:18, top:9, bottom: 9), 
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
                      Divider(height: Responsive.height(2, context), color: Colors.transparent,),
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
                              padding: const EdgeInsets.only(left: 30.0),
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
                    ],
                  )
                ),
                // PERSONAL INFORMATION
                Container(
                  margin: EdgeInsets.all(9),
                  padding: EdgeInsets.only(left:18, right:18, top:9, bottom: 9),
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
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // IMAGE
                            Container(
                              width: Responsive.width(10, context), 
                              height: Responsive.width(10, context), 
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
                            // PERSONAL INFO
                            Container(
                              //color: Colors.blueAccent,
                              padding: EdgeInsets.only(left: Responsive.width(1, context),),
                              constraints: BoxConstraints(
                                minHeight: Responsive.width(10, context)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // NAME AND SURNAME
                                  Text("${globals.personName}", 
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
                                    textAlign: TextAlign.left,
                                  ),
                                  // role
                                  Text("${globals.personRole}", 
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: favorColors.SecondaryBlue), 
                                    textAlign: TextAlign.left,
                                  ),
                                  
                                  Divider(height: Responsive.height(1.5, context), color: Colors.transparent,),
                                  Text("${globals.personRating} RATINGS", 
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
                        // INFORMATION
                        Container(
                          //color: Colors.pink,
                          width: Responsive.width(65, context),
                          child: Align(
                            child: Text("${globals.informationPerson}", 
                              style: TextStyle(fontSize: 18), textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Divider(height: Responsive.height(2, context), color: Colors.transparent,),
                        // ROW OF 2 BUTTONS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // CHAT BUTTON
                            Column(
                              children: [
                                Container(
                                  child: Align(
                                    child: Container(
                                      width: Responsive.width(6, context), 
                                      height: Responsive.width(6, context), 
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
                                Divider(height: Responsive.height(0.5, context), color: Colors.transparent,),
                                Text("chat", style: TextStyle(fontSize: 14, ),),
                              ],
                            ),
                            // BOOK BUTTON
                            Column(
                              children: [
                                Container(
                                  child: Align(
                                    child: Container(
                                      width: Responsive.width(6, context), 
                                      height: Responsive.width(6, context),
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
                                        child: Icon(CupertinoIcons.bookmark),
                                        onPressed: () {
                                          print('Pressed: _bookButton');
                                          //TODO: add server function and client response      
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(height: Responsive.height(0.5, context), color: Colors.transparent,),
                                Text("book", style: TextStyle(fontSize: 14, ),),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// RIGHT SCREEN
        // MAP
        // TODO: substitute with an interactive map
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            margin: EdgeInsets.all(9),
            height: Responsive.height(90, context),
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
        ),
      ],
    );
  }
}

