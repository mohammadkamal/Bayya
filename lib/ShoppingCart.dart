import 'package:Bayya/ShoppingListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShoppingCart {
  static Set<int> _productsIDs = Set<int>();

  static void onCartChange(int productID) {
    if (_productsIDs.contains(productID)) {
      _productsIDs.remove(productID);
    } else {
      _productsIDs.add(productID);
    }
  }

  static bool isInCart(int productID) {
    return _productsIDs.contains(productID);
  }
}

class ShoppingCartList extends StatefulWidget {
  ShoppingCartList({Key key, this.productsList}) : super(key: key);

  final List<Product> productsList;
  @override
  State<ShoppingCartList> createState() => _ShoppingCartListState();
}

class _ShoppingCartListState extends State<ShoppingCartList> {
  Set<Product> _shopCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shopCart.add(product);
      } else {
        _shopCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: widget.productsList.map((Product product) {
            return ShoppingListItem(
              product: product,
              inCart: _shopCart.contains(product),
              onCartChanged: _handleCartChanged,
            );
          }).toList()),
    );
  }
}
