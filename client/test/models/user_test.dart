import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/user_provider.dart';

void main() {
  group('User class tests', () {
    final Map<String, dynamic> testJson = {
      '_id': '123',
      'name': 'testname',
      'surname': 'testsurname',
      'profilePicture': noProfilePicture64String,
      'email': 'test@email.com',
      'token': 'token_string',
      'rankingPoints': 100,
      'averageRatings': 4,
      'gender': 'Male',
      'age': 23,
      'city': 'Milan',
      'job': 'Engineer',
      'bio': 'Bio text'
    };

    final String testJsonString = jsonEncode(testJson);

    test('fromMap constructor', () {
      User user = User.fromMap(testJson);
      expect(user.id, '123');
      expect(user.name, 'testname');
      expect(user.surname, 'testsurname');
      expect(user.profilePicture, isA<MemoryImage>());
      expect(user.email, 'test@email.com');
      expect(user.token, 'token_string');
      expect(user.rankingPoints, 100);
      expect(user.averageRatings, 4);
      expect(user.gender, 'Male');
      expect(user.age, 23);
      expect(user.city, 'Milan');
      expect(user.job, 'Engineer');
      expect(user.bio, 'Bio text');
    });

    test('fromJson constructor', () {
      User user = User.fromJson(testJsonString);
      expect(user.id, '123');
      expect(user.name, 'testname');
      expect(user.surname, 'testsurname');
      expect(user.profilePicture, isA<MemoryImage>());
      expect(user.email, 'test@email.com');
      expect(user.token, 'token_string');
      expect(user.rankingPoints, 100);
      expect(user.averageRatings, 4);
      expect(user.gender, 'Male');
      expect(user.age, 23);
      expect(user.city, 'Milan');
      expect(user.job, 'Engineer');
      expect(user.bio, 'Bio text');
    });

    test('Create User without optional fields', () {
      Map<String, dynamic> testJsonWithoutOptionalFields = {
        '_id': '123',
        'name': 'testname',
        'surname': 'testsurname',
        'profilePicture': noProfilePicture64String,
      };
      User user = User.fromMap(testJsonWithoutOptionalFields);
      expect(user.id, '123');
      expect(user.name, 'testname');
      expect(user.surname, 'testsurname');
      expect(user.profilePicture, isA<MemoryImage>());
      expect(user.email, isNull);
      expect(user.token, isNull);
      expect(user.rankingPoints, 0);
      expect(user.averageRatings, 0);
      expect(user.gender, isNull);
      expect(user.age, isNull);
      expect(user.age, isNull);
      expect(user.city, isNull);
      expect(user.job, isNull);
      expect(user.bio, isNull);
    });
  });
}
