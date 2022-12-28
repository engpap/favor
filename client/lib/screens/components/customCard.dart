import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    required this.child,
    required this.customHeight,
  });

  Widget child;
  double customHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.width(customHeight, context),
      margin: EdgeInsets.all(9),
      padding: EdgeInsets.only(top: 9, bottom: 9),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
        color: favorColors.IntroBg,
        border: Border.all(
            color: favorColors.LightGrey, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}

class CustomCard_2 extends StatelessWidget {
  CustomCard_2({super.key,
  required this.child});

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(9),
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
        color: favorColors.IntroBg,
        border: Border.all(
            color: favorColors.LightGrey, width: 1.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
