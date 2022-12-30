import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/home.dart'; 
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/services/postService.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'globals.dart' as globals;


class FavorScreen extends StatelessWidget {
  const FavorScreen({super.key});

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
                mobileBody: FavorScreen_M(),
                //TODO do we need tablet?
                tabletBody: FavorScreen_M(),
              ),
            )));
  }
}

class FavorScreen_M extends StatefulWidget {
  const FavorScreen_M({super.key});
  @override
  State<FavorScreen_M> createState() => _FavorScreen_M();
}

class _FavorScreen_M extends State<FavorScreen_M> {
  late Future<FavorConstants> favorConstants;

  @override
  void initState() {
    super.initState();
    favorConstants = PostService().getFavorConstants();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: Responsive.width(100, context),
        color: Colors.white,
        child: Column(
          children: [
            ///FORM
            Container(
              margin: EdgeInsets.all(9),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.5,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
                color: favorColors.IntroBg,
                border: Border.all(
                    color: favorColors.LightGrey,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),

              /// FIELDS
              child: FutureBuilder<FavorConstants>(
                  future: favorConstants,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          //PICKER category
                          Favor_pickerMenu(
                            contentList: snapshot.data!.favorCategories,
                            placeholder: globals.categoryPlaceholder,
                            heading: globals.categoryHeading,
                            prefixIcon: globals.categoryPrefixIcon,
                            textController: globals.categoryTextController,
                            flag: 1, //if possible remove this
                          ),
                          Divider(
                            height: Responsive.height(2, context),
                            color: Colors.transparent,
                          ),
                          //PICKER location
                          Favor_pickerMenu(
                            contentList: snapshot.data!.locations,
                            placeholder: globals.locationPlaceholder,
                            heading: globals.locationHeading,
                            prefixIcon: globals.locationPrefixIcon,
                            textController: globals.locationTextController,
                            flag: 2, //if possible remove this
                          ),
                          Divider(
                            height: Responsive.height(2, context),
                            color: Colors.transparent,
                          ),

                          isUserModeAsProvider() 
                          ? (
                            Column(
                              children: [
                                //PICKER availabilityStartTime - PROVIDER
                                Favor_pickerMenu(
                                  contentList: globals.availabilityStartTime,
                                  placeholder: globals.availabilityStartTimePlaceholder,
                                  heading: globals.availabilityStartTimeHeading,
                                  prefixIcon: globals.availabilityStartTimePrefixIcon,
                                  textController: globals.availabilityStartTimeTextController,
                                  flag: 3, //if possible remove this
                                ),
                                Divider(
                                  height: Responsive.height(2, context),
                                  color: Colors.transparent,
                                ),
                                //PICKER availabilityEndTime - PROVIDER
                                Favor_pickerMenu(
                                  contentList: globals.availabilityEndTime,
                                  placeholder: globals.availabilityEndTimePlaceholder,
                                  heading: globals.availabilityEndTimeHeading,
                                  prefixIcon: globals.availabilityEndTimePrefixIcon,
                                  textController: globals.availabilityEndTimeTextController,
                                  flag: 4, //if possible remove this
                                )
                              ],
                            )
                          ) 
                          : (
                            //PICKER favorStartTime - CALLER
                            Favor_pickerMenu(
                              contentList: globals.favorStartTime,
                              placeholder: globals.favorStartTimePlaceholder,
                              heading: globals.favorStartTimeHeading,
                              prefixIcon: globals.favorStartTimePrefixIcon,
                              textController: globals.favorStartTimeTextController,
                              flag: 5, //if possible remove this
                            )
                          ),

                          Divider(
                            height: Responsive.height(2, context),
                            color: Colors.transparent,
                          ),
                          //boxDescription
                          Favor_boxDescription(
                            placeholder: globals.boxDescriptionPlaceholder,
                            heading: globals.boxDescriptionHeading,
                            textController: globals.boxDescriptionTextController,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return CupertinoActivityIndicator(
                        animating: false, radius: 10);
                  })),
            ),
            Divider(
              height: Responsive.height(2, context),
              color: Colors.transparent,
            ),

            ///PUBLISH BUTTON
            Favor_publishFavorButton(),
          ],
        ),
      ),
    );
  }
}

/// PICKER MENU
class Favor_pickerMenu extends StatefulWidget {
  // List of item showed in the menu'
  final List<Text> contentList;
  // menu placeholder
  final String placeholder;
  // menu description
  final String heading;
  //pass <CupertinoIcons.something> for the prefix
  final IconData prefixIcon;
  // to manipulate the content of the texfield
  TextEditingController textController;
  // !! funziana solo con le flag 1-2-3-4-5 per il form menu dei nuovi favor. Non riutilizzare questo widget a caso
  int flag = 0;

