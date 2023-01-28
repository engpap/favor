import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:googleapis/cloudbuild/v1.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/models/bookedFavor.dart';

import 'package:project/screens/favorBookedPage/favorBookedPage_mobile.dart';
import 'package:project/screens/favorBookedPage/favorBookedPage_tablet.dart';

import 'package:project/screens/responsiveLayout.dart';
import 'package:project/services/favorService.dart';

class favorBookedPage_Screen extends StatelessWidget {
  favorBookedPage_Screen({
    super.key,
    required this.bookedFavor,
  });

  BookedFavor? bookedFavor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: CupertinoPageScaffold(
            backgroundColor: favorColors.IntroBg,
            child: SafeArea(
              child: ResponsiveLeayout(
                mobileBody: favorBookedPage_Screen_M(bookedFavor: bookedFavor),
                tabletBody: favorBookedPage_Screen_T(bookedFavor: bookedFavor),
              ),
            )));
  }
}

class MarkAsCompletedButton extends StatefulWidget {
  MarkAsCompletedButton({
    super.key,
    required this.bookedFavor,
  });

  BookedFavor? bookedFavor;

  @override
  State<MarkAsCompletedButton> createState() => _MarkAsCompletedButtonState();
}

class _MarkAsCompletedButtonState extends State<MarkAsCompletedButton> {
  //initial value of rating
  double _rating = 5;
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9, right: 9),
      height: Responsive.widthFixOver(45, 15, context),
      width: Responsive.widthFixOver(350, 70, context),
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        color: favorColors.PrimaryBlue,
        borderRadius: BorderRadius.circular(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Icon(CupertinoIcons.check_mark),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 30),
                alignment: Alignment.center,
                child: Text(
                  'Mark as Completed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
        onPressed: () async {
          print('Pressed: FavorCompleted button');
          bool result = await FavorService()
              .markFavorAsCompleted(context, widget.bookedFavor!.id);
          result
              ? showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                        actions: [buildRatingPicker()],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text("Submit"),
                          onPressed: () {
                            print("FINAL RATING: ${_rating}");
                            // il rating è salvato in _rating
                            FavorService().rateFavor(
                                context, widget.bookedFavor!.id, _rating);
                            // aggiorno la pagina [per disattivare il bottone]
                            setState(() {});
                            // CLOSE POP UP
                            Navigator.pop(context);
                            // GO BACK TO FEED - se tolgo questo pop mi resta la pagina del favor con il bottone disattivato
                            Navigator.pop(context);
                          },
                        ),
                      ))
              : null;
        },
      ),
    );
  }

  Widget buildRatingPicker() {
    return SizedBox(
      height: Responsive.height(30, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          // RATING TEXT
          Text(
            "Are you satified?",
            style: TextStyle(
              fontSize: Responsive.height(4, context),
              fontWeight: FontWeight.bold,
            ),
          ),
          // RATING FACES
          Container(
            child: RatingBar.builder(
              glow: false,
              minRating: 1,
              maxRating: 5,
              initialRating: 5,
              itemCount: 5,
              updateOnDrag: true,
              itemSize: Responsive.height(8, context),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Icon(
                      Icons.sentiment_very_dissatisfied,
                      color: Colors.red,
                    );
                  case 1:
                    return Icon(
                      Icons.sentiment_dissatisfied,
                      color: Colors.redAccent,
                    );
                  case 2:
                    return Icon(
                      Icons.sentiment_neutral,
                      color: Colors.amber,
                    );
                  case 3:
                    return Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.lightGreen,
                    );
                  case 4:
                    return Icon(
                      Icons.sentiment_very_satisfied,
                      color: Colors.green,
                    );
                  default:
                    return Container();
                }
              },
              onRatingUpdate: (rating) {
                setState(() {
                  // Update the internal variable
                  _rating = rating;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
