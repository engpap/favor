import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ResponsiveLeayout extends StatelessWidget {
  // screen max width for a mobile app
  final int mobileMaxWidth = 600;

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
