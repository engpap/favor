import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/favorBookedPage/favorBookedPage.dart';
import 'package:project/screens/favorBookedPage/favorBookedPage_mobile.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage_tablet.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';

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
              maxWidth: Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
            ),
            child: Column(
              children: [
                // FAVOR INFORMATION
                CustomCard(child: FavorInformation(post: bookedFavor!.post)),
                // FAVOR PERSON
                CustomCard(child: FavorPerson(post: bookedFavor!.post),),
                // FAVOR COMPLETED
                FavorCompleted(bookedFavor: bookedFavor),
                // GOOGLE CALENDAR
                Consumer<UserProvider>(
                  builder: (context, myProvider, child) {
                    if (myProvider.getGoogleClient() != null) {
                      return AddToGoogleCalendarButton(post: bookedFavor!.post);
                    } else
                      return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        /// RIGHT SCREEN
        // MAP
        FavorMapTablet(post: bookedFavor!.post)
      ],
    );
    
  }
}
