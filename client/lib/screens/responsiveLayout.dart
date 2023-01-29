import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

class ResponsiveLeayout extends StatelessWidget {
  // screen max width for a mobile app
  final double mobileMaxWidth = 640; //780
  final double notSupportedSize = 300;
  final double notSupportedSize2 = 200; //300 TODO: provvisorio?

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
        if (constraints.maxWidth < notSupportedSize ||
            constraints.maxHeight < notSupportedSize2) {
          //
          return notSupportedScreen(
              constraints.maxWidth, constraints.maxHeight);
        } else if (constraints.maxWidth < mobileMaxWidth) {
          return mobileBody;
        } else {
          return tabletBody;
        }
      },
    );
  }

  Widget notSupportedScreen(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: favorColors.Error.withAlpha(220),
      child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/logo/logo.png'),
            fit: BoxFit.contain,
            opacity: 0.5,
          )),
          child: Container(
            child: Center(
                child: Stack(
              children: [
                // Implement the stroke
                Text(
                  'Unsupported Screen',
                  style: TextStyle(
                    fontSize: min(width, height) / 7,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 5
                      ..color = favorColors.Error,
                  ),
                ),
                // The text inside
                Text(
                  'Unsupported Screen',
                  style: TextStyle(
                    fontSize: min(width, height) / 7,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
          )),
    );
  }
}

/** 
 * PAGE - GENERAL STRUCTURE
 * 
class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        //PAGE
        child: CupertinoPageScaffold(
          child: SafeArea(
            child: ResponsiveLeayout(
              mobileBody: Screen_M(),
              tabletBody: Screen_T(),
            ),
          ))));
  }
}
*/

/**
 *  PAGE - SPECIFIC LAYOUT
 * 
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