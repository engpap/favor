import 'package:flutter/cupertino.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

import 'package:project/models/post.dart';

import 'package:project/screens/favorInformationPage/favorInformationPage_mobile.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';



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
