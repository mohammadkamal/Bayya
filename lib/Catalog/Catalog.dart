import 'dart:collection';
import 'dart:math';

import 'package:Bayya/Product/Product.dart';
import 'package:flutter/foundation.dart';

class Catalog extends ChangeNotifier {
  List<Product> _productsList = new List<Product>();

  UnmodifiableListView<Product> get productsList =>
      UnmodifiableListView(_productsList);

  Map<int, Product> _productsCatalog = new Map<int, Product>();

  UnmodifiableMapView<int, Product> get productsCatalog =>
      UnmodifiableMapView(_productsCatalog);

  void addProduct(Product product) {
    _productsList.add(product);
    _productsCatalog[generateProductID()] = product;
    notifyListeners();
  }

  void removeProduct(Product product) {
    _productsList.remove(product);
    notifyListeners();
  }

  void removeProductInt(int id) {
    _productsCatalog.remove(id);
    notifyListeners();
  }

  int generateProductID() {
    Random random = new Random();
    int generatedID = random.nextInt(5000);

    if (_productsCatalog.containsKey(generatedID)) {
      while (_productsCatalog.containsKey(generatedID)) {
        generatedID = random.nextInt(5000);
      }
    }

    return generatedID;
  }
}
