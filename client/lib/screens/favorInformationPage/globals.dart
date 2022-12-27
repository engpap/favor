library globals;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:project/functions/favorColors.dart' as favorColors;

/// FAVOR
// TODO: il suo valore essere ritornato dal server
String heading = "Heading di Ping Pong";
// TODO: il suo valore essere ritornato dal server
String information =
    "Questo favor riguarda il ping pong, il piru piru e altre belle cose." +
    "\nQuesto favor riguarda il ping pong, il piru piru e altre belle cose." +
    "\nQuesto favor riguarda il ping pong, il piru piru e altre belle cose.";

/// PERSON
// TODO: il suo valore essere ritornato dal server
String personImage = "assets/images/chris.jpg";
String personName = "Marta Heading";
String personRole = "Provider";
// TODO: il suo valore essere ritornato dal server
String informationPerson =
    "Sono Marta e sono una professionista di ping pong, nel tempo libero faccio il business." +
    "\nSono Marta e sono una professionista di ping pong, nel tempo libero faccio il business.";

// TODO: il suo valore essere ritornato dal server
DateTime startTime = DateTime.parse('1969-07-20 06:00:04Z'); // 6:00am
DateTime endTime = DateTime.parse('1969-07-20 20:18:04Z'); // 8:18pm

// https://stackoverflow.com/questions/16126579/how-do-i-format-a-date-with-dart
final DateFormat formatter = DateFormat('Hm');

// TODO: il suo valore essere ritornato dal server
String area = "Via della via, n. num, city A";

// TODO: colors based on the number of stars, data retrieved from server
List<Color> starsColor = [
  Colors.black,
  Colors.black,
  Colors.black,
  Colors.black,
  Colors.black
];

// given the starting list starsColor anf the number of starsNumber, return a list with the color of the stars
List<Color> updateStarsColor(List<Color> starsColor, int starsNumber) {
  int i = 0;
  while (starsNumber > 0) {
    starsColor[i] = favorColors.Yellow;
  }
  return starsColor;
}

String personRating = "42.300";
