import 'package:Bayya/SideDrawer/AccountCard.dart';
import 'package:Bayya/SideDrawer/CurrentUserHeaderCard.dart';
import 'package:Bayya/SideDrawer/ShoppingCartCard.dart';
import 'package:Bayya/SideDrawer/WatchlistCard.dart';
import 'package:flutter/material.dart';

class AppSideBar extends StatefulWidget {
  @override
  _AppSideBarState createState() => _AppSideBarState();
}

class _AppSideBarState extends State<AppSideBar> {
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
