library globals;

import 'package:flutter/cupertino.dart';

/// CATEGORY
List<Text> category = [
  Text("acivity0"),
  Text("acivity1"),
  Text("acivity2"),
  Text("acivity3"),
  Text("acivity4"),
  Text("acivity5"),
];

String categoryHeading = "Type a category or select from the list:";
IconData categoryPrefixIcon = CupertinoIcons.square_list;

TextEditingController categoryTextController = TextEditingController(text: "");
String categoryPlaceholder = "ex. activity0";


/// AREA
List<Text> area = [
  Text("area0"),
  Text("area1"),
  Text("area2"),
  Text("area3"),
  Text("area4"),
  Text("area5"),
];

String areaHeading = "Type an area or select from the list:";
IconData areaPrefixIcon = CupertinoIcons.location_solid;

TextEditingController areaTextController = TextEditingController(text: "");
String areaPlaceholder = "ex. area0";


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

String startTimeHeading = "Type a startTime or select from the list:";
IconData startTimePrefixIcon = CupertinoIcons.time;

TextEditingController startTimeTextController = TextEditingController(text: "");
String startTimePlaceholder = "ex. 8:00";


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

String endTimeHeading = "Type an endTime or select from the list:";
IconData endTimePrefixIcon = CupertinoIcons.time;

TextEditingController endTimeTextController = TextEditingController(text: "");
String endTimePlaceholder = "ex. 12:00";


/// Favor INFORMATIONS

TextEditingController informationsTextController = TextEditingController(text: "");
String informationsPlaceholder = "ex. this is a description";
String informationsHeading = "Breatly describe the favor:";