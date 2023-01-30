import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/providers/user_provider.dart';

void main() {
  group('CallerPost', () {
    test('CallerPost can be created from JSON', () {
      final Map<String, dynamic> json = {
        "_id": "123",
        "creatorId": "456",
        "name": "Test",
        "surname": "User",
        "email": "test@email.com",
        "profilePicture": noProfilePicture64String,
        "createdAt": "2011-10-05T14:48:00.000Z",
        "userType": "caller",
        "taskCategory": "test",
        "location": "test location",
        "favorStartTime": "2011-10-05T14:48:00.000Z",
        "description": "test description",
        "averageRatings": 4,
        "rankingPosition": 23,
        "rankingLocation": "LORETO",
        "bio": "test bio"
      };
      final CallerPost callerPost = CallerPost.fromJson(json);

      expect(callerPost.id, equals("123"));
      expect(callerPost.creatorId, equals("456"));
      expect(callerPost.name, equals("Test"));
      expect(callerPost.surname, equals("User"));
      expect(callerPost.email, equals("test@email.com"));
      expect(callerPost.profilePicture, isA<Image>());
      expect(callerPost.createdAt, equals("2011-10-05T14:48:00.000Z"));
      expect(callerPost.userType, equals("caller"));
      expect(callerPost.taskCategory, equals("test"));
      expect(callerPost.location, equals("test location"));
      expect(callerPost.favorStartTime,
          equals(DateTime.parse("2011-10-05T14:48:00.000Z")));
      expect(callerPost.description, equals("test description"));
      expect(callerPost.averageRatings, equals(4));
      expect(callerPost.rankingPosition, equals(23));
      expect(callerPost.rankingLocation, equals("LORETO"));
      expect(callerPost.bio, equals("test bio"));
    });

    test('CallerPost cannot be created if given invalid JSON', () {
      final Map<String, dynamic> invalidJson = {
        "_id": "123",
        "creatorId": "456",
        "email": "test@email.com",
        "createdAt": "2011-10-05T14:48:00.000Z",
        "userType": "provider",
        "taskCategory": "test",
      };
      expect(() => CallerPost.fromJson(invalidJson), throwsA(isA<Error>()));
    });
  });
}
