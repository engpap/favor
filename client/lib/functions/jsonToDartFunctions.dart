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
