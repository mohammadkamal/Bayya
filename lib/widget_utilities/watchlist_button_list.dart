import 'package:bayya/watchlist/watchlist.dart';
import 'package:bayya/widget_utilities/sign_in_to_perfom_action.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistButtonList extends StatefulWidget {
  final String productId;

  const WatchlistButtonList({Key key, @required this.productId})
      : super(key: key);

  @override
  _WatchlistButtonListState createState() => _WatchlistButtonListState();
}

class _WatchlistButtonListState extends State<WatchlistButtonList> {
  Icon _iconWatchlist;
  
  @override
  Widget build(BuildContext context) {
    _iconWatchlist =
        Provider.of<Watchlist>(context).getWatchlisted(widget.productId)
            ? Icon(Icons.favorite, color: Colors.red)
            : Icon(Icons.favorite_border_outlined);
    return GestureDetector(
        onTap: () {
          if (FirebaseAuth.instance.currentUser != null) {
            context.read<Watchlist>().getWatchlisted(widget.productId)
                ? context.read<Watchlist>().unWatchlist(widget.productId)
                : context.read<Watchlist>().setWatchlisted(widget.productId);
          } else {
            showDialog(
                context: context, builder: (context) => SignInToPerfomAction());
          }
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1), color: Colors.grey[400]),
          child: Column(
            children: [_iconWatchlist],
          ),
        ));
  }
}
