library globals;

import 'package:flutter/cupertino.dart';
import 'package:project/services/postService.dart';

final PostService postService = PostService();

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
TextEditingController boxDescriptionTextController = TextEditingController(text: "");
String boxDescriptionPlaceholder = "Ex. This is a description";




// TODO: DateTime e modifica guardando post.js

/// availabilityStartTime - provider
List<Text> availabilityStartTime = [
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
String availabilityStartTimeHeading = "From which time are you available?";
IconData availabilityStartTimePrefixIcon = CupertinoIcons.time;
TextEditingController availabilityStartTimeTextController = TextEditingController(text: "");
String availabilityStartTimePlaceholder = "Ex. 8:00";

// availabilityEndTime - provider
List<Text> availabilityEndTime = [
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
String availabilityEndTimeHeading = "To which time are you available??";
IconData availabilityEndTimePrefixIcon = CupertinoIcons.time;
TextEditingController availabilityEndTimeTextController = TextEditingController(text: "");
String availabilityEndTimePlaceholder = "Ex. 12:00";

// favorStartTime - caller
List<Text> favorStartTime = [
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
String favorStartTimeHeading = "When do you need it?";
IconData favorStartTimePrefixIcon = CupertinoIcons.time;
TextEditingController favorStartTimeTextController = TextEditingController(text: "");
String favorStartTimePlaceholder = "Ex. 12:00";