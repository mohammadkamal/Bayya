import 'package:Bayya/Watchlist/ViewWatchList.dart';
import 'package:Bayya/Watchlist/Watchlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistCard extends StatefulWidget
{
  @override
  _WatchlistCardState createState() => _WatchlistCardState();
}

class _WatchlistCardState extends State<WatchlistCard>
{
  Route _createRouteToWatchlist() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ViewWatchList(),
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

  @override
  Widget build(BuildContext context)
  {
    int _watchlistCount = Provider.of<Watchlist>(context).watchlistMap.keys.length;
    return ListTile(
      title: Text('Watchlist'),
      leading: Icon(Icons.favorite, color: Colors.red),
      onTap: () {
        Navigator.of(context).push(_createRouteToWatchlist());
      },
      trailing: _watchlistCount > 0
          ? Text(_watchlistCount > 9 ? '9+' : _watchlistCount.toString())
          : null,
    );
  }
}