  Favor_pickerMenu(
      {super.key,
      required this.placeholder,
      required this.heading,
      required this.contentList,
      required this.prefixIcon,
      required this.textController,
      required this.flag});

  @override
  State<Favor_pickerMenu> createState() => _Favor_pickerMenuState();
}

class _Favor_pickerMenuState extends State<Favor_pickerMenu> {
  // initial value displayed 0
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            //DESCRIPTION
            SizedBox(
              width: Responsive.width(100, context),
              child: Text(
                "${widget.heading}",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            Divider(
              height: Responsive.height(1, context),
              color: Colors.transparent,
            ),
            // TEXTFIELD
            CupertinoTextField(
              prefix: CupertinoButton(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                child: Icon(
                  widget.prefixIcon,
                ),
                onPressed: null,
              ),
              placeholder: widget.placeholder,
              controller: widget.textController,
              // PICKER BUTTON
              suffix: CupertinoButton(
                child: Icon(
                  CupertinoIcons.arrowtriangle_down_circle,
                  color: favorColors.SecondaryBlue,
                ),
                onPressed: (() => showCupertinoModalPopup(
                    context: context,
                    builder: (_) => SizedBox(
                          width: Responsive.width(100, context),
                          height: Responsive.height(20, context),
                          child: CupertinoPicker(
                            backgroundColor: Colors.white,
                            itemExtent: Responsive.height(5, context), //height of current item
                            scrollController: FixedExtentScrollController(
                              initialItem: selectedValue,
                            ),
                            children: widget.contentList,
                            onSelectedItemChanged: (int value) {
                              setState(() {
                                selectedValue = value;
                                // TODO: if possible remove these flags and use a cleaner approach
                                if (widget.flag == 1) {
                                  globals.categoryTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                                if (widget.flag == 2) {
                                  globals.locationTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                                if (widget.flag == 3) {
                                  globals.availabilityStartTimeTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                                if (widget.flag == 4) {
                                  globals.availabilityEndTimeTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                                if (widget.flag == 5) {
                                  globals.favorStartTimeTextController =
                                      TextEditingController(
                                          text:
                                              '${widget.contentList.elementAt(selectedValue).data}');
                                }
                              });
                            },
                          ),
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Favor_boxDescription extends StatelessWidget {
  // menu placeholder
  final String placeholder;
  // menu description
  final String heading;
  // to manipulate the content of the texfield
  TextEditingController textController;

  Favor_boxDescription({
    super.key,
    required this.placeholder,
    required this.textController,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: Responsive.width(100, context),
            child: Text("${heading}",
                style: TextStyle(fontSize: 18), textAlign: TextAlign.left),
          ),
          Divider(
            height: Responsive.height(1, context),
            color: Colors.transparent,
          ),
          CupertinoTextField(
            placeholder: this.placeholder,
            controller: this.textController,
            minLines: 5,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

/// PUSBLISH FAVOR BUTTON
class Favor_publishFavorButton extends StatefulWidget {
  const Favor_publishFavorButton({super.key});

  @override
  State<Favor_publishFavorButton> createState() =>
      _Favor_publishFavorButtonState();
}

class _Favor_publishFavorButtonState extends State<Favor_publishFavorButton> {
  late Future<Post> post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 9, right: 9, left: 9, bottom: 9),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: SizedBox(
        width: Responsive.width(65, context),
        child: CupertinoButton(
          color: favorColors.PrimaryBlue,
          child: const Text(
            "Publish",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            print('Pressed: Favor_publishFavorButton');
            FutureBuilder<Post?>(
              future: isUserModeAsProvider()
                  ? globals.postService.publishProviderFavor(
                      context: context,
                      taskCategory: globals.categoryTextController.text,
                      location: globals.locationTextController.text,
                      availabilityStartTime: DateTime.now(), //TODO: change
                      availabilityEndTime: DateTime.now(), //TODO: change
                      description: globals.boxDescriptionTextController.text,
                    )
                  : globals.postService.publishCallerFavor(
                      context: context,
                      taskCategory: globals.categoryTextController.text,
                      location: globals.locationTextController.text,
                      favorStartTime: DateTime.now(), //TODO: change
                      description: globals.boxDescriptionTextController.text,
                    ),
              builder: (context, snapshot) {
                print("insid!!! ");
                if (snapshot.hasData) {
                  print(">>> Post created! Redirecting to Information page...");
                } else if (snapshot.hasError) {
                  print(">>> Error: '${snapshot.error.toString()}'");
                  return Text('${snapshot.error}');
                }
                return CupertinoActivityIndicator(animating: false, radius: 10);
              },
            );
          },
        ),
      ),
    );
  }
}
