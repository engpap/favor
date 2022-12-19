library globals;

import 'package:flutter/cupertino.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/services/postService.dart';

String categoryHeading = "Select a category";
IconData categoryPrefixIcon = CupertinoIcons.square_list;

TextEditingController categoryTextController = TextEditingController(text: "");
String categoryPlaceholder = "Ex. Dog Sitting";

String areaHeading = "Select an area:";
IconData areaPrefixIcon = CupertinoIcons.location_solid;

TextEditingController areaTextController = TextEditingController(text: "");
String areaPlaceholder = "Ex. Lambrate, Milan";

/// STARTIME
List<Text> startTime = [
  Text("1:00"),
  Text("2:00"),
  Text("3:00"),
  Text("4:00"),
  Text("5:00"),
  Text("6:00"),
  Text("7:00"),
  Text("8:00"),
  Text("9:00"),
  Text("10:00"),
  Text("11:00"),
  Text("12:00"),
];

String startTimeHeading = "From which type?";
IconData startTimePrefixIcon = CupertinoIcons.time;

TextEditingController startTimeTextController = TextEditingController(text: "");
String startTimePlaceholder = "Ex. 8:00";

/// ENDTIME
List<Text> endTime = [
  Text("1:00"),
  Text("2:00"),
  Text("3:00"),
  Text("4:00"),
  Text("5:00"),
  Text("6:00"),
  Text("7:00"),
  Text("8:00"),
  Text("9:00"),
  Text("10:00"),
  Text("11:00"),
  Text("12:00"),
];

String endTimeHeading = "To which time?";
IconData endTimePrefixIcon = CupertinoIcons.time;

TextEditingController endTimeTextController = TextEditingController(text: "");
String endTimePlaceholder = "Ex. 12:00";

/// Favor INFORMATIONS

TextEditingController informationsTextController =
    TextEditingController(text: "");
String informationsPlaceholder = "Ex. This is a description";
String informationsHeading = "Describe the favor:";

final PostService postService = PostService();
