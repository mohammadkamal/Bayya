import 'package:Bayya/ShoppingCart.dart';
import 'package:Bayya/SideBar.dart';
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

class ShoppingList extends StatelessWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Bayya Shopping List',
        )),
        drawer: AppSideBar(),
        body: Container(
            color: Colors.grey,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: this.products.map((Product product) {
                return ShoppingListItem(
                    product: product
                    );
              }).toList(),
            )));
  }

}
