import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/favorConstants.dart';

import '../utility_for_testing/comparators.dart';

void main() {
  group('FavorConstants', () {
    test('Create FavorConstantsject from json string', () {
      var json = '''{
        "USER_TYPES": ["Test1", "Test2"],
        "FAVOR_CATEGORIES": ["Test3", "Test4"],
        "LOCATIONS": ["Test5", "Test6"]
      }''';
      var favorConstants = FavorConstants.fromJson(json);

      expect(
          textListEquals(
              favorConstants.userTypes, [Text('Test1'), Text('Test2')]),
          true);
      expect(
          textListEquals(
              favorConstants.favorCategories, [Text('Test3'), Text('Test4')]),
          true);
      expect(
          textListEquals(
              favorConstants.locations, [Text('Test5'), Text('Test6')]),
          true);
    });

    test('Convert json string to list of Text', () {
      var json = '''{
        "USER_TYPES": ["Test1", "Test2"],
        "FAVOR_CATEGORIES": ["Test3", "Test4"],
        "LOCATIONS": ["Test5", "Test6"]
      }''';
      var result = convertJsonToTextList(json, 'USER_TYPES');

      expect(textListEquals(result, [Text('Test1'), Text('Test2')]), true);
    });
  });
}
