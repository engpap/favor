import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/favorCategories.dart';

void main() {
  group('FavorCategories', () {
    test('Create FavorCategories from required parameters', () {
      var favorCategories = FavorCategories(
        favorCategories: ['Test1', 'Test2'],
      );

      expect(favorCategories.favorCategories, ['Test1', 'Test2']);
    });

    test('Create FavorCategories from json string', () {
      var json = '["Test1", "Test2"]';
      var favorCategories = FavorCategories.fromJson(json);

      expect(favorCategories.favorCategories, ['Test1', 'Test2']);
    });

    test('Convert json string to list of strings', () {
      var json = '["Test1", "Test2"]';
      var result = convertJsonToStringList(json);

      expect(result, ['Test1', 'Test2']);
    });
  });
}
