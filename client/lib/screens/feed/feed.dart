import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customCard.dart';
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
              image: AssetImage("assets/images/chris.jpg"),
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
  const FavorReccomendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      customHeight: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Favor Information
          Column(
            children: [
              //HEADING
              SizedBox(
                //width: Responsive.width(100, context),
                child: Text("${globals_fip.heading}", 
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,),
                  textAlign: TextAlign.left,
                ),
              ),
              Divider(height: Responsive.height(1, context), color: Colors.transparent,),
              Text("area"),
              Divider(height: Responsive.height(1, context), color: Colors.transparent,),
              //INFORMATION
              SizedBox(
                width: Responsive.width(40, context),
                child: Flexible(
                  child: Text("${globals_fip.information}", 
                    style: TextStyle(fontSize: 14), textAlign: TextAlign.left,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Text("time"),
            ],
          ),
          // Person Information
          CustomCard(
            customHeight: 100,
            child: Column(
              children: [
                Text("Image"),
                Text("name"),
                Text("score"),
                Text("buttonbuttonbutton"),
              ],
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

