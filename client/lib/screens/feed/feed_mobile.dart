import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/feed/feed.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'globals.dart' as globals;

class Feed_Screen_M extends StatelessWidget {
  const Feed_Screen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Carosel_FavorCategoryWidget();
  }
}

class Carosel_FavorCategoryWidget extends StatelessWidget {
  const Carosel_FavorCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.width(45, context),
      margin: EdgeInsets.all(9),
      padding: EdgeInsets.only(top:9, bottom: 9),
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
            
      //width: Responsive.width(100, context),
      // CATEGORY LIST (scrollable horizontaly)
      child: Column(
        children: [
          //HEADING
          Container(
            width: Responsive.width(100, context),
            padding: EdgeInsets.only(right: 9, left: 9),
            //height: 20,
            child: Text("${globals.categoryListHeading}", 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                color: favorColors.PrimaryBlue,),
              textAlign: TextAlign.left,
            ),
          ),
          Divider(height: Responsive.height(1, context), color: Colors.transparent,),
          //ELEMENTS
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                //TODO: passare quali widget diplayare
                FavorCategoryWidget(),
                FavorCategoryWidget(),
                FavorCategoryWidget(),
                FavorCategoryWidget(),
                FavorCategoryWidget(),
                FavorCategoryWidget(),
              ]
            ),
          ),
        ],
      ),
    );
  }
}