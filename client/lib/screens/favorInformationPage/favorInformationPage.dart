import 'package:flutter/cupertino.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/screens/favorInformationPage/favorInformationPage_mobile.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage_tablet.dart';
import 'package:project/screens/responsiveLayout.dart';


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
                tabletBody: favorInformationPage_Screen_T(),
              ),
            )));
  }
}