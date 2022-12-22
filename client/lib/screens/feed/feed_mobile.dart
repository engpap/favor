import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/screens/components/customCard.dart';
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
    return Column(
      children: [
        // FAVOR CATEGORIES
        CustomCard(
          customHeight: 45,
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
        ),
        
        // FAVOR RECOMMENDATIONS
        CustomCard(
          customHeight: 100,
          // RECOMMENDATION LIST (scrollable vertically) 
          child: Column(
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 9, left: 9),
                //height: 20,
                child: Text("${globals.reccomendationListHeading}", 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,),
                  textAlign: TextAlign.left,
                ),
              ),
              Divider(height: Responsive.height(1, context), color: Colors.transparent,),
              //ELEMENTS
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    //TODO: passare quali widget diplayare
                    FavorReccomendationWidget(),
                    FavorReccomendationWidget(),
                    FavorReccomendationWidget(),
                    FavorReccomendationWidget(),
                    FavorReccomendationWidget(),
                    FavorReccomendationWidget(),
                  ]
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}