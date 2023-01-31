import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/booked_favor_page/favorBookedPage.dart';
import 'package:project/screens/favor_information_page/favorInformationPage.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/screens/components/customCard.dart';

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
      // FAVOR COMPLETED
      MarkAsCompletedButton(bookedFavor: bookedFavor),
      // GOOGLE CALENDAR
      AddToGoogleCalendarButton(post: bookedFavor!.post),
      // FAVOR PERSON
      CustomCard(
        child: FavorBookPerson(
          post: bookedFavor!.post,
          booked: bookedFavor!,
        ),
      ),
    ]));
  }
}
