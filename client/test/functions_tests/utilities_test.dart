import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/functions/utilities.dart';

void main() {
  getHoursAndMinutes_ShouldWorkCorrectly();
  capitalizeFirstWordsLetter_ShouldWorkCorrectly();
}

void getHoursAndMinutes_ShouldWorkCorrectly() {
  group('getHoursAndMinutes method should work correctly', () {
    test("Edge values", () {
      DateTime dateTime = new DateTime(1, 1, 1, 0, 0);
      expect(Utilities.getHoursAndMinutes(dateTime), "0:0");
      dateTime = new DateTime(9999, 12, 31, 23, 59);
      expect(Utilities.getHoursAndMinutes(dateTime), "23:59");
    });
  });
}

void capitalizeFirstWordsLetter_ShouldWorkCorrectly() {
  group("capitalizeFirstWordsLetter method should work correctly", () {
    test('capitalizeFirstWordsLetter with single word', () {
      Text text = Text('test');
      Text capitalized = Utilities.capitalizeFirstWordsLetter(text);
      expect(capitalized.data, 'Test');
    });

    test('capitalizeFirstWordsLetter with empty text', () {
      Text text = Text('');
      Text result = Utilities.capitalizeFirstWordsLetter(text);
      expect(result.data, '');
    });

    test('capitalizeFirstWordsLetter with text containing digits', () {
      Text text = Text('this is a test 1');
      Text result = Utilities.capitalizeFirstWordsLetter(text);
      expect(result.data, 'This Is A Test 1');
    });
  });
}
