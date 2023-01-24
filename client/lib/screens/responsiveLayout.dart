import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ResponsiveLeayout extends StatelessWidget {
  // screen max width for a mobile app
  final int mobileMaxWidth = 780; //600

  final Widget mobileBody;
  final Widget tabletBody;

  const ResponsiveLeayout({
    super.key, 
    required this.mobileBody, 
    required this.tabletBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileMaxWidth) {
          return mobileBody;
        } else {
          return tabletBody;
        }
      },
    );
  }
}

/**
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [  

              ],
            ),
          ),
      ),
    );
  }
 */