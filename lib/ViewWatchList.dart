import 'package:Bayya/Cart/ShoppingCartUpperIcon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Product.dart';
import 'Watchlist.dart';
import 'WatchlistItem.dart';

class ViewWatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> _list = List();
    Provider.of<Watchlist>(context)
        .watchlistMap
        .forEach((key, value) => _list.add(value));
    return Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          actions: <Widget>[
            ShoppingCartUpperIcon()
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
}
