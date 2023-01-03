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
}
