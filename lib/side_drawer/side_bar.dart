import 'package:bayya/side_drawer/account_card.dart';
import 'package:bayya/side_drawer/current_user_header_card.dart';
import 'package:bayya/side_drawer/shopping_cart_card.dart';
import 'package:bayya/side_drawer/watchlist_card.dart';
import 'package:flutter/material.dart';

class AppSideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          CurrentUserHeaderCard(),
          ShoppingCartCard(),
          WatchlistCard(),
          AccountCard(),
        ],
      ),
    );
  }
}
