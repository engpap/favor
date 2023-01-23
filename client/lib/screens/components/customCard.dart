import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

/// Custom card to avoid duplicated code across the application.
class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    required this.child,
    this.customHeight,
    this.padding = const EdgeInsets.all(9),
    this.margin = const EdgeInsets.all(9),
  });

  final Widget child;
  final double? customHeight;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: customHeight != null
          ? Responsive.width(customHeight!, context)
          : null,
      margin: margin,
      padding: padding,
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
