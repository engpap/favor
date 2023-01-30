import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/post.dart';
import 'package:project/providers/user_provider.dart';

void main() {
  group('Post class', () {
    test('getUserTypeGivenJsonString returns correct userType from Map', () {
      final Map<String, dynamic> jsonCaller = {
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

      expect("caller", Post.getUserTypeGivenJsonString(jsonCaller));

      final Map<String, dynamic> jsonProvider = {
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
        "description": "test description",
        "averageRatings": 4,
        "rankingPosition": 23,
        "rankingLocation": "LORETO",
        "bio": "test bio"
      };

      expect("provider", Post.getUserTypeGivenJsonString(jsonProvider));
    });
  });
}
