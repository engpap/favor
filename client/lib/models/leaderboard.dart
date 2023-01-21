import 'package:project/models/user.dart';

class Leaderboard {
  final String userType;
  final String location;
  final Map<User, int> leaderboard;

  Leaderboard({
    required this.userType,
    required this.location,
    required this.leaderboard,
  });

  static Leaderboard customFromMap(Map<String, dynamic> json) {
    return Leaderboard(
        userType: json['userType'],
        location: json['location'],
        leaderboard: convertIntoUserScoreMap(json['users']));
  }

  factory Leaderboard.fromJson(Map<String, dynamic> source) =>
      customFromMap(source);

  /// Convert the json leadearboard ranking, such as
  ///  [ { 'user': "Marco Rossi", 'score': 20 } } ] into a map
  /// of pairs <name, score>.
  /// It handles the case where wither name or surname is not provided,
  /// in that case empty strings are returned. But if both name and surname are
  /// not provided, the it throws an exception.
  static Map<String, int> convertToStringIntMap(List<dynamic> list) {
    Map<String, int> result = {};
    for (var element in list) {
      Map<String, dynamic> user = element['user'];
      int score = element['score'].toInt();
      var name = user['name'] == null ? '' : user['name'];
      var surname = user['surname'] == null ? '' : user['surname'];
      if (name == '' && surname == '')
        throw new Exception(
            "Both name and surname are required, but neither of them is provided.");
      result["$name $surname"] = score;
    }
    return result;
  }

  /// Convert a json string into a map of pairs <User object, integer score>
  static Map<User, int> convertIntoUserScoreMap(List<dynamic> list) {
    Map<User, int> result = {};
    for (var element in list) {
      int score = element['score'].toInt();
      try {
        result[User.fromMap(element['user'])] = score;
      } catch (e) {
        throw new Exception(
            "There is no 'user' key in the provided json string.");
      }
    }
    return result;
  }
}
