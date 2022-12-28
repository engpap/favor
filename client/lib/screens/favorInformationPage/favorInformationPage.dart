import 'package:flutter/cupertino.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

import 'package:project/models/post.dart';

import 'package:project/screens/favorInformationPage/favorInformationPage_mobile.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';

import '../favorInformationPage/globals.dart' as globals_fip;

class favorInformationPage_Screen extends StatelessWidget {
  favorInformationPage_Screen({super.key,
  required this.post,
 
  });

  Post? post;

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
                mobileBody: favorInformationPage_Screen_M(post: post),
                tabletBody: favorInformationPage_Screen_T(post: post),
              ),
            )));
  }
}

/*
Post postprova = new Post(
  id: "1",
  creatorId: "2",
  createdAt: "3",
);

class PostProvvisorio {
  String heading = globals_fip.heading; //ProviderPost.taskCategory
  String area = globals_fip.area; //ProviderPost.location
  String information = globals_fip.information; //ProviderPost.description

  String startTime = globals_fip.formatter.format(globals_fip.startTime); //ProviderPost.availabilityStartTime
  String endTime = globals_fip.formatter.format(globals_fip.endTime); //ProviderPost.availabilityEndTime

  String personImage = globals_fip.personImage; //TODO: 
  String personName = globals_fip.personName; //TODO:
  String personRole = globals_fip.personRole; //ProviderPost.userType
  String personRating = globals_fip.personRating; //posizione classifica TODO:
  List<Color> starsColor =  globals_fip.starsColor; //TODO:
}
*/