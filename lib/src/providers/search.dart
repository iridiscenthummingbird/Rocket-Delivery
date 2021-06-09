import 'package:flutter/material.dart';

enum SearchBy { Products, Restaurants }

class SearchProvider with ChangeNotifier {
  SearchBy search = SearchBy.Products;
  String filterBy = "Products";

  void changeSearchBy({SearchBy newSearchBy}) {
    search = newSearchBy;
    if (newSearchBy == SearchBy.Products) {
      filterBy = "Products";
    } else {
      filterBy = "Restaurants";
    }
    notifyListeners();
  }
}
