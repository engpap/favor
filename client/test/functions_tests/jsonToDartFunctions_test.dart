import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/functions/jsonToDartFunctions.dart';

import '../utility/comparators.dart';

void main() {
  convertJsonToTextList_ShouldWorkCorrectly();
  convertStringListToTextList_ShouldWorkCorrectly();
}

void convertJsonToTextList_ShouldWorkCorrectly() {
  group("convertJsonToTextListShould method works correctly", () {
    test('convertJsonToTextList returns correct list', () {
      var jsonSource = '{"fieldName": ["value1", "value2"]}';
      var expected = [Text('value1'), Text('value2')];
      var result = convertJsonToTextList(jsonSource, 'fieldName');
      expect(textListEquals(result, expected), true);
    });

    test('convertJsonToTextList handles empty json', () {
      var jsonSource = '{}';
      var expected = [];
      var result = convertJsonToTextList(jsonSource, 'fieldName');
      expect(result, expected);
    });

    test('convertJsonToTextList handles missing field', () {
      var jsonSource = '{"fieldName": ["value1", "value2"]}';
      var expected = [];
      var result = convertJsonToTextList(jsonSource, 'missingField');
      expect(result, expected);
    });

    test('convertJsonToTextList returns correct list with invalid json', () {
      var jsonSource = '{invalid json';
      var expected = [];
      var result = convertJsonToTextList(jsonSource, 'fieldName');
      expect(result, expected);
    });
  });
}

void convertStringListToTextList_ShouldWorkCorrectly() {
  group("convertStringListToTextList method works correctly", () {
    test('Convert string list to text list', () {
      List<String> source = ['Hello', 'World'];
      List<Text> expected = [Text('Hello'), Text('World')];

      List<Text> result = convertStringListToTextList(source);

      expect(textListEquals(result, expected), true);
    });

    test('Convert empty string list to empty text list', () {
      List<String> source = [];
      List<Text> expected = [];
      List<Text> result = convertStringListToTextList(source);
      expect(textListEquals(result, expected), true);
    });
  });
}
