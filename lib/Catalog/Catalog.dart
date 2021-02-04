import 'dart:collection';

import 'package:Bayya/Product/Product.dart';
import 'package:flutter/foundation.dart';

class Catalog extends ChangeNotifier {
  List<Product> _productsList = new List<Product>();

  UnmodifiableListView<Product> get productsList =>
      UnmodifiableListView(_productsList);

  void addProduct(Product product) {
    _productsList.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _productsList.remove(product);
  }
}
