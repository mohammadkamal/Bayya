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
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                itemCount:
                    Provider.of<Watchlist>(context).watchlistMap.keys.length,
                itemBuilder: (context, index) {
                  return WatchlistItem(
                    productId: Provider.of<Watchlist>(context)
                        .watchlistMap
                        .keys
                        .elementAt(index),
                  );
                })));
  }
}
