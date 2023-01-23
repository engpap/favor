import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project/functions/jsonToDartFunctions.dart';

class ProfileConstants {
  List<Text> _genders;
  List<Text> _ages;
  List<Text> _cities;
  List<Text> _jobs;

  ProfileConstants({
    required genders,
    required ages,
    required cities,
    required jobs,
  })  : _genders = genders,
        _ages = ages,
        _cities = cities,
        _jobs = jobs;

  ProfileConstants.fromMap(String json) //TODO: CHANGE NAME, ITS NOT MAP
      : _genders = convertJsonToTextList(json, 'GENDERS'),
        _ages = convertJsonToTextList(json, 'AGES'),
        _cities = convertJsonToTextList(json, 'CITIES'),
        _jobs = convertJsonToTextList(json, 'JOBS');

  factory ProfileConstants.fromJson(String source) =>
      ProfileConstants.fromMap(source);

  List<Text> get genders => _genders;
  List<Text> get ages => _ages;
  List<Text> get cities => _cities;
  List<Text> get jobs => _jobs;
}

List<String> convertJsonToStringList(String source) {
  var list = jsonDecode(source);
  List<String> stringList = List.from(list);
  return stringList;
}
