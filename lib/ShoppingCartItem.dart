import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Product.dart';

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
