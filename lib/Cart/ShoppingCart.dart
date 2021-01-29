import 'dart:collection';

import 'package:Bayya/Product/Product.dart';
import 'package:flutter/foundation.dart';

class ShoppingCart extends ChangeNotifier {
  final Map<int, Product> _shoppingCartMap = new Map<int, Product>();
  final Map<int, int> _shoppingItemQuantites = new Map<int, int>(); //Product id & quantity

  UnmodifiableMapView<int, Product> get shoppingCartMap =>
      UnmodifiableMapView(_shoppingCartMap);
  UnmodifiableMapView<int, int> get shoppingItemQuantites =>
      UnmodifiableMapView(_shoppingItemQuantites);

  void addToShoppingCart(Product product) {
    _shoppingCartMap[product.id] = product;
    _shoppingItemQuantites[product.id] = 1;
    notifyListeners();
  }

  void removeFromShoppingCart(Product product) {
    _shoppingCartMap.remove(product.id);
    _shoppingItemQuantites.remove(product.id);
    notifyListeners();
  }

  bool isInShoppingCart(Product product) {
    return _shoppingCartMap.containsKey(product.id);
  }

  void increment(Product product) {
    _shoppingItemQuantites[product.id]++;
    notifyListeners();
  }

  void decrement(Product product) {
    _shoppingItemQuantites[product.id] >= 1
        ? _shoppingItemQuantites[product.id]--
        : _shoppingItemQuantites[product.id] = 1;
    notifyListeners();
  }

  int getQuantity(Product product) {
    return _shoppingItemQuantites[product.id];
  }
}
