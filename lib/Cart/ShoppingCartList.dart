import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/Cart/ShoppingCartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Container(
          color: Colors.grey,
          child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children:
                  context.read<ShoppingCart>().shoppingItemQuantites.isNotEmpty
                      ? context
                          .read<ShoppingCart>()
                          .shoppingItemQuantites
                          .keys
                          .map((e) {
                          return ShoppingCartItem(productId: e);
                        }).toList()
                      : [])),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: null,
          label: Text(
            'Proceed to checkout',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.lightGreen[500]),
    );
  }
}
