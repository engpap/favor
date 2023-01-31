import 'package:flutter/material.dart';

class ExploreQuery with ChangeNotifier {
  TextEditingController searchBarTextController = TextEditingController();

  TextEditingController get controller => searchBarTextController;
  String get text => searchBarTextController.text;

  void update(String newQuery) {
    searchBarTextController.text = newQuery;
    notifyListeners();
  }
  void clear(){
    searchBarTextController.clear();
  }
}
