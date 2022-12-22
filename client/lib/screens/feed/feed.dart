import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/screens/feed/feed_mobile.dart';
import 'package:project/screens/feed/feed_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';


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

