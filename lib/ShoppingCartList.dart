import 'package:flutter/material.dart';

import 'Product.dart';
import 'ShoppingCart.dart';
import 'ShoppingCartItem.dart';

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
      body: Container(
          color: Colors.grey,
          child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: _shopList.isNotEmpty
                  ? _shopList.map((Product product) {
                      return ShoppingCartItem(
                        product: product,
                      );
                    }).toList()
                  : [])),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        label: Text(
          'Proceed to checkout',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.lightGreen[500]
      ),
    );
  }
}
