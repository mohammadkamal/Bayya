import 'package:Bayya/Cart/ShoppingCartList.dart';
import 'package:flutter/material.dart';

class ShoppingCartUpperIcon extends StatefulWidget {
  _ShoppingCartUpperIconState createState() => _ShoppingCartUpperIconState();
}

class _ShoppingCartUpperIconState extends State<ShoppingCartUpperIcon> {
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart, color: Colors.white),
      onPressed: () {
        Navigator.of(context).push(_createRouteToShoppingCart());
      },
    );
  }
}
