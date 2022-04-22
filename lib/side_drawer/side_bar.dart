import 'package:flutter/material.dart';

import 'account_card.dart';
import 'current_user_header_card.dart';
import 'shopping_cart_card.dart';
import 'watchlist_card.dart';

class AppSideBar extends StatelessWidget {
  const AppSideBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          CurrentUserHeaderCard(),
          ShoppingCartCard(),
          WatchlistCard(),
          AccountCard(),
        ],
      ),
    );
  }
}
