import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:project/providers/user_provider.dart';

void main() {
  userSetGetClearMethods_ShouldWorkCorrectly();
  googleClientSetGetMethods_ShouldWorkCorrectly();
}

void userSetGetClearMethods_ShouldWorkCorrectly() {
  group('userSetGetClearMethods should work correctly', () {
    UserProvider userProvider = UserProvider();

    test('Get user before set', () {
      expect(userProvider.user, null);
    });

    test('Set user with missing information throws exception', () {
      expect(() => userProvider.setUser('{"name": "Marco"}'), throwsException);
    });

    test('Set user without missing information and then get user', () {
      userProvider.setUser(
          '{"_id": "x","name": "Marco","surname":"Rossi","profilePicture":"$noProfilePicture64String"}');
      expect(userProvider.user!.id, 'x');
      expect(userProvider.user!.name, 'Marco');
      expect(userProvider.user!.surname, 'Rossi');
      expect(userProvider.user!.profilePicture.bytes,
          MemoryImage(base64Decode(noProfilePicture64String)).bytes);
    });

    test('Clear user', () {
      userProvider.setUser(
          '{"_id": "x","name": "Marco","surname":"Rossi","profilePicture":"$noProfilePicture64String"}');
      userProvider.clearUser();
      expect(userProvider.user, null);
    });
  });
}

void googleClientSetGetMethods_ShouldWorkCorrectly() {
  group("Set/Get google client methods should work correctly", () {
    UserProvider userProvider = UserProvider();
    http.Client googleClient = http.Client();
    test('Get google client before initializing it', () {
      expect(userProvider.getGoogleClient(), null);
    });

    test('Set google client', () {
      userProvider.setGoogleClient(googleClient);
      expect(userProvider.getGoogleClient(), googleClient);
    });
  });
}
