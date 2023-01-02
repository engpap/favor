import 'dart:convert';

class ProfileConstants {
  List<String> _genders;
  List<String> _cities;
  List<String> _jobs;

  ProfileConstants({
    required genders,
    required cities,
    required jobs,
  })  : _genders = genders,
        _cities = cities,
        _jobs = jobs;

  ProfileConstants.fromMap(Map<String, dynamic> json)
      : _genders = convertJsonToStringList(json['GENDERS']),
        _cities = convertJsonToStringList(json['CITIES']),
        _jobs = convertJsonToStringList(json['JOBS']);

  factory ProfileConstants.fromJson(String source) =>
      ProfileConstants.fromMap(jsonDecode(source));

  List<String> get genders => _genders;
  List<String> get cities => _cities;
  List<String> get jobs => _jobs;
}

List<String> convertJsonToStringList(String source) {
  var list = jsonDecode(source);
  List<String> stringList = List.from(list);
  return stringList;
}
