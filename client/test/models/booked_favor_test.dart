import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/providers/user_provider.dart';

void main() {
  test("BookedFavor.fromJson works correctly", () {
    var jsonPost = {
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
    final Map<String, dynamic> source = {
      "_id": "1",
      "bookedAt": "2022-01-01T00:00:00.000Z",
      "providerId": "p1",
      "callerId": "c1",
      "post": jsonPost,
    };

    final BookedFavor bookedFavor = BookedFavor.fromJson(source);
    expect(bookedFavor.id, "1");
    expect(bookedFavor.bookedAt, DateTime.parse("2022-01-01T00:00:00.000Z"));
    expect(bookedFavor.providerId, "p1");
    expect(bookedFavor.callerId, "c1");
    expect(bookedFavor.post, isA<CallerPost>());
  });
}
