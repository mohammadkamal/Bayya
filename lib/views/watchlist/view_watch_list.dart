import 'package:bayya/views/watchlist/watchlist_item.dart';
import 'package:bayya/views/watchlist/watchlist_viewmodel.dart';
import 'package:bayya/views/widgets/mixed_widgets/shopping_cart_upper_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewWatchList extends StatefulWidget {
  const ViewWatchList({Key key}) : super(key: key);

  @override
  _ViewWatchListState createState() => _ViewWatchListState();
}

class _ViewWatchListState extends State<ViewWatchList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          actions: const <Widget>[ShoppingCartUpperIcon()],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: Provider.of<WatchlistViewModel>(context)
                .watchlistMap
                .keys
                .length,
            itemBuilder: (context, index) {
              return WatchlistItem(
                  productId: Provider.of<WatchlistViewModel>(context)
                      .watchlistMap
                      .keys
                      .elementAt(index));
            }));
  }
}
