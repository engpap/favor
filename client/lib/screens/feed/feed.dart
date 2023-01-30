import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project/functions/responsive.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/components/starsWidget.dart';
import 'package:project/screens/explore/providerExplore.dart';
import 'package:project/screens/favorBookedPage/favorBookedPage.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';
import 'package:project/screens/feed/feed_mobile.dart';
import 'package:project/screens/feed/feed_tablet.dart';
import 'package:project/screens/feed/feed_utilities.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/functions/favorTime.dart' as favorTime;
import 'package:project/functions/tabs.dart' as FavorTab;
import 'package:provider/provider.dart';

class Feed_Screen extends StatelessWidget {
  const Feed_Screen({super.key});

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
            //backgroundColor: favorColors.IntroBg,
            child: SafeArea(
          child: ResponsiveLeayout(
            mobileBody: Feed_Screen_M(),
            tabletBody: Feed_Screen_M(),
          ),
        )));
  }
}

class FavorCategoryWidget extends StatelessWidget {
  FavorCategoryWidget({
    super.key,
    required this.categoryName,
  });

  final String categoryName;
  CupertinoTabController tabController = FavorTab.tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // IMAGE
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(favorColors.IntroBg),
              foregroundColor:
                  MaterialStateProperty.all<Color>(favorColors.PrimaryBlue),
              overlayColor:
                  MaterialStateProperty.all<Color>(favorColors.SecondaryBlue),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            ),
            onPressed: () {
              // go to Explore Tab
              context.read<ExploreQuery>().update(categoryName);
              tabController.index = 1;
            },
            child: Container(
              height: Responsive.heightFixOver(80, 22, context),
              width: Responsive.heightFixOver(80, 22, context),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: FeedUtilities.getFavorCategoryImage(categoryName),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: favorColors.LightGrey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
}

class FavorWidget extends StatelessWidget {
  FavorWidget({
    super.key,
    required this.post,
  });

  Post? post;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      customWidth: MediaQuery.of(context).size.width-20,//Responsive.width(90, context),
          //Responsive.homeColumnWidth(context), //Responsive.fixedWidth(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1st ROW - HEADING
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    //image: AssetImage("assets/images/chris.jpg"),
                    image: post!.profilePicture!.image,
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: favorColors.LightGrey,
                    width: 1.0,
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
                  // NAME + SURNAME
                  Container(
                    child: Text(
                      "${post!.name} ${post!.surname}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: favorColors.PrimaryBlue),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      // ROLE
                      Container(
                        child: Text(
                          post!.userType,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: favorColors.SecondaryBlue),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      // STARS
                      StarsWidget(
                        number: post!.averageRatings,
                        size: 12,
                      ),
                    ],
                  ),
                ],
              ),
              // to fill the space in between
              Expanded(child: Container()),
              // TASK CATEGORY
              Container(
                padding: EdgeInsets.only(right: 9),
                child: Text(
                  post!.taskCategory,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // 2nd ROW - favor's description
          SizedBox(
            height: 10,
          ),
          // DESCRIPTION
          Container(
            padding: EdgeInsets.only(left: 51, right: 9),
            child: Text(
              post!.description,
              style: TextStyle(
                fontSize: 18,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // 3rd ROW - favor's time
          SizedBox(
            height: 10,
          ),
          // TIME
          Container(
            padding: EdgeInsets.only(right: 9, left: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ICON
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    CupertinoIcons.time,
                    color: Colors.black45,
                    //scolor: favorColors.PrimaryBlue,
                    size: 24, //
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                // VALUE
                Container(
                  child: Text(
                    (post is CallerPost)
                        ? "From: ${favorTime.formatter.format(post!.getFavorStartTime())}"
                        : "From: ${favorTime.formatter.format(post!.getAvailabilityStartTime())}\nTo: ${favorTime.formatter.format(post!.getAvailabilityEndTime())}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black45,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // 4th ROW - favor's location
          SizedBox(
            height: 10,
          ),
          // LOCATION
          Container(
            padding: EdgeInsets.only(right: 9, left: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ICON
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    CupertinoIcons.location_solid,
                    color: Colors.black45,
                    //scolor: favorColors.PrimaryBlue,
                    size: 24, //
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                // VALUE
                Container(
                  child: Container(
                    child: Text(
                      post!.location,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black45,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 5th ROW - more button
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              // MORE BUTTON
              Container(
                padding: EdgeInsets.only(left: 45),
                height: 32,
                width: 200,
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
                  borderRadius: BorderRadius.circular(90),
                  child: Text(
                    "More...",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    print('Pressed: _moreButton');
                    String userType = UserMode_inherited.of(context)
                        .stateWidget
                        .getUserMode();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => FavorInformationPageScreen(
                                post: post,
                                userType: userType,
                              )),
                    );
                  },
                ),
              ),
              // to fill the space in between
              Expanded(child: Container()),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          /**
          // RANK
          Container(
            child: Text(
              "${post!.rankingPosition} in ${post!.rankingLocation}",
              style: TextStyle(
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          */
        ],
      ),
    );
  }
}

class BookedFavorWidget extends StatefulWidget {
  BookedFavorWidget({
    super.key,
    required this.booked,
  });

  BookedFavor booked;

  @override
  State<BookedFavorWidget> createState() => _BookedFavorWidgetState();
}

class _BookedFavorWidgetState extends State<BookedFavorWidget> {
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
    return Container(
      child: CustomCard(
        padding: EdgeInsets.all(0),
        //margin: EdgeInsets.all(0),
        child: Container(
          width: Responsive.widthFixOver(210, 55, context),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(favorColors.IntroBg),
                foregroundColor:
                    MaterialStateProperty.all<Color>(favorColors.PrimaryBlue),
                overlayColor:
                    MaterialStateProperty.all<Color>(favorColors.SecondaryBlue),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
              ),
              onPressed: () {
                print('Pressed: BookedFavor');
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => favorBookedPage_Screen(
                            bookedFavor: widget.booked,
                          )),
                );
              },
              // LAYOUT
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IMAGE
                  SizedBox(
                    width: Responsive.widthFixOver(80, 20, context),
                    height: Responsive.widthFixOver(80, 100, context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: FeedUtilities.getFavorCategoryImage(
                              widget.booked.post.taskCategory),
                          fit: BoxFit.cover,
                          opacity: 1,
                        ),
                        border: Border.all(
                          color: favorColors.LightGrey,
                          width: 0.0,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(90),
                          bottomRight: Radius.circular(90),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0.5,
                            blurRadius: 5,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  // INFORMATIONS
                  Container(
                    width: Responsive.widthFixOver(120, 29, context),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // NAME SURNAME
                          Text(
                            '${widget.booked.post.name} ${widget.booked.post.surname}', //TODO: fix
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          //ROLE - 1/2
                          FutureBuilder<User?>(
                              future: _caller,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (widget.booked.post.name ==
                                          snapshot.data!.name &&
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
                                  if (widget.booked.post.name ==
                                          snapshot.data!.name &&
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
                            height: 5,
                          ),
                          // TIME
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //icon clock
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    CupertinoIcons.time,
                                    color: favorColors.PrimaryBlue,
                                    size: 24, //
                                  ),
                                ),
                                //actual time
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      Utilities.getHoursAndMinutes(
                                          widget.booked.bookedAt),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: favorColors.PrimaryBlue,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// SEARCH BAR TODO: serve o va rimossa?
class SearchFavor extends StatelessWidget {
  SearchFavor({super.key});

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
  }
}
