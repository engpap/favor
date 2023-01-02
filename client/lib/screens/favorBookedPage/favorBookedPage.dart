

import 'package:flutter/cupertino.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/models/bookedFavor.dart';

import 'package:project/models/post.dart';
import 'package:project/screens/favorBookedPage/favorBookedPage_mobile.dart';
import 'package:project/screens/favorBookedPage/favorBookedPage_tablet.dart';

import 'package:project/screens/responsiveLayout.dart';



class favorBookedPage_Screen extends StatelessWidget {
  favorBookedPage_Screen({super.key,
  required this.booked,
  });

  BookedFavor? booked;
  
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
                mobileBody: favorBookedPage_Screen_M(booked: booked),
                tabletBody: favorBookedPage_Screen_T(booked: booked),
              ),
            )));
  }
}