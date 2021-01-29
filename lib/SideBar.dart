import 'package:Bayya/Cart/ShoppingCart.dart';
import 'package:Bayya/Cart/ShoppingCartList.dart';
import 'package:Bayya/Watchlist/ViewWatchList.dart';
import 'package:Bayya/Watchlist/Watchlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppSideBar extends StatefulWidget {
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
                  children: [
                    Icon(Icons.person_pin_circle, size: 50),
                  ],
                ),
                Column(children: [Text('Vistor')])
              ],
            ),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          _shoppingCartCard(),
          _watchlistCard(),
          ListTile(
            title: Text('Account'),
            leading: Icon(Icons.person, color: Colors.grey),
            onTap: null,
          ),
        ],
      ),
    );
  }

  Route _createRouteToShoppingCart() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ShoppingCartList(),
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

  Widget _shoppingCartCard() {
    int cartCount = Provider.of<ShoppingCart>(context).shoppingCartMap.length;
    return ListTile(
        title: Text('Shopping Cart'),
        leading: Icon(Icons.shopping_cart, color: Colors.lightGreen),
        onTap: () {
          Navigator.of(context).push(_createRouteToShoppingCart());
        },
        trailing: cartCount > 0
            ? CircleAvatar(
                backgroundColor: Colors.red,
                radius: 12,
                child: Text(
                  cartCount > 9 ? '9+' : cartCount.toString(),
                  style: TextStyle(color: Colors.white),
                ))
            : null);
  }

  Widget _watchlistCard() {
    int _watchlistCount = Provider.of<Watchlist>(context).watchlistMap.length;
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
