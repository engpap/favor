import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:project/models/favorCategories.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/profileConstants.dart';
import 'package:project/services/constantsService.dart';

class ConstantsServiceMock extends Mock implements ConstantsService {
  Future<ProfileConstants> getProfileConstants() async {
    return ProfileConstants(
      genders: [Text("Male"), Text("Female")],
      ages: [Text("18"), Text("20")],
      cities: [Text("Milan"), Text("Naples")],
      jobs: [Text("Software Developer"), Text("Accountant")],
    );
  }

  Future<FavorCategories> getFavorCategories() async {
    return FavorCategories(
        favorCategories: ["Outdoor Cleaning", "Home Cleaning"]);
  }

  Future<FavorConstants> getFavorConstants() async {
    return FavorConstants(userTypes: [
      Text("provider"),
      Text("caller"),
    ], favorCategories: [
      Text("Outdoor Cleaning"),
      Text("Home Cleaning")
    ], locations: [
      Text("Lambrate"),
      Text("Dergano")
    ]);
  }
}
