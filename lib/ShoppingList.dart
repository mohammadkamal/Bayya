import 'package:Bayya/Cart/ShoppingCartUpperIcon.dart';
import 'package:flutter/material.dart';
import 'Product.dart';
import 'ShoppingListItem.dart';
import 'SideBar.dart';

class ShoppingList extends StatelessWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Bayya Shopping List',
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.white), onPressed: null),
            ShoppingCartUpperIcon()
          ],
        ),
        drawer: AppSideBar(),
        body: Container(
            color: Colors.grey,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: this.products.map((Product product) {
                return ShoppingListItem(product: product);
              }).toList(),
            )));
  }
}
