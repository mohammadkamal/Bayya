import 'package:Bayya/ShoppingListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShoppingCartItem extends StatelessWidget {
  ShoppingCartItem({this.product, this.inCart});
  final Product product;
  final bool inCart;

  Container titleSection() {
    return Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(product.shortDescription)
              ],
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
          color: Colors.white),
      child: Column(
        children: [
          titleSection(),
          Row(
            children: [Text('Price: ' + product.price.toString() + ' EGP')],
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
          ),
        ],
      ),
    );
  }
}

class ShoppingCartList extends StatefulWidget {
  ShoppingCartList({this.target});

  final Product target;
  @override
  State<ShoppingCartList> createState() => _ShoppingCartListState();
}

class _ShoppingCartListState extends State<ShoppingCartList> {
  Set<Product> _shopCart = Set<Product>();

  void _handleCartChanged(Product product) {
    setState(() {
      if (!_shopCart.contains(product)) {
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
          children: _shopCart.isNotEmpty
              ? _shopCart.map((Product product) {
                  return ShoppingCartItem(
                    product: product,
                    inCart: _shopCart.contains(product),
                  );
                }).toList()
              : []),
    );
  }
}
