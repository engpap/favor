library globals;

import 'package:flutter/cupertino.dart';
import 'package:project/functions/favorTime.dart' as favorTime;

// favorCategories
String categoryHeading = "Select a category";
IconData categoryPrefixIcon = CupertinoIcons.square_list;
TextEditingController categoryTextController = TextEditingController(text: "");
String categoryPlaceholder = "Ex. Dog Sitting";

// location
String locationHeading = "Select a location:";
IconData locationPrefixIcon = CupertinoIcons.location_solid;
TextEditingController locationTextController = TextEditingController(text: "");
String locationPlaceholder = "Ex. Lambrate, Milan";

// boxDescription
String boxDescriptionHeading = "Describe the favor:";
TextEditingController boxDescriptionTextController =
    TextEditingController(text: "");
String boxDescriptionPlaceholder = "Ex. This is a description";

/// availabilityStartTime - provider
String availabilityStartTimeHeading = "From which time are you available?";
IconData availabilityStartTimePrefixIcon = CupertinoIcons.time;
TextEditingController availabilityStartTimeTextController =
    TextEditingController(text: favorTime.formatter.format(DateTime.now()));
String availabilityStartTimePlaceholder = "Ex. 8:00";

// availabilityEndTime - provider
String availabilityEndTimeHeading = "To which time are you available??";
IconData availabilityEndTimePrefixIcon = CupertinoIcons.time;
TextEditingController availabilityEndTimeTextController =
    TextEditingController(text: favorTime.formatter.format(DateTime.now()));
String availabilityEndTimePlaceholder = "Ex. 12:00";

// favorStartTime - caller
String favorStartTimeHeading = "When do you need it?";
IconData favorStartTimePrefixIcon = CupertinoIcons.time;
TextEditingController favorStartTimeTextController =
    TextEditingController(text: favorTime.formatter.format(DateTime.now()));
String favorStartTimePlaceholder = "Ex. 12:00";
