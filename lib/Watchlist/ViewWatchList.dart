import 'package:Bayya/Cart/ShoppingCartUpperIcon.dart';
import 'package:Bayya/Watchlist/Watchlist.dart';
import 'package:Bayya/Watchlist/WatchlistItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewWatchList extends StatelessWidget {
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
              children: Provider.of<Watchlist>(context).watchlistList.isNotEmpty
                  ? Provider.of<Watchlist>(context)
                      .watchlistList
                      .map((String productId) {
                      return WatchlistItem(
                        productId: productId,
                      );
                    }).toList()
                  : []),
        ));
  }
}
