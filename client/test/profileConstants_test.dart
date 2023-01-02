import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/profileConstants.dart';
import 'package:project/services/constantsService.dart';

void main() {
  Future<ProfileConstants> future_profileConstants =
      ConstantsService().getProfileConstants();
  test('future list is a list of strings', () async {
    var profileConstants = await future_profileConstants;
    var genders = profileConstants.genders;
    expect(genders, everyElement(isA<String>()));
  });
}
