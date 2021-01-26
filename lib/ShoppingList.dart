import 'package:flutter/material.dart';
import 'Product.dart';
import 'ShoppingCartList.dart';
import 'ShoppingListItem.dart';
import 'SideBar.dart';

class ShoppingList extends StatelessWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  Route _createRouteToShoppingCart() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ShoppingCartList(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

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
            IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(_createRouteToShoppingCart());
                },)
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
