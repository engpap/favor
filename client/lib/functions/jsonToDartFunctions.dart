import 'package:flutter/cupertino.dart';
import 'dart:convert';

/// If the given json is empty, i.e. {}, then it returns [];
/// If the server return an invalid json, then it returns [];
/// Otherwise, it returns the list of Text objects.
List<Text> convertJsonToTextList(String source, String fieldName) {
  var list;
  try {
    list = jsonDecode(source)[fieldName];
  } catch (e) {
    print("Error decoding json: " + e.toString());
    return [];
  }
  if (list != null) {
    List<String> stringList = List.from(list);
    return convertStringListToTextList(stringList);
  } else
    return [];
}

/// Convert a list of String objects into a list of Text objects
List<Text> convertStringListToTextList(List<String> source) {
  List<Text> result = [];
  for (String string in source) {
    result.add(Text(string));
  }
  return result;
}
