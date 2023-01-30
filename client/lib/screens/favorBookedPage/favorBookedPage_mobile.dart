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
