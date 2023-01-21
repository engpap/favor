import 'package:flutter/cupertino.dart';

class FeedUtilities {
  static AssetImage getFavorCategoryImage(String categoryName) {
    print(">>>>>> " + categoryName);
    switch (categoryName) {
      case "Dog Sitting":
        return AssetImage("assets/images/favor_categories/dog_sitting.png");
      case "Baby Sitting":
        return AssetImage("assets/images/favor_categories/baby_sitting.png");
      case "Home Repair":
        return AssetImage("assets/images/favor_categories/home_repair.png");
      case "Home Cleaning":
        return AssetImage("assets/images/favor_categories/home_cleaning.png");
      case "Outdoor Cleaning":
        return AssetImage(
            "assets/images/favor_categories/outdoor_cleaning.png");
      case "Bring me that":
        return AssetImage("assets/images/favor_categories/bring_me_that.png");
      case "Cooking":
        return AssetImage("assets/images/favor_categories/cooking.png");
      case "Tech Repair":
        return AssetImage("assets/images/favor_categories/tech_repair.png");
      case "Take me there":
        return AssetImage("assets/images/favor_categories/take_me_there.png");
      default:
        return AssetImage("assets/images/favor_categories/no_category.png");
    }
  }
}
