import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utilities {
  static String replaceEmptySpaceWithNewline(String input) {
    List<String> words = input.split(" ");
    String output = "";
    if (words.length <= 2) {
      // Replace spaces with newlines
      output = input.replaceAll(" ", "\n");
    } else {
      // Replace spaces with newlines every two words
      for (int i = 0; i < words.length; i += 2) {
        output += words[i];
        if (i + 1 < words.length) {
          output += " " + words[i + 1] + "\n";
        }
      }
    }
    return output;
  }

  static String getHoursAndMinutes(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    return "$hour:$minute";
  }

  static String capitalizeWords(String input) {
    return input
        .split(" ")
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(" ");
  }

  static String getNthWord(String input, int n) {
    List<String> words = input.split(" ");
    if (n > words.length) {
      return "Invalid input: n is larger than the number of words in the string.";
    }
    return words[n - 1];
  }

  static Text capitalizeFirstWordsLetter(Text textObject) {
    String? textString = textObject.data;
    if (textString != null) {
      List<String> words = textString.split(" ");
      for (int i = 0; i < words.length; i++) {
        words[i] =
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
      String capitalizedText = words.join(" ");
      return Text(capitalizedText, style: textObject.style);
    } else
      throw Exception("Text dat cannot be null!");
  }
}
