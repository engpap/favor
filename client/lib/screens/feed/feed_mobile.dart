import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/feed/feed.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'globals.dart' as globals;
import '../favorInformationPage/globals.dart' as globals_fip;

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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Divider(height: Responsive.height(1, context), color: Colors.transparent,),
        // FAVOR CATEGORIES
        Container(
          padding: EdgeInsets.only(left:8, right: 8),
          height: Responsive.height(20, context),
          // CATEGORY LIST (scrollable horizontaly) 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 9, left: 9),
                child: Text("${globals.categoryListHeading}", 
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Divider(height: Responsive.height(1, context), color: Colors.transparent,),
              //ELEMENTS
              Container(
                constraints: BoxConstraints(
                  maxHeight: Responsive.height(15, context)
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    //TODO: passare quali widget diplayare
                    FavorCategoryWidget(
                      categoryImage: "assets/images/bg_music_01.jpg",
                      categoryName: "Category 1",
                    ),
                    FavorCategoryWidget(
                      categoryImage: "assets/images/bg_music_02.jpg",
                      categoryName: "Category 2",
                    ),      
                    FavorCategoryWidget(
                      categoryImage: "assets/images/bg_music_01.jpg",
                      categoryName: "Category 3",
                    ),                    
                    FavorCategoryWidget(
                      categoryImage: "assets/images/bg_music_02.jpg",
                      categoryName: "Category 4",
                    ),                    
                    FavorCategoryWidget(
                      categoryImage: "assets/images/bg_music_02.jpg",
                      categoryName: "Category 5",
                    ),                    
                    FavorCategoryWidget(
                      categoryImage: "assets/images/bg_music_01.jpg",
                      categoryName: "Category 6",
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
        Divider(height: Responsive.height(1, context), color: Colors.transparent,),
        // FAVOR RECOMMENDATIONS
        Container(
          padding: EdgeInsets.only(left:8, right: 8),
          height: Responsive.height(50, context),
          // RECOMMENDATION LIST (scrollable vertically) 
          child: Column(
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 9, left: 9),
                child: Text("${globals.reccomendationListHeading}", 
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                ),
              ),
              Divider(height: Responsive.height(1, context), color: Colors.transparent,),
              //ELEMENTS
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    //TODO: passare quali widget diplayare
                    FavorReccomendationWidget(
                      heading: globals_fip.heading ,
                      area: globals_fip.area,
                      information: globals_fip.information,
                      startTime: globals_fip.formatter.format(globals_fip.startTime),
                      endTime: globals_fip.formatter.format(globals_fip.endTime),
                      personImage: globals_fip.personImage,
                      personName: globals_fip.personName,
                      personRole: globals_fip.personRole,
                      personRating: globals_fip.personRating,
                      starsColor: globals_fip.starsColor,
                    ),
                    /**
                       avorReccomendationWidget(
                        heading: ,
                        area: ,
                        information: ,
                        startTime: ,
                        endTime: ,
                        personImage: ,
                        personName: ,
                        personRole: ,
                        personRating: ,
                        starsColor: ,
                       ),
                    */
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