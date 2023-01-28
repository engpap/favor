import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/favorBookedPage/favorBookedPage.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/services/apis/google_calendar_api_wrapper.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/starsWidget.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/favorTime.dart' as favorTime;

class favorBookedPage_Screen_M extends StatelessWidget {
  favorBookedPage_Screen_M({
    super.key,
    required this.bookedFavor,
  });

  BookedFavor? bookedFavor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      // FAVOR INFORMATION
      CustomCard(child: FavorInformation(post: bookedFavor!.post)),
      // FAVOR MAP
      CustomCard(
        padding: EdgeInsets.all(0),
        //margin: EdgeInsets.only(right: 9, left: 9),
        child: FavorMap(post: bookedFavor!.post),
      ),
      // FAVOR COMPLETED
      MarkAsCompletedButton(bookedFavor: bookedFavor),
      // GOOGLE CALENDAR
      Consumer<UserProvider>(
        builder: (context, myProvider, child) {
          if (myProvider.getGoogleClient() != null) {
            return AddToGoogleCalendarButton(post: bookedFavor!.post);
          } else
            return Container();
        },
      ),
      // FAVOR PERSON
      CustomCard(
        child: FavorBookPerson(post: bookedFavor!.post, booked: bookedFavor!,),
      ),
    ]));
  }
}

class AddToGoogleCalendarButton extends StatelessWidget {
  final Post post;

  AddToGoogleCalendarButton({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(9),
      child: SafeArea(
        child: Center(
          child: // CALENDAR BUTTON
              Container(
            width: MediaQuery.of(context).size.width,
            height: Responsive.width(12, context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: favorColors.LightGrey,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              color: favorColors.PrimaryBlue,
              borderRadius: BorderRadius.circular(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Icon(CupertinoIcons.add),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Add to Google Calendar'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Image(
                      image: AssetImage(
                          "assets/images/google/google_calendar_logo.png"),
                    ),
                  ),
                ],
              ),
              onPressed: () async {
                print('Pressed: _calendarButton');
                await GoogleCalendarApiWrapper().insertEventInGoogleCalendar(
                  context,
                  post.taskCategory,
                  post.location,
                  post.getFavorStartTime(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
