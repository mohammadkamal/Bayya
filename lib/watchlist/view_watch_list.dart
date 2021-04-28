import 'package:bayya/cart/shopping_cart_upper_icon.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/watchlist/watchlist_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewWatchList extends StatefulWidget {
  @override
  _ViewWatchListState createState() => _ViewWatchListState();
}

class _ViewWatchListState extends State<ViewWatchList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          actions: <Widget>[ShoppingCartUpperIcon()],
        ),
        body: Container(
          color: Colors.grey,
          child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              children: Provider.of<Watchlist>(context).watchlistMap.isNotEmpty
                  ? Provider.of<Watchlist>(context)
                      .watchlistMap
                      .keys
                      .map((productId) {
                      return WatchlistItem(
                        productId: productId,
                      );
                    }).toList()
                  : []),
        ));
  }
}
