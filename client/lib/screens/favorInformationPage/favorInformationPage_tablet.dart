import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/responsive.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/starsWidget.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/favorTime.dart' as favorTime;
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';

class favorInformationPage_Screen_T extends StatelessWidget {
  favorInformationPage_Screen_T({
    super.key,
    required this.post,
    required this.userType,
  });

  Post? post;
  String userType;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT SCREEN
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
            ),
            child: Column(
              children: [
                // FAVOR INFORMATION
                CustomCard(child: FavorInformation(post: post)),
                // FAVOR PERSON
                CustomCard(child: FavorPerson(post: post),),
                // FAVOR BOOK
                FavorBook(post: post, userType: userType,),
              ],
            ),
          ),
        ),
        /// RIGHT SCREEN
        // MAP
        FavorMapTablet(post: post)
      ],
    );
  }
}

class FavorMapTablet extends StatelessWidget {
  FavorMapTablet({
    super.key,
    required this.post,
  });

  Post? post;
  @override
  Widget build(BuildContext context) {
    return 
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
              borderRadius: BorderRadius.circular(10)),
        ),
      );
  }
}