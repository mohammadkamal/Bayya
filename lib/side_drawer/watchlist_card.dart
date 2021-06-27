import 'package:bayya/watchlist/view_watch_list.dart';
import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/widget_utilities/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistCard extends StatefulWidget {
  @override
  _WatchlistCardState createState() => _WatchlistCardState();
}

class _WatchlistCardState extends State<WatchlistCard> {
  @override
  Widget build(BuildContext context) {
    int _watchlistCount =
        Provider.of<Watchlist>(context).watchlistMap.keys.length;
    return ListTile(
      title: Text('Watchlist'),
      leading: Icon(Icons.favorite, color: Colors.red),
      onTap: () => Navigator.of(context)
          .push(TweenAnimationRoute().playAnimation(ViewWatchList())),
      trailing: _watchlistCount > 0
          ? Text(_watchlistCount > 9 ? '9+' : _watchlistCount.toString())
          : null,
    );
  }
}
