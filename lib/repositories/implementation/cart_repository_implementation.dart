import 'package:bayya/repositories/abstract/cart_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepositoryImplementation implements CartRepository {
  CollectionReference get _cartCollections =>
      FirebaseFirestore.instance.collection('ShoppingCart');

  @override
  Future<Map<String, int>> addProductToShoppingCart(String key) async {
    var _productsQuantities = await fetchShoppingCart();
    _productsQuantities[key] = 1;
    _setProductsQuantities(_productsQuantities);
    return _productsQuantities;
  }

  @override
  Future<Map<String, int>> fetchShoppingCart() async {
    var _document =
        await _cartCollections.doc(FirebaseAuth.instance.currentUser.uid).get();
    Map<String, dynamic> _documentData = _document.data();
    var _productsQuantities = <String, int>{};
    _productsQuantities.addEntries(_documentData.entries);
    return _productsQuantities;
  }

  @override
  Future<Map<String, int>> removeProductFromShoppingCart(String key) async {
    var _productsQuantities = await fetchShoppingCart();
    _productsQuantities.remove(key);
    _setProductsQuantities(_productsQuantities);
    return _productsQuantities;
  }

  @override
  Future<Map<String, int>> updateQuantity(String key, int value) async {
    var _productsQuantities = await fetchShoppingCart();
    _productsQuantities[key] = value;
    _setProductsQuantities(_productsQuantities);
    return _productsQuantities;
  }

  Future<void> _setProductsQuantities(
      Map<String, int> productsQuantities) async {
    await _cartCollections
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(productsQuantities);
  }
}
