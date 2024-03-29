import 'package:flutter/cupertino.dart';
import 'package:project/screens/explore/explore_mobile.dart';
import 'package:project/screens/responsiveLayout.dart';

class Explore_Screen extends StatelessWidget {
  const Explore_Screen({super.key});

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
            child: SafeArea(
          child: ResponsiveLayout(
            mobileBody: Explore_Screen_M(),
            tabletBody: Explore_Screen_M(),
          ),
        )));
  }
}
