import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/favorTime.dart' as favorTime;
import 'package:project/functions/responsive.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/components/favor_PickerMenu.dart';

import 'package:project/screens/home.dart';
import 'package:project/screens/responsiveLayout.dart';
import 'package:project/services/constantsService.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'globals.dart' as globals;

//import 'package:project/screens/favor/favor2.dart';

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
    favorConstants = ConstantsService().getFavorConstants();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: Responsive.width(100, context),
        color: Colors.white,
        child: Column(
          children: [
            /// FORM
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
                          ),
                          Divider(
                            height: Responsive.height(2, context),
                            color: Colors.transparent,
                          ),

                          // TIME PICKERS
                          UserMode_inherited.of(context)
                                  .stateWidget
                                  .isUserModeAs_provider()
                              ? (Column(
                                  children: [
                                    //PICKER availabilityStartTime - PROVIDER
                                    Favor_TimePicker(
                                      placeholder: globals
                                          .availabilityStartTimePlaceholder,
                                      heading:
                                          globals.availabilityStartTimeHeading,
                                      prefixIcon: globals
                                          .availabilityStartTimePrefixIcon,
                                      textController: globals
                                          .availabilityStartTimeTextController,
                                    ),
                                    Divider(
                                      height: Responsive.height(2, context),
                                      color: Colors.transparent,
                                    ),
                                    //PICKER availabilityEndTime - PROVIDER
                                    Favor_TimePicker(
                                      placeholder: globals
                                          .availabilityEndTimePlaceholder,
                                      heading:
                                          globals.availabilityEndTimeHeading,
                                      prefixIcon:
                                          globals.availabilityEndTimePrefixIcon,
                                      textController: globals
                                          .availabilityEndTimeTextController,
                                    )
                                  ],
                                ))
                              : (
                                  //PICKER favorStartTime - CALLER
                                  Favor_TimePicker(
                                  //contentList: globals.favorStartTime,
                                  placeholder:
                                      globals.favorStartTimePlaceholder,
                                  heading: globals.favorStartTimeHeading,
                                  prefixIcon: globals.favorStartTimePrefixIcon,
                                  textController:
                                      globals.favorStartTimeTextController,
                                )),

                          Divider(
                            height: Responsive.height(2, context),
                            color: Colors.transparent,
                          ),

                          // BOX DESCRIPTION
                          Favor_boxDescription(
                            placeholder: globals.boxDescriptionPlaceholder,
                            heading: globals.boxDescriptionHeading,
                            textController:
                                globals.boxDescriptionTextController,
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
          key: Key("publish_favor_button"),
          color: favorColors.PrimaryBlue,
          child: const Text(
            "Publish",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            print('Pressed: Favor_publishFavorButton');
            FutureBuilder<void>(
              future: UserMode_inherited.of(context)
                      .stateWidget
                      .isUserModeAs_provider() //isUserModeAsProvider()
                  ? globals.postService.publishProviderFavor(
                      context: context,
                      taskCategory: globals.categoryTextController.text,
                      location: globals.locationTextController.text,
                      availabilityStartTime: favorTime.formatter.parse(
                          globals.availabilityStartTimeTextController.text),
                      availabilityEndTime: favorTime.formatter.parse(
                          globals.availabilityEndTimeTextController.text),
                      description: globals.boxDescriptionTextController.text,
                    )
                  : globals.postService.publishCallerFavor(
                      context: context,
                      taskCategory: globals.categoryTextController.text,
                      location: globals.locationTextController.text,
                      favorStartTime: favorTime.formatter
                          .parse(globals.favorStartTimeTextController.text),
                      description: globals.boxDescriptionTextController.text,
                    ),
              builder: (context, snapshot) {
                //TODO: queste funzioni non partono mai
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

/// TIME PICKER MENU
class Favor_TimePicker extends StatefulWidget {
  // menu placeholder
  final String placeholder;
  // menu description
  final String heading;
  //pass <CupertinoIcons.something> for the prefix
  final IconData prefixIcon;
  // to manipulate the content of the texfield
  TextEditingController textController;

  Favor_TimePicker({
    super.key,
    required this.placeholder,
    required this.heading,
    required this.prefixIcon,
    required this.textController,
  });

  @override
  State<Favor_TimePicker> createState() => _Favor_TimePickerState();
}

class _Favor_TimePickerState extends State<Favor_TimePicker> {
  DateTime dateTime = DateTime.now();
  DateTime minimumDate = DateTime.now().subtract(Duration(hours: 2));
  DateTime maximumDate = DateTime.now().add(Duration(days: 7));

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
                  color: favorColors.PrimaryBlue,
                  widget.prefixIcon,
                ),
                onPressed: null,
              ),
              placeholder: widget.placeholder,
              controller: widget.textController,
              readOnly: true, //
              enableInteractiveSelection: false, //
              // BUTTON SHOW PICKER
              suffix: CupertinoButton(
                  child: Icon(
                    CupertinoIcons.arrowtriangle_down_circle_fill,
                    color: favorColors.Yellow,
                  ),
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                              actions: [buildDatePicker()],
                              cancelButton: CupertinoActionSheetAction(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ));
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDatePicker() => SizedBox(
      height: Responsive.height(30, context),
      child: CupertinoDatePicker(
          backgroundColor: Colors.white,
          minimumDate: minimumDate,
          maximumDate: maximumDate,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.dateAndTime,
          onDateTimeChanged: (dateTime) {
            widget.textController.text = favorTime.formatter.format(dateTime);
            setState(() {
              this.dateTime = dateTime;
            });
          }));
}
