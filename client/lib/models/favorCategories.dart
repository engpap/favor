import 'dart:convert';

class FavorCategories {
  List<String> _favorCategories;

  FavorCategories({
    required favorCategories,
  }) : _favorCategories = favorCategories;

  FavorCategories.fromMap(String json)
      : _favorCategories = convertJsonToStringList(json);

  factory FavorCategories.fromJson(String source) =>
      FavorCategories.fromMap(source);

  List<String> get favorCategories => _favorCategories;
}

List<String> convertJsonToStringList(String source) {
  var list = jsonDecode(source);
  List<String> stringList = List.from(list);
  return stringList;
}
