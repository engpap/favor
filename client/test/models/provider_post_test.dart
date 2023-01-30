import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/providers/user_provider.dart';

void main() {
  group('ProviderPost', () {
    test('ProviderPost can be created from JSON', () {
      final Map<String, dynamic> json = {
        "_id": "123",
        "creatorId": "456",
        "name": "Test",
        "surname": "User",
        "email": "test@email.com",
        "profilePicture": noProfilePicture64String,
        "createdAt": "2011-10-05T14:48:00.000Z",
        "userType": "provider",
        "taskCategory": "test",
        "location": "test location",
        "favorStartTime": "2011-10-05T14:48:00.000Z",
        "availabilityStartTime": "2011-10-05T14:48:00.000Z",
        "availabilityEndTime": "2011-10-05T14:48:00.000Z",
        "description": "test description",
        "averageRatings": 4,
        "rankingPosition": 23,
        "rankingLocation": "LORETO",
        "bio": "test bio"
      };
      final ProviderPost providerPost = ProviderPost.fromJson(json);

      expect(providerPost.id, equals("123"));
      expect(providerPost.creatorId, equals("456"));
      expect(providerPost.name, equals("Test"));
      expect(providerPost.surname, equals("User"));
      expect(providerPost.email, equals("test@email.com"));
      expect(providerPost.profilePicture, isA<Image>());
      expect(providerPost.createdAt, equals("2011-10-05T14:48:00.000Z"));
      expect(providerPost.userType, equals("provider"));
      expect(providerPost.taskCategory, equals("test"));
      expect(providerPost.location, equals("test location"));
      expect(providerPost.availabilityStartTime,
          equals(DateTime.parse("2011-10-05T14:48:00.000Z")));
      expect(providerPost.availabilityEndTime,
          equals(DateTime.parse("2011-10-05T14:48:00.000Z")));
      expect(providerPost.description, equals("test description"));
      expect(providerPost.averageRatings, equals(4));
      expect(providerPost.rankingPosition, equals(23));
      expect(providerPost.rankingLocation, equals("LORETO"));
      expect(providerPost.bio, equals("test bio"));
    });

    test('ProviderPost cannot be created if given invalid JSON', () {
      final Map<String, dynamic> invalidJson = {
        "_id": "123",
        "creatorId": "456",
        "email": "test@email.com",
        "createdAt": "2011-10-05T14:48:00.000Z",
        "userType": "caller",
        "taskCategory": "test",
      };
      expect(() => ProviderPost.fromJson(invalidJson), throwsA(isA<Error>()));
    });
  });
}
