import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/services/constantsService.dart';
import 'package:project/services/leaderboardService.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

class SearchFavorBar extends StatelessWidget {
  SearchFavorBar({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        floating: true,
        snap: true,
        pinned: false,
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          height: 50,
          decoration: BoxDecoration(
              color: favorColors.IntroBg,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(90),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ]),
          child: CupertinoTextField(
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: favorColors.PrimaryBlue,
            ),
            //textInputAction: widget.textInputAction, //widget
            //keyboardType: widget.textInputType, //widget
            padding: EdgeInsets.only(top: 9, bottom: 9),
            decoration: BoxDecoration(
              color: favorColors.IntroBg,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(90),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            cursorColor: favorColors.Yellow,
            cursorWidth: 2,
            cursorRadius: Radius.circular(10),
            // prefix button
            prefix: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(
                CupertinoIcons.search,
                color: favorColors.PrimaryBlue,
              ),
              onPressed: null,
            ),
            // clear button
            suffix: CupertinoButton(
              padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
              child: Icon(
                CupertinoIcons.xmark_circle_fill,
                color: favorColors.Yellow.withOpacity(0.8),
              ),
              onPressed: () => textController.clear(),
            ),
            maxLength: 30, // reasonable value
            maxLines: 1, // reasonable value
            placeholder: "Search favor",
            placeholderStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
            ),
            controller: textController,
            onSubmitted: (value) =>
                print('Submitted [${textController}]: $value'),
          ),
        ));
  }
}


/**
 * 
 * Container(
      margin: EdgeInsets.only(left: 9, right: 9),
      height: Responsive.height(1, context),
      child: CupertinoTextField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: favorColors.PrimaryBlue,
        ),
        //textInputAction: widget.textInputAction, //widget
        //keyboardType: widget.textInputType, //widget
        padding: EdgeInsets.only(top: 9, bottom: 9),
        decoration: BoxDecoration(
          color: favorColors.IntroBg,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(90),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        cursorColor: favorColors.SecondaryBlue,
        cursorWidth: 2,
        cursorRadius: Radius.circular(10),
        // prefix button
        prefix: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.search,
            color: favorColors.PrimaryBlue,
          ),
          onPressed: null,
        ),
        // clear button
        suffix: CupertinoButton(
          padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
          child: Icon(
            CupertinoIcons.xmark_circle_fill,
            color: favorColors.Yellow.withOpacity(0.8),
          ),
          onPressed: () => textController.clear(),
        ),
        maxLength: 30, // reasonable value
        maxLines: 1, // reasonable value
        placeholder: "Search favor",
        placeholderStyle: TextStyle(
          color: favorColors.SecondaryBlue,
          fontWeight: FontWeight.normal,
        ),
        controller: textController,
        onSubmitted: (value) => print('Submitted [${textController}]: $value'),
      ),
    );
 */