import 'package:flutter/foundation.dart';

class CategoryProvider extends ChangeNotifier {
  List _categories = [];
  bool isLoaded = false;
  String activeCategory = "";
  List _products = [];

  List get getCategories {
    return _categories;
  }

  List get getProducts {
    return _products;
  }

  void setCategories(list) {
    _categories = list;
    notifyListeners();
  }

  void setProducts(list) {
    _products = list;
    notifyListeners();
  }
}
