import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'dart:convert';

List<Text> convertJsonToTextList(String source, String fieldName) {
  var list = jsonDecode(source)[fieldName];
  List<String> stringList = List.from(list);
  return convertToTextList(stringList);
}

List<Text> convertToTextList(List<String> source) {
  List<Text> result = [];
  for (String string in source) {
    result.add(Text(string));
  }
  return result;
}

Map<String, int> convertToStringIntMap(List<dynamic> list) {
  Map<String, int> result = {};
  for (var element in list) {
    String userId = element['user'];
    int score = element['score'].toInt();
    result[userId] = score;
  }
  return result;
}
