import 'dart:convert';

class FavorConstants {
  List<String> _userTypes;
  List<String> _favorCategories;
  List<String> _locations;

  FavorConstants({
    required userTypes,
    required favorCategories,
    required locations,
  })  : _userTypes = userTypes,
        _favorCategories = favorCategories,
        _locations = locations;

  FavorConstants.fromMap(Map<String, dynamic> json)
      : _userTypes =
            (jsonDecode(json['USER_TYPES']) as List<dynamic>).cast<String>(),
        _favorCategories =
            (jsonDecode(json['FAVOR_CATEGORIES']) as List<dynamic>)
                .cast<String>(),
        _locations =
            (jsonDecode(json['LOCATIONS']) as List<dynamic>).cast<String>();

  factory FavorConstants.fromJson(String source) =>
      FavorConstants.fromMap(json.decode(source));

  List<String> get userTypes => _userTypes;
  List<String> get favorCategories => _favorCategories;
  List<String> get locations => _locations;
}
