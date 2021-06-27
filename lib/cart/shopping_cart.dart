import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ShoppingCart extends ChangeNotifier {
  final Map<String, int> _shoppingItemQuantites = new Map<String, int>();

  UnmodifiableMapView<String, int> get shoppingItemQuantites =>
      UnmodifiableMapView(_shoppingItemQuantites);

  CollectionReference shoppingCartRemote =
      FirebaseFirestore.instance.collection('ShoppingCart');

  void addToShoppingCart(String key) {
    _shoppingItemQuantites[key] = 1;
    update();
    notifyListeners();
  }

  void removeFromShoppingCart(String key) {
    _shoppingItemQuantites.remove(key);
    update();
    notifyListeners();
  }

  bool isInShoppingCart(String key) {
    return _shoppingItemQuantites.containsKey(key);
  }

  void increment(String key) {
    _shoppingItemQuantites[key]++;
    update();
    notifyListeners();
  }

  void decrement(String key) {
    if (_shoppingItemQuantites[key] >= 2) {
      _shoppingItemQuantites[key]--;
    } else {
      _shoppingItemQuantites[key] = 1;
    }
    update();
    notifyListeners();
  }

  int getQuantity(String key) {
    return _shoppingItemQuantites[key];
  }

  void update() {
    shoppingCartRemote
        .doc(FirebaseAuth.instance.currentUser.email)
        .set(_shoppingItemQuantites);
  }

  Future<void> fetchData() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await shoppingCartRemote
        .doc(FirebaseAuth.instance.currentUser.email)
        .get();
    documentSnapshot.data().forEach((key, value) {
      _shoppingItemQuantites[key] = value;
      notifyListeners();
    });
  }
}
