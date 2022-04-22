import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../views/watchlist/view_watch_list.dart';
import '../views/watchlist/watchlist_viewmodel.dart';
import '../views/widgets/styles/tween_animation_route.dart';

class WatchlistCard extends StatelessWidget {
  const WatchlistCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _watchlistCount =
        Provider.of<WatchlistViewModel>(context, listen: false)
            .watchlistMap
            .keys
            .length;
    _watchlistCount ??= 0;
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push(TweenAnimationRoute().playAnimation(const ViewWatchList())),
        child: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.red),
            const Text('Watchlist'),
            if (_watchlistCount > 0)
              Text(_watchlistCount > 9 ? '9+' : _watchlistCount.toString())
          ],
        ));
  }
}
