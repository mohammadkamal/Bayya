import 'package:bayya/cart/shopping_cart.dart';
import 'package:bayya/cart/shopping_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartCard extends StatefulWidget {
  @override
  _ShoppingCartCardState createState() => _ShoppingCartCardState();
}

class _ShoppingCartCardState extends State<ShoppingCartCard> {
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
    int cartCount =
        Provider.of<ShoppingCart>(context).shoppingItemQuantites.keys.length;
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
}
