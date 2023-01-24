import 'package:flutter/cupertino.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

class customHeadingDesc extends StatelessWidget {
  customHeadingDesc({
    super.key,
    required this.heading,
    required this.description,
  });

  String heading;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// PAGE TITLE
        Container(
          width: Responsive.width(100, context),
          margin: EdgeInsets.only(right: 9, left: 9),
          child: Text(
            heading,
            style: TextStyle(
                color: favorColors.PrimaryBlue,
                fontSize: 37,
                fontWeight: FontWeight.bold),
          ),
        ),

        /// DESCRIPTION
        Container(
          width: Responsive.width(100, context),
          margin: EdgeInsets.only(
              top: Responsive.height(1, context),
              bottom: Responsive.height(3, context),
              right: 9,
              left: 9),
          child: Text(
            description,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: favorColors.PrimaryBlue,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}