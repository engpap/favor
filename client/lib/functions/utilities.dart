import 'package:flutter/material.dart';

class Utilities {
  /// Given the DateTime object, it returns its string representation
  /// of hourd and minutes.
  static String getHoursAndMinutes(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    return "$hour:$minute";
  }

  /// Capitalize the first letter of each word in the Text string.
  /// If the Text string is empty, then it simply returns the input data without
  /// doing anything.
  static Text capitalizeFirstWordsLetter(Text textObject) {
    String? textString = textObject.data;
    if (textString != null) {
      if (textString.length == 0) return textObject;
      List<String> words = textString.split(" ");
      for (int i = 0; i < words.length; i++) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
      String capitalizedText = words.join(" ");
      return Text(capitalizedText, style: textObject.style);
    } else
      throw Exception("Text data cannot be null!");
  }
}
