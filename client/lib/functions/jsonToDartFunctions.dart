import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:project/models/user.dart';

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
    Map<String, dynamic> user = element['user'];
    int score = element['score'].toInt();
    result["${user['name']} ${user['surname']}"] = score;
    //result[userId] = score;
  }
  return result;
}

Map<User, int> convertIntoUserScoreMap(List<dynamic> list) {
  Map<User, int> result = {};
  for (var element in list) {
    int score = element['score'].toInt();
    result[User.fromMap(element['user'])] = score;
    //result[userId] = score;
  }
  return result;
}
