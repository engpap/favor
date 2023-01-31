import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/booked_favor_page/favorBookedPage.dart';
import 'package:project/screens/favor_information_page/favorInformationPage_tablet.dart';
import 'package:project/screens/favor_information_page/favorInformationPage.dart';

class favorBookedPage_Screen_T extends StatelessWidget {
  favorBookedPage_Screen_T({
    super.key,
    required this.bookedFavor,
  });

  BookedFavor? bookedFavor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT SCREEN
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.homeColumnWidth(
                  context), //Responsive.fixedWidth(),
            ),
            child: Column(
              children: [
                // FAVOR INFORMATION
                CustomCard(child: FavorInformation(post: bookedFavor!.post)),
                // FAVOR PERSON
                CustomCard(
                  child: FavorBookPerson(
                    post: bookedFavor!.post,
                    booked: bookedFavor!,
                  ),
                ),
                // FAVOR COMPLETED
                MarkAsCompletedButton(bookedFavor: bookedFavor),
                // GOOGLE CALENDAR
                AddToGoogleCalendarButton(post: bookedFavor!.post),
              ],
            ),
          ),
        ),
        /// RIGHT SCREEN
        // MAP
        // Container(
        Container( width: Responsive.homeColumnWidth(context),
          child: FavorMapTablet(post: bookedFavor!.post)
        ),
      ],
    );
  }
}
