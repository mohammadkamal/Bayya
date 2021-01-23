import 'package:flutter/material.dart';
import 'Product.dart';
import 'ShoppingCartItem.dart';

class Watchlist {
  Watchlist._privateConstructor();

  static final Watchlist _instance = Watchlist._privateConstructor();

  static Watchlist get instance => _instance;

  Map<int, Product> watchlistMap = new Map<int, Product>();

  void setWatchlisted(Product product) {
    watchlistMap[product.id] = product;
  }

  void unWatchlist(Product product) {
    watchlistMap.remove(product.id);
  }

  bool getWatchlisted(Product product) {
    return watchlistMap.containsKey(product.id);
  }
}

class ViewWatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> _list = List();
    Watchlist.instance.watchlistMap.forEach((key, value) => _list.add(value));
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _list.isNotEmpty
              ? _list.map((Product product) {
                  return ShoppingCartItem(
                    product: product,
                    inCart: _list.contains(product),
                  );
                }).toList()
              : []),
    );
  }
}
