import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/responsive.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/components/starsWidget.dart';

import 'package:project/screens/booked_favor_page/favorBookedPage_mobile.dart';
import 'package:project/screens/booked_favor_page/favorBookedPage_tablet.dart';

import 'package:project/screens/responsiveLayout.dart';
import 'package:provider/provider.dart';

class BookedFavorPage_Screen extends StatelessWidget {
  BookedFavorPage_Screen({
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
              child: ResponsiveLayout(
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
        key: Key('MarkAsCompleted_button'),
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
          bool result = await Provider.of<AppProvider>(context, listen: false)
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
                            Provider.of<AppProvider>(context, listen: false)
                                .rateFavor(
                                    context, widget.bookedFavor!.id, _rating);
                            // update the screen [to disable the button]
                            setState(() {});
                            // CLOSE POP UP
                            Navigator.pop(context);
                            // GO BACK TO FEED
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
      key: Key("RatingPicker"),
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

class FavorBookPerson extends StatefulWidget {
  FavorBookPerson({
    super.key,
    required this.post,
    required this.booked,
  });

  BookedFavor booked;
  Post? post;

  @override
  State<FavorBookPerson> createState() => _FavorBookPersonState();
}

class _FavorBookPersonState extends State<FavorBookPerson> {
  late Future<User?> _provider;
  late Future<User?> _caller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _caller = Provider.of<AppProvider>(context)
        .getUserProfileById(context, widget.booked.callerId);
    _provider = Provider.of<AppProvider>(context)
        .getUserProfileById(context, widget.booked.providerId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1st ROW - HEADING
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Expanded(
              child: Container(
                width: Responsive.widthFixOver(80, 20, context),
                height: Responsive.widthFixOver(80, 20, context),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: widget.post!.profilePicture!.image,
                    fit: BoxFit.cover,
                  ),
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
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME AND SURNAME
                Text(
                  "${widget.post!.name} ${widget.post!.surname}",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                  textAlign: TextAlign.left,
                ),
                //ROLE - 1/2
                FutureBuilder<User?>(
                    future: _caller,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (widget.booked.post.name == snapshot.data!.name &&
                            widget.booked.post.surname ==
                                snapshot.data!.surname)
                          return (Text(
                            "caller",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: favorColors.SecondaryBlue),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return Container();
                    }),
                // ROLE - 2/2
                FutureBuilder<User?>(
                    future: _provider,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (widget.booked.post.name == snapshot.data!.name &&
                            widget.booked.post.surname ==
                                snapshot.data!.surname)
                          return (Text(
                            "provider",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: favorColors.SecondaryBlue),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ));
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return Container();
                    }),
                SizedBox(
                  height: 10,
                ),
                // STARS
                StarsWidget(number: widget.post!.averageRatings),
                SizedBox(
                  height: 5,
                ),
                // RANK
                widget.post!.rankingPosition != 0
                    ? Text(
                        "Ranked as ${widget.post!.rankingPosition}º in ${widget.post!.rankingLocation}",
                        style: TextStyle(fontSize: 14),
                      )
                    : Text(
                        "Never done a favor in ${widget.post!.rankingLocation}",
                        style: TextStyle(fontSize: 14),
                      )
              ],
            ),
          ],
        ),
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),
        // 2nd ROW - BIO
        Container(
          width: Responsive.width(90, context),
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bio",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.post!.bio!,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),
        // 3rd ROW - CONTACT
        Container(
          width: Responsive.width(90, context),
          padding: EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.post!.email!,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.fade,
              ),
              Text(
                "+39 347 4567890", // TODO: post!.phone!,
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        ),
      ],
    );
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
          // CALENDAR BUTTON
          child: Container(
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
                await Provider.of<AppProvider>(context, listen: false)
                    .insertEventInGoogleCalendar(
                  context,
                  post.taskCategory,
                  post.location,
                  (post is CallerPost)
                      ? (post as CallerPost).getFavorStartTime()
                      : (post as ProviderPost).getAvailabilityStartTime(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
