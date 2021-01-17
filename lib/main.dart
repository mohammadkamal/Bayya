import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ShoppingListItem.dart';

void main() {
  runApp(MaterialApp(
    title: 'Bayya',
    home: ShoppingList(
      products: <Product>[
        Product(
            id: 0,
            name: 'Blue jeans',
            shortDescription: 'Blue jeans for men',
            longDescription: 'Blue jeans for men available at all sizes',
            category: ProductCategory.clothes,
            price: 50),
        Product(
            id: 1,
            name: 'LED TV',
            shortDescription: 'Television with LED screen',
            longDescription: '20-inch monitor with HD quality display',
            category: ProductCategory.elctronics,
            price: 1100),
        Product(
            id: 2,
            name: 'Chocolate jar',
            shortDescription: 'Jar contatins chocolate mixture',
            longDescription: 'One liter jar filled with chocolate mixture',
            category: ProductCategory.food,
            price: 12)
      ],
    ),
  ));
}

class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Shopping List')),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: widget.products.map((Product product) {
            return ShoppingListItem(
                product: product,
                inCart: _shoppingCart.contains(product),
                onCartChanged: _handleCartChanged);
          }).toList(),
        ));
  }
}
