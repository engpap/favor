import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../functions/jsonToDartFunctions.dart';

class FavorConstants {
  List<Text> _userTypes;
  List<Text> _favorCategories;
  List<Text> _locations;

  FavorConstants({
    required userTypes,
    required favorCategories,
    required locations,
  })  : _userTypes = userTypes,
        _favorCategories = favorCategories,
        _locations = locations;

  FavorConstants.fromMap(String json)
      : _userTypes = convertJsonToTextList(json, 'USER_TYPES'),
        _favorCategories = convertJsonToTextList(json, 'FAVOR_CATEGORIES'),
        _locations = convertJsonToTextList(json, 'LOCATIONS');

  factory FavorConstants.fromJson(String source) =>
      FavorConstants.fromMap(source);

  List<Text> get userTypes => _userTypes;
  List<Text> get favorCategories => _favorCategories;
  List<Text> get locations => _locations;
}

List<Text> convertJsonToTextList(String source, String fieldName) {
  var list = jsonDecode(source)[fieldName];
  List<String> stringList = List.from(list);
  return convertToTextList(stringList);
}
