import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/profileConstants.dart';
import '../utility_for_testing/comparators.dart';

void main() {
  group('ProfileConstants', () {
    test('Create Profile constants from json string', () {
      final json = '''
      {
        "GENDERS": ["Male", "Female"],
        "AGES": ["18", "23"],
        "CITIES": ["City1", "City2"],
        "JOBS": ["Job1", "Job2"]
      }
      ''';
      final profileConstants = ProfileConstants.fromJson(json);
      expect(
          textListEquals(
              profileConstants.genders, [Text('Male'), Text('Female')]),
          true);
      expect(textListEquals(profileConstants.ages, [Text('18'), Text('23')]),
          true);
      expect(
          textListEquals(
              profileConstants.cities, [Text('City1'), Text('City2')]),
          true);
      expect(
          textListEquals(profileConstants.jobs, [Text('Job1'), Text('Job2')]),
          true);
    });

    group('convertJsonToStringList', () {
      test('Conversion JSON to string list', () {
        final json = '["a", "b", "c"]';
        final stringList = convertJsonToStringList(json);
        expect(stringList, ['a', 'b', 'c']);
      });
    });
  });
}
