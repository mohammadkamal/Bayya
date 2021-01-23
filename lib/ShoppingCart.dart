import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Product.dart';
import 'ShoppingCartItem.dart';

class ShoppingCart {
  ShoppingCart._privateConstructor();

  static final ShoppingCart _instance = ShoppingCart._privateConstructor();

  static ShoppingCart get instance => _instance;

  Map<int, Product> shoppingCartMap = new Map<int, Product>();

  void addToShoppingCart(Product product) {
    shoppingCartMap[product.id] = product;
  }

  void removeFromShoppingCart(Product product) {
    shoppingCartMap.remove(product.id);
  }

  bool isInShoppingCart(Product product) {
    return shoppingCartMap.containsKey(product.id);
  }
}

class ShoppingCartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> _shopList = List();
    ShoppingCart.instance.shoppingCartMap
        .forEach((key, value) => _shopList.add(value));
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _shopList.isNotEmpty
              ? _shopList.map((Product product) {
                  return ShoppingCartItem(
                    product: product,
                    inCart: _shopList.contains(product),
                  );
                }).toList()
              : []),
    );
  }
}
