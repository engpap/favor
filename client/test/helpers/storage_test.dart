import 'package:flutter_test/flutter_test.dart';
import 'package:project/helpers/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  tokenRelatedStorageMethods_ShouldWorkCorrectly();
  userIdRelatedStorageMethods_ShouldWorkCorrectly();
}

void tokenRelatedStorageMethods_ShouldWorkCorrectly() {
  group("Token set/get/remove methods", () {
    test('Token not found scenario', () async {
      await SharedPreferences.getInstance();
      expect(await Storage.getUserToken(), Storage.TOKEN_NOT_FOUND);
    });
    test('Valid token retrieval', () async {
      SharedPreferences.setMockInitialValues({'token': 'valid_token'});
      expect(await Storage.getUserToken(), 'valid_token');
    });

    test('Set token', () async {
      var prefs = await SharedPreferences.getInstance();
      await Storage.setUserToken('new_token');
      expect(prefs.getString('token'), 'new_token');
    });

    /*
    test('Token removal through SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({'token': 'valid_token'});
      var prefs = await SharedPreferences.getInstance();
      await Storage.removeToken();
      expect(prefs.getString('token'), null);
    });

    test('Token removal through Storage', () async {
      SharedPreferences.setMockInitialValues({'token': 'valid_token'});
      await Storage.removeToken();
      expect(await Storage.getUserToken(), Storage.TOKEN_NOT_FOUND);
    });*/
  });
}

void userIdRelatedStorageMethods_ShouldWorkCorrectly() {
  group("UserID set/remove methods", () {
    test('Set userId in storage', () async {
      var prefs = await SharedPreferences.getInstance();
      await Storage.setUserId('new_userId');
      expect(prefs.getString('userId'), 'new_userId');
    });
    test('userId removal', () async {
      SharedPreferences.setMockInitialValues({'userId': 'valid_userId'});
      var prefs = await SharedPreferences.getInstance();
      await Storage.removeUserId();
      expect(prefs.getString('userId'), null);
    });
  });
}
