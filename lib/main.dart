import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ShoppingListItem.dart';

void main() {
  runApp(MaterialApp(
    title: 'Bayya',
    home: ShoppingList(
      products: <Product>[
        Product(
            name: 'Egg',
            shortDescription: 'Chicken product',
            longDescription: 'Chicken product',
            category: ProductCategory.food,
            price: 1.0),
        Product(
            name: 'Flour',
            shortDescription: 'Grain product',
            longDescription: 'Powder made by grinding raw grains',
            category: ProductCategory.food,
            price: 5),
        Product(
            name: 'Chocolate chips',
            shortDescription: 'Sweet product',
            longDescription:
                'Preparation of roasted and ground cacao seeds that is made in the form of bricks',
            category: ProductCategory.food,
            price: 2)
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
