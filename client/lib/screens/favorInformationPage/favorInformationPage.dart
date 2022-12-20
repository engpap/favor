import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage_mobile.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'globals.dart' as globals;

class favorInformationPage_Screen extends StatelessWidget {
  const favorInformationPage_Screen({super.key});

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
                mobileBody: favorInformationPage_Screen_M(),
                //TODO do we need tablet?
                tabletBody: favorInformationPage_Screen_T(),
              ),
            )));
  }
}