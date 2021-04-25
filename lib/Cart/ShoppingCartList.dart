import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/Cart/ShoppingCartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartList extends StatefulWidget {
  @override
  _ShoppingCartListState createState() => _ShoppingCartListState();
}

class _ShoppingCartListState extends State<ShoppingCartList> {
  bool _isCartempty = true;

  Widget _listOfProducts() {
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children:
            Provider.of<ShoppingCart>(context).shoppingItemQuantites.isNotEmpty
                ? Provider.of<ShoppingCart>(context)
                    .shoppingItemQuantites
                    .keys
                    .map((e) {
                    return ShoppingCartItem(productId: e);
                  }).toList()
                : []);
  }

  Widget _proceedButton() {
    if (!_isCartempty) {
      return FloatingActionButton.extended(
          onPressed: null,
          label: Text(
            'Proceed to checkout',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.lightGreen[500]);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ShoppingCart>(context).shoppingItemQuantites.isEmpty) {
      _isCartempty = true;
    } else {
      _isCartempty = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Container(color: Colors.grey, child: _listOfProducts()),
      floatingActionButton: _proceedButton()
    );
  }
}
