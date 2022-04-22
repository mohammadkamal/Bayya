import 'package:bayya/views/watchlist/watchlist_viewmodel.dart';
import 'package:bayya/views/widgets/stateless_widgets/sign_in_to_perfom_action.dart';
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
  Widget __iconWatchlist(bool isWatchlisted) {
    if (isWatchlisted) {
      return const Icon(Icons.favorite, color: Colors.red);
    } else {
      return const Icon(Icons.favorite_border_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    WatchlistViewModel watchlistViewModel =
        Provider.of<WatchlistViewModel>(context);
    return GestureDetector(
        onTap: () {
          if (FirebaseAuth.instance.currentUser != null) {
            watchlistViewModel.isInWatchlist(widget.productId)
                ? watchlistViewModel.removeFromWatchlist(widget.productId)
                : watchlistViewModel.addToWatchlist(widget.productId);
          } else {
            showDialog(
                context: context, builder: (context) => const SignInToPerfomAction());
          }
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1), color: Colors.grey[400]),
          child: Column(
            children: [
              __iconWatchlist(
                  watchlistViewModel.isInWatchlist(widget.productId))
            ],
          ),
        ));
  }
}
