import 'package:Bayya/SideDrawer/AccountCard.dart';
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
          DrawerHeader(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: Icon(Icons.person_outline_rounded, size: 50))
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Vistor')]),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ShoppingCartCard(),
          WatchlistCard(),
          AccountCard(),
        ],
      ),
    );
  }
}
