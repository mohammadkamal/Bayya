
import 'package:Bayya/ShoppingCart.dart';
import 'package:Bayya/Watchlist.dart';
import 'package:flutter/material.dart';

class AppSideBar extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
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
              ListTile(
                  title: Text('Shopping Cart'),
                  leading: Icon(Icons.shopping_cart, color: Colors.lightGreen),
                  onTap: () {
                    Navigator.of(context).push(_createRouteToShoppingCart());
                  }),
              ListTile(
                title: Text('Watchlist'),
                leading: Icon(Icons.favorite, color: Colors.red),
                onTap: () {
                  Navigator.of(context).push(_createRouteToWatchlist());
                },
              ),
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
}