import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/userProvider.dart';

void main() {
  convertToStringIntMap_ShouldWorkCorrectly();
  convertIntoUserScoreMap_ShouldWorkCorrectly();
}

void convertToStringIntMap_ShouldWorkCorrectly() {
  group("convertToStringIntMap method should work correctly", () {
    test('convertToStringIntMap should convert valid input correctly', () {
      List<dynamic> input = [
        {
          'user': {'name': 'Carlo', 'surname': 'Rossi'},
          'score': 10
        },
        {
          'user': {'name': 'Marco', 'surname': 'Verdi'},
          'score': 20
        }
      ];
      Map<String, int> expected = {'Carlo Rossi': 10, 'Marco Verdi': 20};
      expect(Leaderboard.convertToStringIntMap(input), expected);
    });
    test(
        'convertToStringIntMap should handle input with missing name or missing surname fields',
        () {
      List<dynamic> input = [
        {
          'user': {'name': 'Carlo'},
          'score': 10
        },
        {
          'user': {'surname': 'Rossi'},
          'score': 20
        }
      ];
      Map<String, int> expected = {'Carlo ': 10, ' Rossi': 20};
      expect(Leaderboard.convertToStringIntMap(input), expected);
    });

    test(
        'convertToStringIntMap should handle input trhowing an exception with missing name and surname fields',
        () {
      List<dynamic> input = [
        {
          'user': {'name': ''},
          'score': 10
        },
        {'user': {}, 'score': 20}
      ];
      expect(() => Leaderboard.convertToStringIntMap(input), throwsException);
    });
  });
}

void convertIntoUserScoreMap_ShouldWorkCorrectly() {
  group("convertIntoUserScoreMap method should work correctly", () {
    test(
        "Throws an error when input list contains an element without 'score' key",
        () {
      var input = [
        {
          'user': {
            '_id': '0',
            'name': 'Alice',
            'surname': 'Rossi',
            'profilePicture': '$noProfilePicture64String'
          },
        },
      ];
      expect(() => Leaderboard.convertIntoUserScoreMap(input),
          throwsNoSuchMethodError);
    });

    test(
        "Throws an exception when input list contains an element without 'user' key",
        () {
      var input = [
        {
          'score': 20,
        },
      ];
      expect(() => Leaderboard.convertIntoUserScoreMap(input), throwsException);
    });

    test(
        "Throws an exception when input list containsan element with a non-integer score",
        () {
      var input = [
        {
          'user': {
            '_id': '0',
            'surname': 'Rossi',
            'profilePicture': '$noProfilePicture64String'
          },
          'score': 2.289,
        },
      ];
      expect(() => Leaderboard.convertIntoUserScoreMap(input), throwsException);
    });
  });
}
