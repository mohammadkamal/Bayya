import 'package:flutter/material.dart';

import 'Product.dart';
import 'ShoppingCartList.dart';
import 'Watchlist.dart';
import 'WatchlistItem.dart';

class ViewWatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> _list = List();
    Watchlist.instance.watchlistMap.forEach((key, value) => _list.add(value));
    return Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(_createRouteToShoppingCart());
                })
          ],
        ),
        body: Container(
          color: Colors.grey,
          child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: _list.isNotEmpty
                  ? _list.map((Product product) {
                      return WatchlistItem(
                        product: product,
                      );
                    }).toList()
                  : []),
        ));
  }

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
}
