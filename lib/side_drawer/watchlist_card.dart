import 'package:bayya/views/watchlist/view_watch_list.dart';
import 'package:bayya/views/watchlist/watchlist_viewmodel.dart';
import 'package:bayya/views/widgets/styles/tween_animation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _watchlistCount =
        Provider.of<WatchlistViewModel>(context, listen: false)
            .watchlistMap
            .keys
            .length;
    if (_watchlistCount == null) _watchlistCount = 0;
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push(TweenAnimationRoute().playAnimation(ViewWatchList())),
        child: Row(
          children: [
            Icon(Icons.favorite, color: Colors.red),
            Text('Watchlist'),
            if (_watchlistCount > 0)
              Text(_watchlistCount > 9 ? '9+' : _watchlistCount.toString())
          ],
        ));
    return ListTile(
      title: Text('Watchlist'),
      leading: Icon(Icons.favorite, color: Colors.red),
      onTap: () => Navigator.of(context)
          .push(TweenAnimationRoute().playAnimation(ViewWatchList())),
      trailing: _watchlistCount > 0
          ? Text(_watchlistCount > 9 ? '9+' : _watchlistCount.toString())
          : Container(),
    );
  }
}
